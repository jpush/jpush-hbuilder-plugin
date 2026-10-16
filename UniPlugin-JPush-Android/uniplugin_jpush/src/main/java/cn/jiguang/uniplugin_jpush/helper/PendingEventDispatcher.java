package cn.jiguang.uniplugin_jpush.helper;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;

/** Process-local FIFO queues for native events whose JS listeners arrive later. */
public final class PendingEventDispatcher<T> {
    public interface Listener<T> {
        // True means accepted by the bridge, not acknowledged by JS business code.
        boolean onEvent(T event);
    }

    public interface OverflowListener {
        void onOverflow(String eventName);
    }

    private static final class Channel<T> {
        Object owner;
        Listener<T> listener;
        final LinkedList<T> pending = new LinkedList<>();
        boolean draining;
    }

    private final Map<String, Channel<T>> channels = new HashMap<>();
    private final int limit;
    private final OverflowListener overflowListener;

    public PendingEventDispatcher(int limit, OverflowListener overflowListener) {
        if (limit < 1) throw new IllegalArgumentException("limit must be positive");
        this.limit = limit;
        this.overflowListener = overflowListener;
    }

    public synchronized void register(String eventName, Object owner, Listener<T> listener) {
        if (eventName == null || eventName.isEmpty() || owner == null || listener == null) return;
        Channel<T> channel = channel(eventName);
        channel.owner = owner;
        channel.listener = listener;
        drain(channel);
    }

    public synchronized void publish(String eventName, T event) {
        if (eventName == null || eventName.isEmpty() || event == null) return;
        Channel<T> channel = channel(eventName);
        if (channel.pending.size() >= limit) {
            // A reentrant publish must not evict the event currently being delivered.
            int oldestWaiting = channel.draining ? 1 : 0;
            if (overflowListener != null) overflowListener.onOverflow(eventName);
            if (oldestWaiting >= channel.pending.size()) return;
            channel.pending.remove(oldestWaiting);
        }
        channel.pending.addLast(event);
        drain(channel);
    }

    public synchronized void unregister(Object owner) {
        for (Channel<T> channel : channels.values()) {
            if (channel.owner == owner) {
                channel.owner = null;
                channel.listener = null;
            }
        }
    }

    private Channel<T> channel(String eventName) {
        Channel<T> channel = channels.get(eventName);
        if (channel == null) {
            channel = new Channel<>();
            channels.put(eventName, channel);
        }
        return channel;
    }

    // Called under the dispatcher lock: registration, delivery and destruction
    // cannot interleave and replay an event twice. Reentrant events queue behind it.
    private void drain(Channel<T> channel) {
        if (channel.draining) return;
        channel.draining = true;
        try {
            while (channel.listener != null && !channel.pending.isEmpty()) {
                if (!channel.listener.onEvent(channel.pending.getFirst())) break;
                channel.pending.removeFirst();
            }
        } finally {
            channel.draining = false;
        }
    }
}
