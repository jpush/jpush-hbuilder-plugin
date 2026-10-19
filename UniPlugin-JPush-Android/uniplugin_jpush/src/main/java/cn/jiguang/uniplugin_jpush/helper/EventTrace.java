package cn.jiguang.uniplugin_jpush.helper;

/** Optional diagnostics; logging must not change event delivery. */
public interface EventTrace {
    void log(String message);

    static void write(EventTrace trace, String message) {
        if (trace == null) return;
        try {
            trace.log(message);
        } catch (RuntimeException ignored) {
            // A diagnostic sink must not interrupt a callback or queue operation.
        }
    }

    static String ownerId(Object owner) {
        return owner == null ? "none" : Integer.toHexString(System.identityHashCode(owner));
    }
}
