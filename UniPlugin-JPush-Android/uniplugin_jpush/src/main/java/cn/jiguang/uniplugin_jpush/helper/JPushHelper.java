package cn.jiguang.uniplugin_jpush.helper;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;


import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.taobao.weex.bridge.JSCallback;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import cn.jiguang.uniplugin_jpush.JPushModule;
import cn.jiguang.uniplugin_jpush.common.JConstants;
import cn.jiguang.uniplugin_jpush.common.JLogger;
import cn.jiguang.uniplugin_jpush.receiver.JPushEventBroadcastReceiver;
import cn.jpush.android.api.CustomMessage;
import cn.jpush.android.api.JPushInterface;
import cn.jpush.android.api.JPushMessage;
import cn.jpush.android.api.NotificationMessage;

public class JPushHelper {

    private static HashMap<String, JSCallback> eventCallback = new HashMap<>();
    // 缓存待发送的事件数据，当没有对应 callback 时缓存，注册 callback 后立即发送
    private static HashMap<String, List<JSONObject>> eventCache = new HashMap<>();

    /**
     * 添加事件回调
     */
    public static void putEventCallback(String eventName, JSCallback callback) {
        if (eventName != null && callback != null) {
            eventCallback.put(eventName, callback);
            // 检查是否有缓存的事件数据，如果有则立即发送
            sendCachedEvents(eventName, callback);
        }
    }

    /**
     * 清空所有事件回调
     */
    public static void clearEventCallback() {
        eventCallback.clear();
        eventCache.clear();
    }

    /**
     * 发送缓存的事件数据
     */
    private static void sendCachedEvents(String eventName, JSCallback callback) {
        List<JSONObject> cachedEvents = eventCache.get(eventName);
        if (cachedEvents != null && !cachedEvents.isEmpty()) {
            JLogger.d("sendCachedEvents eventName=" + eventName + ", cachedCount=" + cachedEvents.size());
            try {
                // 发送所有缓存的事件
                for (JSONObject params : cachedEvents) {
                    callback.invokeAndKeepAlive(params);
                }
                // 清空已发送的缓存
                eventCache.remove(eventName);
                JLogger.d("sendCachedEvents success: " + eventName);
            } catch (Throwable throwable) {
                JLogger.e("sendCachedEvents error: " + throwable.getMessage());
            }
        }
    }

    public static void sendNotifactionEvent(JSONObject params, int notificationType) {
        JLogger.d("sendNotifactionEvent params=" + params + " notificationType=" + notificationType);
        if (notificationType != 1) {
            JPushHelper.sendEvent(JConstants.NOTIFICATION_EVENT, params);
        } else {
            JPushHelper.sendEvent(JConstants.LOCAL_NOTIFICATION_EVENT, params);
        }

    }

    public static void sendEvent(String eventName, JSONObject params) {
        JLogger.d("sendEvent eventName=" + eventName + " params=" + params);
        try {
            if (!TextUtils.isEmpty(eventName) && params != null) {
                JLogger.d("sendEvent :" + eventName + " params:" + params);
                JSCallback jsCallback = eventCallback.get(eventName);
                if (jsCallback != null) {
                    // 有 callback，直接发送
                    jsCallback.invokeAndKeepAlive(params);
                    JLogger.d("sendEvent :" + eventName + " success");
                    return;
                }
                // 没有 callback，缓存起来
                cacheEvent(eventName, params);
                JLogger.d("sendEvent :" + eventName + " cached, waiting for callback");
            }
        } catch (Throwable throwable) {
            JLogger.e("sendEvent error:" + throwable.getMessage());
        }
    }

    /**
     * 缓存事件数据
     */
    private static void cacheEvent(String eventName, JSONObject params) {
        List<JSONObject> cachedEvents = eventCache.get(eventName);
        if (cachedEvents == null) {
            cachedEvents = new ArrayList<>();
            eventCache.put(eventName, cachedEvents);
        }
        cachedEvents.add(params);
        JLogger.d("cacheEvent eventName=" + eventName + ", cacheSize=" + cachedEvents.size());
    }

