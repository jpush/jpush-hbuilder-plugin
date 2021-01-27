package cn.jiguang.uniplugin_jpush;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.os.Bundle;
import android.text.TextUtils;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.taobao.weex.bridge.JSCallback;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import cn.jiguang.uniplugin_jpush.common.JConstants;
import cn.jiguang.uniplugin_jpush.common.JLogger;
import cn.jiguang.uniplugin_jpush.helper.JPushHelper;
import cn.jiguang.uniplugin_jpush.receiver.JPushBroadcastReceiver;
import cn.jiguang.uniplugin_jpush.receiver.JPushModuleReceiver;
import cn.jpush.android.api.BasicPushNotificationBuilder;
import cn.jpush.android.api.JPushInterface;
import cn.jpush.android.data.JPushLocalNotification;
import io.dcloud.feature.uniapp.annotation.UniJSMethod;
import io.dcloud.feature.uniapp.common.UniDestroyableModule;

public class JPushModule extends UniDestroyableModule {


    public static boolean isAppForeground = false;
    public static Context uniContext = null;

    public void updatePluginStatu() {
        uniContext = mWXSDKInstance.getContext();
        JPushHelper.IS_DESTROY = false;
    }

    @UniJSMethod(uiThread = true)
    public void setLoggerEnable(boolean enable) {
        updatePluginStatu();
        JPushInterface.setDebugMode(enable);
        JLogger.setLoggerEnable(enable);
    }

    @UniJSMethod(uiThread = true)
    public void initJPushService() {
        updatePluginStatu();
        JPushInterface.init(mWXSDKInstance.getContext());
        if (JPushBroadcastReceiver.NOTIFICATION_BUNDLE != null) {
            JSONObject jsonObject = JPushHelper.convertNotificationBundleToMap(JConstants.NOTIFICATION_OPENED, JPushBroadcastReceiver.NOTIFICATION_BUNDLE);
            JPushHelper.sendEvent(JConstants.NOTIFICATION_EVENT, jsonObject);
            JPushBroadcastReceiver.NOTIFICATION_BUNDLE = null;
        }
    }

    @UniJSMethod(uiThread = true)
    public void stopPush() {
        updatePluginStatu();
        JPushInterface.stopPush(mWXSDKInstance.getContext());
    }

    @UniJSMethod(uiThread = true)
    public void resumePush() {
        updatePluginStatu();
        JPushInterface.resumePush(mWXSDKInstance.getContext());
    }

