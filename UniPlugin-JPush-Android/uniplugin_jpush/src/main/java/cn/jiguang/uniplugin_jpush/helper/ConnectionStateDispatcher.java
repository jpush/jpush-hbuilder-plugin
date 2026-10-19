package cn.jiguang.uniplugin_jpush.helper;

/** Keeps the latest SDK connection state for listeners registered later. */
public final class ConnectionStateDispatcher {
    public interface Listener {
        void onState(boolean connected);
    }

    private Boolean latestState;
    private Object owner;
    private Listener listener;
    private final EventTrace trace;

    public ConnectionStateDispatcher() {
        this(null);
    }

    public ConnectionStateDispatcher(EventTrace trace) {
        this.trace = trace;
    }

    // Registration/replay and updates share the lock so a stale replay cannot
    // overtake a newer SDK event. No state is persisted across process restarts.
    public synchronized void register(Object owner, Listener listener) {
        if (owner == null || listener == null) return;
        EventTrace.write(trace, "connect register owner=" + EventTrace.ownerId(owner)
                + " replaced=" + (this.listener != null) + " cachedState=" + latestState);
        this.owner = owner;
        this.listener = listener;
        if (latestState != null) {
            EventTrace.write(trace, "connect replay state=" + latestState
                    + " owner=" + EventTrace.ownerId(owner));
            listener.onState(latestState);
        }
    }

    public synchronized void update(boolean connected) {
        latestState = connected;
        EventTrace.write(trace, "connect state stored state=" + connected
                + " listener=" + (listener != null) + " owner=" + EventTrace.ownerId(owner));
        if (listener != null) listener.onState(connected);
    }

    public synchronized boolean hasState() {
        return latestState != null;
    }

    // A delayed initial snapshot must never overwrite a newer SDK callback.
    public synchronized boolean initializeIfUnknown(boolean connected) {
        if (latestState != null) {
            EventTrace.write(trace, "connect query ignored current=" + latestState
                    + " queried=" + connected);
            return false;
        }
        EventTrace.write(trace, "connect query accepted state=" + connected);
        update(connected);
        return true;
    }

    public synchronized void unregister(Object owner) {
        if (this.owner == owner) {
            EventTrace.write(trace, "connect listener removed owner=" + EventTrace.ownerId(owner)
                    + " cachedState=" + latestState);
            this.owner = null;
            listener = null;
        } else {
            EventTrace.write(trace, "connect remove ignored owner=" + EventTrace.ownerId(owner)
                    + " activeOwner=" + EventTrace.ownerId(this.owner));
        }
    }
}