    public static JSONObject convertNotificationToMap(String eventType, NotificationMessage message) {
        JLogger.d("convertNotificationToMap eventType=" + eventType + " message=" + message);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put(JConstants.NOTIFICATION_EVENT_TYPE, eventType);
        jsonObject.put(JConstants.MESSAGE_ID, message.msgId);
        jsonObject.put(JConstants.TITLE, message.notificationTitle);
        jsonObject.put(JConstants.CONTENT, message.notificationContent);
        jsonObject.put(JConstants.ANDROID, JSONObject.parseObject(JSONObject.toJSONString(message)));
        convertExtras(message.notificationExtras, jsonObject);
        return jsonObject;
    }

    public static JSONObject convertThirdOpenNotificationToMap(String msgId, String title, String content, String extra, String android) {
        JLogger.d("convertThirdOpenNotificationToMap msgId=" + msgId + " title=" + title + " content=" + content);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put(JConstants.NOTIFICATION_EVENT_TYPE, JConstants.NOTIFICATION_OPENED);
        jsonObject.put(JConstants.MESSAGE_ID, msgId);
        jsonObject.put(JConstants.TITLE, title);
        jsonObject.put(JConstants.CONTENT, content);
        jsonObject.put(JConstants.ANDROID, JSONObject.parseObject(android));
        convertExtras(extra, jsonObject);
        return jsonObject;
    }

    public static JSONObject convertInAppMessageToMap(String eventType, NotificationMessage message) {
        JLogger.d("convertInAppMessageToMap eventType=" + eventType + " message=" + message);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put(JConstants.INAPP_MESSAGE_EVENT_TYPE, eventType);
        jsonObject.put(JConstants.MESSAGE_ID, message.msgId);
        jsonObject.put(JConstants.TITLE, message.inAppMsgTitle);
        jsonObject.put(JConstants.CONTENT, message.inAppMsgContentBody);
        jsonObject.put(JConstants.INAPPCLICKACTION, message.inAppClickAction);
        jsonObject.put(JConstants.INAPPEXTRAS, message.inAppExtras);
        jsonObject.put(JConstants.INAPPSHOWTARGET, message.inAppShowTarget);
        jsonObject.put(JConstants.ANDROID, JSONObject.parseObject(JSONObject.toJSONString(message)));
        convertExtras(message.notificationExtras, jsonObject);
        return jsonObject;
    }

    public static JSONObject convertNotificationBundleToMap(String eventType, Bundle bundle) {
        JLogger.d("convertNotificationBundleToMap eventType=" + eventType + " bundle=" + bundle);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put(JConstants.NOTIFICATION_EVENT_TYPE, eventType);
        jsonObject.put(JConstants.MESSAGE_ID, bundle.getString("cn.jpush.android.MSG_ID", ""));
        jsonObject.put(JConstants.TITLE, bundle.getString("cn.jpush.android.NOTIFICATION_CONTENT_TITLE", ""));
        jsonObject.put(JConstants.CONTENT, bundle.getString("cn.jpush.android.ALERT", ""));
        convertExtras(bundle.getString("cn.jpush.android.EXTRA", ""), jsonObject);
        return jsonObject;
    }

    public static JSONObject convertCustomMessage(CustomMessage customMessage) {
        JLogger.d("convertCustomMessage customMessage=" + customMessage);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put(JConstants.MESSAGE_ID, customMessage.messageId);
        jsonObject.put(JConstants.TITLE, customMessage.title);
        jsonObject.put(JConstants.CONTENT, customMessage.message);
        convertExtras(customMessage.extra, jsonObject);
        jsonObject.put(JConstants.ANDROID, JSONObject.parseObject(JSONObject.toJSONString(customMessage)));
        return jsonObject;
    }

    public static JSONObject convertJPushMessageToMap(int type, JPushMessage message) {
        JLogger.d("convertJPushMessageToMap type=" + type + " message=" + message);
        JSONObject jsonObject = new JSONObject();

        jsonObject.put(JConstants.CODE, message.getErrorCode());
        jsonObject.put(JConstants.SEQUENCE, message.getSequence());
        switch (type) {
            case 1:
                Set<String> tags = message.getTags();
                JSONArray tagsArray = new JSONArray();
                if (tags == null || tags.isEmpty()) {
                    JLogger.d("tags is empty");
                } else {
                    for (String tag : tags) {
                        tagsArray.add(tag);
                    }
                }
                jsonObject.put(JConstants.TAGS, tagsArray);
                break;
            case 2:
                jsonObject.put(JConstants.TAG_ENABLE, message.getTagCheckStateResult());
                jsonObject.put(JConstants.TAG, message.getCheckTag());
                break;
            case 3:
                jsonObject.put(JConstants.ALIAS, message.getAlias());
                break;
        }
        return jsonObject;
    }