    @UniJSMethod(uiThread = true)
    public void isPushStopped(JSCallback callback) {
        updatePluginStatu();
        boolean isPushStopped = JPushInterface.isPushStopped(mWXSDKInstance.getContext());
        if (callback == null) {
            JLogger.w(JConstants.CALLBACK_NULL);
            return;
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put(JConstants.CODE, isPushStopped ? 0 : 1);
        callback.invoke(jsonObject);
    }

    @UniJSMethod(uiThread = true)
    public void setChannel(JSONObject readableMap) {
        updatePluginStatu();
        if (readableMap == null) {
            JLogger.w(JConstants.PARAMS_NULL);
            return;
        }
        String channel = readableMap.getString(JConstants.CHANNEL);
        if (TextUtils.isEmpty(channel)) {
            JLogger.w(JConstants.PARAMS_ILLEGAL);
        } else {
            JPushInterface.setChannel(mWXSDKInstance.getContext(), channel);
        }
    }

    @UniJSMethod(uiThread = true)
    public void setPushTime(JSONObject readableMap) {
        updatePluginStatu();
        if (readableMap == null) {
            JLogger.w(JConstants.PARAMS_NULL);
            return;
        }
        JSONArray readableArray = readableMap.getJSONArray(JConstants.PUSH_TIME_DAYS);
        int startHour = readableMap.getIntValue(JConstants.PUSH_TIME_START_HOUR);
        int endHour = readableMap.getIntValue(JConstants.PUSH_TIME_END_HOUR);
        if (readableArray == null || startHour < 0 || startHour > 23 || endHour < 0 || endHour > 23) {
            JLogger.w(JConstants.PARAMS_NULL);
            return;
        }
        Set<Integer> days = new HashSet<Integer>();
        for (int i = 0; i < readableArray.size(); i++) {
            int day = readableArray.getIntValue(i);
            if (day > 6 || day < 0) {
                JLogger.w(JConstants.PARAMS_NULL);
                return;
            }
            days.add(day);
        }
        JPushInterface.setPushTime(mWXSDKInstance.getContext(), days, startHour, endHour);
    }

    @UniJSMethod(uiThread = true)
    public void setSilenceTime(JSONObject readableMap) {
        updatePluginStatu();
        if (readableMap == null) {
            JLogger.w(JConstants.PARAMS_NULL);
            return;
        }
        int startHour = readableMap.getIntValue(JConstants.SILENCE_TIME_START_HOUR);
        int startMinute = readableMap.getIntValue(JConstants.SILENCE_TIME_START_MINUTE);
        int endHour = readableMap.getIntValue(JConstants.SILENCE_TIME_END_HOUR);
        int endMinute = readableMap.getIntValue(JConstants.SILENCE_TIME_END_MINUTE);
        if (startHour == 0 || startMinute == 0 || endHour == 0 || endMinute == 0) {
            JLogger.w(JConstants.PARAMS_NULL);
            return;
        }
        JPushInterface.setSilenceTime(mWXSDKInstance.getContext(), startHour, startMinute, endHour, endMinute);
    }

    @UniJSMethod(uiThread = true)
    public void getRegistrationID(JSCallback callback) {
        updatePluginStatu();
        if (callback == null) {
            JLogger.w(JConstants.CALLBACK_NULL);
            return;
        }
        String registrationID = JPushInterface.getRegistrationID(mWXSDKInstance.getContext());
        JSONObject jsonObject = new JSONObject();
        jsonObject.put(JConstants.REGISTRATION_ID, registrationID);
        jsonObject.put(JConstants.CODE, JConstants.CODE_SUCESS);
        callback.invoke(jsonObject);
    }

    @UniJSMethod(uiThread = true)
    public void getUdid(JSCallback callback) {
        updatePluginStatu();
        if (callback == null) {
            JLogger.w(JConstants.CALLBACK_NULL);
            return;
        }
        String udid = JPushInterface.getUdid(mWXSDKInstance.getContext());
        callback.invoke(udid);
    }

    @UniJSMethod(uiThread = true)
    public void setLatestNotificationNumber(JSONObject readableMap) {
        updatePluginStatu();
        if (readableMap == null) {
            JLogger.w(JConstants.PARAMS_NULL);
            return;
        }
        if (readableMap.containsKey(JConstants.NOTIFICATION_MAX_NUMBER)) {
            int maxNumber = readableMap.getIntValue(JConstants.NOTIFICATION_MAX_NUMBER);
            JPushInterface.setLatestNotificationNumber(mWXSDKInstance.getContext(), maxNumber);
        } else {
            JLogger.w("there are no " + JConstants.NOTIFICATION_MAX_NUMBER);
        }
    }

    @UniJSMethod(uiThread = true)
    public void setDefaultPushNotificationBuilder(JSONObject readableMap) {
        updatePluginStatu();
        if (readableMap == null) {
            JLogger.w(JConstants.PARAMS_NULL);
            return;
        }
        BasicPushNotificationBuilder builder = new BasicPushNotificationBuilder(mWXSDKInstance.getContext());
        JPushInterface.setDefaultPushNotificationBuilder(builder);
    }

    @UniJSMethod(uiThread = true)
    public void filterValidTags(JSONObject readableMap, JSCallback callback) {
        updatePluginStatu();
        if (readableMap == null) {
            JLogger.w(JConstants.PARAMS_NULL);
            return;
        }
        if (readableMap.containsKey(JConstants.TAGS)) {
            JSONArray tags = readableMap.getJSONArray(JConstants.TAGS);
            Set<String> tagSet = new HashSet<>();
            for (int i = 0; i < tags.size(); i++) {
                String tag = tags.getString(i);
                tagSet.add(tag);
            }
            JPushInterface.filterValidTags(tagSet);
        } else {
            JLogger.w("there are no " + JConstants.TAGS);
        }
    }

    @UniJSMethod(uiThread = true)
    public void updateTags(JSONObject readableMap) {
        updatePluginStatu();
        if (readableMap == null) {
            JLogger.w(JConstants.PARAMS_NULL);
            return;
        }
        if (readableMap.containsKey(JConstants.TAGS)) {
            JSONArray tags = readableMap.getJSONArray(JConstants.TAGS);
            int sequence = readableMap.getIntValue(JConstants.SEQUENCE);
            Set<String> tagSet = new HashSet<>();
            for (int i = 0; i < tags.size(); i++) {
                String tag = tags.getString(i);
                tagSet.add(tag);
            }
            JPushInterface.setTags(mWXSDKInstance.getContext(), sequence, tagSet);
        } else {
            JLogger.w("there are no " + JConstants.TAGS);
        }
    }

    @UniJSMethod(uiThread = true)
    public void addTags(JSONObject readableMap) {
        updatePluginStatu();
        if (readableMap == null) {
            JLogger.w(JConstants.PARAMS_NULL);
            return;
        }
        if (readableMap.containsKey(JConstants.TAGS)) {
            JSONArray tags = readableMap.getJSONArray(JConstants.TAGS);
            int sequence = readableMap.getIntValue(JConstants.SEQUENCE);
            Set<String> tagSet = new HashSet<>();
            for (int i = 0; i < tags.size(); i++) {
                String tag = tags.getString(i);
                tagSet.add(tag);
            }
            JPushInterface.addTags(mWXSDKInstance.getContext(), sequence, tagSet);
        } else {
            JLogger.w("there are no " + JConstants.TAGS);
        }
    }

    @UniJSMethod(uiThread = true)
    public void deleteTags(JSONObject readableMap) {
        updatePluginStatu();
        if (readableMap == null) {
            JLogger.w(JConstants.PARAMS_NULL);
            return;
        }
        if (readableMap.containsKey(JConstants.TAGS)) {
            JSONArray tags = readableMap.getJSONArray(JConstants.TAGS);
            int sequence = readableMap.getIntValue(JConstants.SEQUENCE);
            Set<String> tagSet = new HashSet<>();
            for (int i = 0; i < tags.size(); i++) {
                String tag = tags.getString(i);
                tagSet.add(tag);
            }
            JPushInterface.deleteTags(mWXSDKInstance.getContext(), sequence, tagSet);
        } else {
            JLogger.w("there are no " + JConstants.TAGS);
        }
    }

    @UniJSMethod(uiThread = true)
    public void cleanTags(JSONObject readableMap) {
        updatePluginStatu();
        if (readableMap == null) {
            JLogger.w(JConstants.PARAMS_NULL);
            return;
        }
        int sequence = readableMap.getIntValue(JConstants.SEQUENCE);
        JPushInterface.cleanTags(mWXSDKInstance.getContext(), sequence);
    }

    @UniJSMethod(uiThread = true)
    public void queryTag(JSONObject readableMap) {
        updatePluginStatu();
        if (readableMap == null) {
            JLogger.w(JConstants.PARAMS_NULL);
            return;
        }
        int sequence = readableMap.getIntValue(JConstants.SEQUENCE);
        String tag = readableMap.getString(JConstants.TAG);
        JPushInterface.checkTagBindState(mWXSDKInstance.getContext(), sequence, tag);
    }

    @UniJSMethod(uiThread = true)
    public void getAllTags(JSONObject readableMap) {
        updatePluginStatu();
        if (readableMap == null) {
            JLogger.w(JConstants.PARAMS_NULL);
            return;
        }
        int sequence = readableMap.getIntValue(JConstants.SEQUENCE);
        JPushInterface.getAllTags(mWXSDKInstance.getContext(), sequence);
    }


    @UniJSMethod(uiThread = true)
    public void setAlias(JSONObject readableMap) {
        updatePluginStatu();
        if (readableMap == null) {
            JLogger.w(JConstants.PARAMS_NULL);
            return;
        }
        int sequence = readableMap.getIntValue(JConstants.SEQUENCE);
        String alias = readableMap.getString(JConstants.ALIAS);
        JPushInterface.setAlias(mWXSDKInstance.getContext(), sequence, alias);
    }

    @UniJSMethod(uiThread = true)
    public void deleteAlias(JSONObject readableMap) {
        updatePluginStatu();
        if (readableMap == null) {
            JLogger.w(JConstants.PARAMS_NULL);
            return;
        }
        int sequence = readableMap.getIntValue(JConstants.SEQUENCE);
        JPushInterface.deleteAlias(mWXSDKInstance.getContext(), sequence);
    }

    @UniJSMethod(uiThread = true)
    public void queryAlias(JSONObject readableMap) {
        updatePluginStatu();
        if (readableMap == null) {
            JLogger.w(JConstants.PARAMS_NULL);
            return;
        }
        int sequence = readableMap.getIntValue(JConstants.SEQUENCE);
        JPushInterface.getAlias(mWXSDKInstance.getContext(), sequence);
    }

    @UniJSMethod(uiThread = true)
    public void setMobileNumber(JSONObject readableMap) {
        updatePluginStatu();
        if (readableMap == null) {
            JLogger.w(JConstants.PARAMS_NULL);
            return;
        }
        int sequence = readableMap.getIntValue(JConstants.SEQUENCE);
        String mobileNumber = readableMap.getString(JConstants.MOBILE_NUMBER);
        JPushInterface.setMobileNumber(mWXSDKInstance.getContext(), sequence, mobileNumber);
    }

    @UniJSMethod(uiThread = true)
    public void onResume() {
        updatePluginStatu();
        JPushInterface.onResume(mWXSDKInstance.getContext());
    }

    @UniJSMethod(uiThread = true)
    public void onPause() {
        updatePluginStatu();
        JPushInterface.onPause(mWXSDKInstance.getContext());
    }

    @UniJSMethod(uiThread = true)
    public void onKillProcess() {
        updatePluginStatu();
        JPushInterface.onKillProcess(mWXSDKInstance.getContext());
    }

    @UniJSMethod(uiThread = true)
    public void initCrashHandler() {
        updatePluginStatu();
        JPushInterface.initCrashHandler(mWXSDKInstance.getContext());
    }

    @UniJSMethod(uiThread = true)
    public void stopCrashHandler() {
        updatePluginStatu();
        JPushInterface.stopCrashHandler(mWXSDKInstance.getContext());
    }

    @UniJSMethod(uiThread = true)
    public void addLocalNotification(JSONObject readableMap) {
        updatePluginStatu();
        if (readableMap == null) {
            JLogger.w(JConstants.PARAMS_NULL);
            return;
        }
        if (!readableMap.containsKey(JConstants.MESSAGE_ID)) {
            JLogger.w(JConstants.PARAMS_ILLEGAL);
            return;
        }
        String notificationID = readableMap.getString(JConstants.MESSAGE_ID);
        if (notificationID == null || TextUtils.isEmpty(notificationID)) {
            JLogger.w(JConstants.PARAMS_ILLEGAL);
            return;
        }
        int id = Integer.valueOf(notificationID);
        String notificationTitle = readableMap.containsKey(JConstants.TITLE) ? readableMap.getString(JConstants.TITLE) : mWXSDKInstance.getContext().getPackageName();
        String notificationContent = readableMap.containsKey(JConstants.CONTENT) ? readableMap.getString(JConstants.CONTENT) : mWXSDKInstance.getContext().getPackageName();
        JPushLocalNotification notification = new JPushLocalNotification();
        notification.setNotificationId(id);
        notification.setTitle(notificationTitle);
        notification.setContent(notificationContent);
        if (readableMap.containsKey(JConstants.EXTRAS)) {
            JSONObject notificationExtra = readableMap.getJSONObject(JConstants.EXTRAS);
            notification.setExtras(notificationExtra.toString());
        }
        JPushInterface.addLocalNotification(mWXSDKInstance.getContext(), notification);
    }

    @UniJSMethod(uiThread = true)
    public void removeLocalNotification(JSONObject readableMap) {
        updatePluginStatu();
        if (readableMap == null) {
            JLogger.w(JConstants.PARAMS_NULL);
            return;
        }
        if (readableMap.containsKey(JConstants.MESSAGE_ID)) {
            String notificationID = readableMap.getString(JConstants.MESSAGE_ID);
            if (notificationID == null || TextUtils.isEmpty(notificationID)) {
                JLogger.w(JConstants.PARAMS_ILLEGAL);
                return;
            }
            int id = Integer.valueOf(notificationID);
            JPushInterface.removeLocalNotification(mWXSDKInstance.getContext(), id);
        } else {
            JLogger.w("there are no " + JConstants.MESSAGE_ID);
        }
    }

    @UniJSMethod(uiThread = true)
    public void clearLocalNotifications() {
        updatePluginStatu();
        JPushInterface.clearLocalNotifications(mWXSDKInstance.getContext());
    }

    @UniJSMethod(uiThread = true)
    public void requestPermission() {
        updatePluginStatu();
        JPushInterface.requestPermission(mWXSDKInstance.getContext());
    }

    @UniJSMethod(uiThread = true)
    public void setGeofenceInterval(JSONObject readableMap) {
        updatePluginStatu();
        if (readableMap == null) {
            JLogger.w(JConstants.PARAMS_NULL);
            return;
        }
        if (readableMap.containsKey(JConstants.GEO_FENCE_INTERVAL)) {
            int interval = readableMap.getIntValue(JConstants.GEO_FENCE_INTERVAL);
            JPushInterface.setGeofenceInterval(mWXSDKInstance.getContext(), interval);
        } else {
            JLogger.w("there are no " + JConstants.GEO_FENCE_INTERVAL);
        }
    }

    @UniJSMethod(uiThread = true)
    public void setMaxGeofenceNumber(int maxNumber) {
        updatePluginStatu();
        JPushInterface.setMaxGeofenceNumber(mWXSDKInstance.getContext(), maxNumber);
    }

    @UniJSMethod(uiThread = true)
    public void deleteGeofence(String id) {
        updatePluginStatu();
        if (!TextUtils.isEmpty(id)) {
            JPushInterface.deleteGeofence(mWXSDKInstance.getContext(), id);
        } else {
            JLogger.w("there are no " + JConstants.GEO_FENCE_ID);
        }
    }

    @UniJSMethod(uiThread = true)
    public void setBadge(int number) {
        updatePluginStatu();
        JPushInterface.setBadgeNumber(mWXSDKInstance.getContext(), number);
    }

    @UniJSMethod(uiThread = true)
    public void clearAllNotifications() {
        updatePluginStatu();
        JPushInterface.clearAllNotifications(mWXSDKInstance.getContext());
    }

    @UniJSMethod(uiThread = true)
    public void clearNotificationById(JSONObject readableMap) {
        updatePluginStatu();
        if (readableMap == null) {
            JLogger.w(JConstants.PARAMS_NULL);
            return;
        }
        if (readableMap.containsKey(JConstants.NOTIFICATION_ID)) {
            Integer id = readableMap.getIntValue(JConstants.NOTIFICATION_ID);
            JPushInterface.clearNotificationById(mWXSDKInstance.getContext(), id);
        } else {
            JLogger.w("there are no " + JConstants.GEO_FENCE_ID);
        }
    }

    @UniJSMethod(uiThread = true)
    public void setPowerSaveMode(boolean bool) {
        updatePluginStatu();
        JPushInterface.setPowerSaveMode(mWXSDKInstance.getContext(), bool);
    }

    @UniJSMethod(uiThread = true)
    public void isNotificationEnabled(JSCallback callback) {
        updatePluginStatu();
        Integer isEnabled = JPushInterface.isNotificationEnabled(mWXSDKInstance.getContext());
        if (callback == null) {
            JLogger.w(JConstants.CALLBACK_NULL);
            return;
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put(JConstants.CODE, isEnabled);
        callback.invoke(jsonObject);
    }

    @UniJSMethod(uiThread = true)
    public void openSettingsForNotification(JSCallback callback) {
        updatePluginStatu();
        JPushInterface.goToAppNotificationSettings(mWXSDKInstance.getContext());
        if (callback == null) {
            JLogger.w(JConstants.CALLBACK_NULL);
            return;
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put(JConstants.CODE, 0);
        callback.invoke(jsonObject);
    }

    @UniJSMethod(uiThread = true)
    public void addConnectEventListener(JSCallback callback) {
        updatePluginStatu();
        if (callback != null) {
            JLogger.w("addConnectEventListener");
            JPushHelper.eventCallback.put(JConstants.CONNECT_EVENT, callback);
        }
    }


    @UniJSMethod(uiThread = true)
    public void addNotificationListener(JSCallback callback) {
        updatePluginStatu();
        if (callback != null) {
            JLogger.w("addNotificationListener");
            JPushHelper.eventCallback.put(JConstants.NOTIFICATION_EVENT, callback);
            JPushHelper.sendCacheOpenNotifiToUser(0);
        }
    }

    @UniJSMethod(uiThread = true)
    public void addCustomMessageListener(JSCallback callback) {
        updatePluginStatu();
        if (callback != null) {
            JLogger.w("addCustomMessageListener");
            JPushHelper.eventCallback.put(JConstants.CUSTOM_MESSAGE_EVENT, callback);
        }
    }

    @UniJSMethod(uiThread = true)
    public void addInMessageListener(JSCallback callback) {
        updatePluginStatu();
        if (callback != null) {
            JLogger.w("addInMessageListener");
            JPushHelper.eventCallback.put(JConstants.INAPP_MESSAGE_EVENT, callback);
        }
    }

    @UniJSMethod(uiThread = true)
    public void addLocalNotificationListener(JSCallback callback) {
        updatePluginStatu();
        if (callback != null) {
            JLogger.w("addCustomMessageListener");
            JPushHelper.eventCallback.put(JConstants.LOCAL_NOTIFICATION_EVENT, callback);
            JPushHelper.sendCacheOpenNotifiToUser(1);
        }
    }

    @UniJSMethod(uiThread = true)
    public void addMobileNumberListener(JSCallback callback) {
        updatePluginStatu();
        if (callback != null) {
            JLogger.w("addMobileNumberListener");
            JPushHelper.eventCallback.put(JConstants.MOBILE_NUMBER_EVENT, callback);
        }
    }

    @UniJSMethod(uiThread = true)
    public void addCommandListener(JSCallback callback) {
        updatePluginStatu();
        if (callback != null) {
            JLogger.w("addCommandListener");
            JPushHelper.eventCallback.put(JConstants.COMMAND_EVENT, callback);
        }
    }

    @UniJSMethod(uiThread = true)
    public void setIsAllowedInMessagePop(boolean allowedInMessagePop) {
        updatePluginStatu();
        JPushModuleReceiver.IS_NEED_SHOW_INAPP_MESSAGE = allowedInMessagePop;
    }

    @UniJSMethod(uiThread = true)
    public void addTagAliasListener(JSCallback callback) {
        updatePluginStatu();
        if (callback != null) {
            JLogger.w("addTagAliasListener");
            JPushHelper.eventCallback.put(JConstants.TAG_ALIAS_EVENT, callback);
        }
    }


    //*****************************应用前后台状态监听*****************************
    public static void registerActivityLifecycle(Application application) {
        application.registerActivityLifecycleCallbacks(new Application.ActivityLifecycleCallbacks() {
            @Override
            public void onActivityCreated(Activity activity, Bundle bundle) {
                JLogger.d("onActivityCreated");
            }

            @Override
            public void onActivityStarted(Activity activity) {
                JLogger.d("onActivityStarted");
            }

            @Override
            public void onActivityResumed(Activity activity) {
                JLogger.d("onActivityResumed");
                isAppForeground = true;
            }

            @Override
            public void onActivityPaused(Activity activity) {
                JLogger.d("onActivityPaused");
                isAppForeground = false;
            }

            @Override
            public void onActivityStopped(Activity activity) {
                JLogger.d("onActivityStopped");
            }

            @Override
            public void onActivitySaveInstanceState(Activity activity, Bundle bundle) {
                JLogger.d("onActivitySaveInstanceState");
            }

            @Override
            public void onActivityDestroyed(Activity activity) {
                JLogger.d("onActivityDestroyed");
            }
        });
    }


    @Override
    public void destroy() {
        JLogger.e("destroy");
        JPushHelper.IS_DESTROY = true;
        JPushHelper.eventCallback = new HashMap<>();
    }
}
