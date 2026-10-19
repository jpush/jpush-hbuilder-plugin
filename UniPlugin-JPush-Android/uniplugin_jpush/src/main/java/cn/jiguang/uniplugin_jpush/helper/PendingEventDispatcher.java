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
    private final EventTrace trace;

    public PendingEventDispatcher(int limit, OverflowListener overflowListener) {
        this(limit, overflowListener, null);
    }

    public PendingEventDispatcher(int limit, OverflowListener overflowListener, EventTrace trace) {
        if (limit < 1) throw new IllegalArgumentException("limit must be positive");
        this.limit = limit;
        this.overflowListener = overflowListener;
        this.trace = trace;
    }

    public synchronized void register(String eventName, Object owner, Listener<T> listener) {
        if (eventName == null || eventName.isEmpty() || owner == null || listener == null) return;
        Channel<T> channel = channel(eventName);
        EventTrace.write(trace, "event register type=" + eventName + " owner=" + EventTrace.ownerId(owner)
                + " pending=" + channel.pending.size() + " replaced=" + (channel.listener != null));
        channel.owner = owner;
        channel.listener = listener;
        drain(eventName, channel, "register");
    }

    public synchronized void publish(String eventName, T event) {
        if (eventName == null || eventName.isEmpty() || event == null) return;
        Channel<T> channel = channel(eventName);
        EventTrace.write(trace, "event received type=" + eventName + " listener="
                + (channel.listener != null) + " pendingBefore=" + channel.pending.size());
        if (channel.pending.size() >= limit) {
            // A reentrant publish must not evict the event currently being delivered.
            int oldestWaiting = channel.draining ? 1 : 0;
            if (overflowListener != null) overflowListener.onOverflow(eventName);
            EventTrace.write(trace, "event overflow type=" + eventName + " pending="
                    + channel.pending.size() + " inFlight=" + channel.draining);
            if (oldestWaiting >= channel.pending.size()) return;
            channel.pending.remove(oldestWaiting);
        }
        channel.pending.addLast(event);
        if (channel.listener == null) {
            EventTrace.write(trace, "event cached type=" + eventName + " pending=" + channel.pending.size());
        }
        drain(eventName, channel, "event");
    }

    public synchronized void unregister(Object owner) {
        for (Map.Entry<String, Channel<T>> entry : channels.entrySet()) {
            Channel<T> channel = entry.getValue();
            if (channel.owner == owner) {
                EventTrace.write(trace, "event listener removed type=" + entry.getKey()
                        + " owner=" + EventTrace.ownerId(owner) + " pending=" + channel.pending.size());
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
    private void drain(String eventName, Channel<T> channel, String trigger) {
        if (channel.draining) {
            EventTrace.write(trace, "event drain deferred type=" + eventName + " reason=reentrant");
            return;
        }
        channel.draining = true;
        try {
            while (channel.listener != null && !channel.pending.isEmpty()) {
                EventTrace.write(trace, "event dispatch type=" + eventName + " trigger=" + trigger
                        + " pending=" + channel.pending.size() + " owner=" + EventTrace.ownerId(channel.owner));
                if (!channel.listener.onEvent(channel.pending.getFirst())) {
                    EventTrace.write(trace, "event retained type=" + eventName + " pending=" + channel.pending.size());
                    break;
                }
                channel.pending.removeFirst();
                EventTrace.write(trace, "event consumed type=" + eventName + " remaining=" + channel.pending.size());
            }
        } finally {
            channel.draining = false;
        }
    }
}