    public static void convertExtras(String extras, JSONObject jsonObject) {
        JLogger.d("convertExtras extras=" + extras);
        if (TextUtils.isEmpty(extras) || extras.equals("{}")) return;
        try {
//            JSONObject extrasMap = new JSONObject();
//            JSONObject jsonObject = JSONObject.parseObject(extras);
//            Iterator<String> it = jsonObject.keys();
//            while (it.hasNext()) {
//                String key = it.next();
//                String value = jsonObject.getString(key);
//                extrasMap.put(key, value);
//            }
            jsonObject.put(JConstants.EXTRAS, JSONObject.parseObject(extras));
        } catch (Throwable throwable) {
            JLogger.w("convertExtras error:" + throwable.getMessage());
        }
    }

    public static void launchApp(Context context) {
        JLogger.d("launchApp context=" + context);
        try {
            Intent intent = context.getPackageManager().getLaunchIntentForPackage(context.getPackageName());
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_SINGLE_TOP | Intent.FLAG_ACTIVITY_CLEAR_TOP);
            context.startActivity(intent);
        } catch (Throwable throwable) {
            JLogger.e("launchApp error:" + throwable.getMessage());
        }
    }

    public static JSONObject OPEN_NOTIFICATION_DATA = null;
    public static int OPEN_NOTIFICATION_TYPE = 0;
    public static boolean IS_DESTROY = true;// 标识当前插件是否被销毁

    /**
     * 缓存通知点击信息，再用户注册监听后返回给用户
     *
     * @param jsonObject
     */
    public static void saveOpenNotifiData(JSONObject jsonObject, int type) {
        JLogger.d("saveOpenNotifiData jsonObject=" + jsonObject + " type=" + type);
        if (IS_DESTROY) {
            JLogger.d("saveOpenNotifiData:" + jsonObject);
            OPEN_NOTIFICATION_DATA = jsonObject;
            OPEN_NOTIFICATION_TYPE = type;
        }
    }

    public static void sendCacheOpenNotifiToUser(int type) {
        JLogger.d("sendCacheOpenNotifiToUser type=" + type);
        if (type == 0 && OPEN_NOTIFICATION_TYPE == 1) {
            return;
        }
        if (!IS_DESTROY && OPEN_NOTIFICATION_DATA != null) {
            JLogger.d("sendCacheOpenNotifiToUser:" + OPEN_NOTIFICATION_DATA);
            sendNotifactionEvent(OPEN_NOTIFICATION_DATA, OPEN_NOTIFICATION_TYPE);
            OPEN_NOTIFICATION_DATA = null;
        }
    }

    /**
     * 发送 Android 广播，将 JPush 事件数据通过广播发送出去
     *
     * @param context 上下文
     * @param eventName 事件名称
     * @param params 事件数据
     */
    public static void sendBroadcast(Context context, String eventName, JSONObject params) {
        JLogger.d("sendBroadcast eventName=" + eventName + " params=" + params);
        try {
            if (context != null && !TextUtils.isEmpty(eventName) && params != null) {
                Intent intent = new Intent(context,JPushEventBroadcastReceiver.class);
                intent.setAction(JPushEventBroadcastReceiver.ACTION_EVENT_BROADCAST);
                intent.putExtra(JPushEventBroadcastReceiver.EXTRA_EVENT_NAME, eventName);
                intent.putExtra(JPushEventBroadcastReceiver.EXTRA_EVENT_DATA, params.toJSONString());
                intent.setPackage(context.getPackageName());
                context.sendBroadcast(intent, context.getPackageName() + JPushInterface.PUSH_MESSAGE_PERMISSION_POSTFIX);
                JLogger.d("sendBroadcast success: " + eventName + ", package=" + context.getPackageName());
            }
        } catch (Throwable throwable) {
            JLogger.e("sendBroadcast error 2:" + throwable.getMessage());
        }
    }

}
