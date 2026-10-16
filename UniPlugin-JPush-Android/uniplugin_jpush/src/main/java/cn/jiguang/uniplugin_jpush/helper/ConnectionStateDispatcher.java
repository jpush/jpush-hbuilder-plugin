package cn.jiguang.uniplugin_jpush.helper;

/** Keeps the latest SDK connection state for listeners registered later. */
public final class ConnectionStateDispatcher {
    public interface Listener {
        void onState(boolean connected);
    }

    private Boolean latestState;
    private Object owner;
    private Listener listener;

    // Registration/replay and updates share the lock so a stale replay cannot
    // overtake a newer SDK event. No state is persisted across process restarts.
    public synchronized void register(Object owner, Listener listener) {
        if (owner == null || listener == null) return;
        this.owner = owner;
        this.listener = listener;
        if (latestState != null) listener.onState(latestState);
    }

    public synchronized void update(boolean connected) {
        latestState = connected;
        if (listener != null) listener.onState(connected);
    }

    public synchronized void unregister(Object owner) {
        if (this.owner == owner) {
            this.owner = null;
            listener = null;
        }
    }
}
