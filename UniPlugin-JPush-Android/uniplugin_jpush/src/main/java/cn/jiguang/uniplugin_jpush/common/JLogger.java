package cn.jiguang.uniplugin_jpush.common;


import android.app.Application;
import android.content.Context;
import android.os.Build;
import android.text.TextUtils;
import android.util.Log;

import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.Method;

public class JLogger {

    public static final String TAG = "Uniapp-JPush";

    private static boolean isLoggerEnable = true;

    public static void setLoggerEnable(boolean loggerEnable) {
        Log.d(getTag(), "setLoggerEnable:" + loggerEnable);
//        isLoggerEnable = loggerEnable;
    }

    private static String getTag() {
        String curProcessName = getCurProcessName();
        if (TextUtils.isEmpty(curProcessName)) {
            return TAG;
        }
        return TAG + "-" + curProcessName;
    }

    private static String curProcessName;
    public static String getCurProcessName() {
        if (!TextUtils.isEmpty(curProcessName)) {
            return curProcessName;
        }
        try {
            if (Build.VERSION.SDK_INT >= 28) {
                curProcessName = Application.getProcessName();
                if (!TextUtils.isEmpty(curProcessName)) {
                    return curProcessName;
                }
            }

            curProcessName = getCurrentProcessNameByActivityThread();
            if (!TextUtils.isEmpty(curProcessName)) {
                return curProcessName;
            }

            curProcessName = getCurProcessNameByCmd();
        } catch (Throwable e) {
            Log.w(TAG, "#unexcepted - getCurProcessName failed:" + e.getMessage());
        }
        return curProcessName;
    }
    public static String getCurProcessNameByCmd() {
        StringBuilder processName = new StringBuilder();
        try (FileInputStream in = new FileInputStream("/proc/self/cmdline")) {
            byte[] buffer = new byte[256];
            int len;
            while ((len = in.read(buffer)) > 0) {
                for (int i = 0; i < len; i++) {
                    if (buffer[i] == 0) {
                        break;
                    }
                    processName.append((char) buffer[i]);
                }
            }
        } catch (IOException e) {
            return "";
        }
        return processName.toString();
    }

    /**
     * 通过反射ActivityThread获取进程名，避免了ipc android 19(4.4)以上才有这个方法
     */
    public static String getCurrentProcessNameByActivityThread() {
        String processName = null;
        try {
            final Method declaredMethod = Class.forName("android.app.ActivityThread", false, Application.class.getClassLoader())
                    .getDeclaredMethod("currentProcessName", (Class<?>[]) new Class[0]);
            declaredMethod.setAccessible(true);
            final Object invoke = declaredMethod.invoke(null, new Object[0]);
            if (invoke instanceof String) {
                processName = (String) invoke;
            }
        } catch (Throwable e) {
            Log.w(TAG, "getCurrentProcessNameByActivityThread: " + e.getMessage());
        }
        return processName;
    }

    public static void i(String msg) {
        if (isLoggerEnable) {
            Log.i(getTag(), msg);
        }
    }

    public static void d(String msg) {
        if (isLoggerEnable) {
            Log.d(getTag(), msg);
        }
    }

    public static void v(String msg) {
        if (isLoggerEnable) {
            Log.v(getTag(), msg);
        }
    }

    public static void w(String msg) {
        if (isLoggerEnable) {
            Log.w(getTag(), msg);
        }
    }

    public static void e(String error) {
        if (isLoggerEnable) {
            Log.e(getTag(), error);
        }
    }

}

