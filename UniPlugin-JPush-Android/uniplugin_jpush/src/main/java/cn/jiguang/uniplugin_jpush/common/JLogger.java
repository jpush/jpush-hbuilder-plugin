package cn.jiguang.uniplugin_jpush.common;


import android.util.Log;

public class JLogger {

    public static final String TAG = "Uniapp-JPush";
    public static final String PLUGIN_VERSION = "1.2.8";

    private static volatile boolean isLoggerEnable = false;

    public static void setLoggerEnable(boolean loggerEnable) {
        Log.d(TAG, "setLoggerEnable:" + loggerEnable);
        isLoggerEnable = loggerEnable;
        if (loggerEnable) {
            Log.d(TAG, "JG-JPush native plugin version=" + PLUGIN_VERSION
                    + ", eventCache=enabled, initialStateQuery=enabled");
        }
    }

    public static void i(String msg) {
        if (isLoggerEnable) {
            Log.i(TAG, msg);
        }
    }

    public static void d(String msg) {
        if (isLoggerEnable) {
            Log.d(TAG, msg);
        }
    }

    public static void v(String msg) {
        if (isLoggerEnable) {
            Log.v(TAG, msg);
        }
    }

    public static void w(String msg) {
        if (isLoggerEnable) {
            Log.w(TAG, msg);
        }
    }

    public static void e(String error) {
        if (isLoggerEnable) {
            Log.e(TAG, error);
        }
    }

}

