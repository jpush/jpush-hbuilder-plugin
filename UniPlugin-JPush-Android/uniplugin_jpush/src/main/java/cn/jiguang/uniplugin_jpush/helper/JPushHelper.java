package cn.jiguang.uniplugin_jpush.helper;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;


import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.taobao.weex.bridge.JSCallback;

import java.util.Set;

import cn.jiguang.uniplugin_jpush.common.JConstants;
import cn.jiguang.uniplugin_jpush.common.JLogger;
import cn.jpush.android.api.CustomMessage;
import cn.jpush.android.api.JPushMessage;
import cn.jpush.android.api.JPushInterface;
import cn.jpush.android.api.NotificationMessage;

public class JPushHelper {


    private static final int MAX_PENDING_EVENTS_PER_TYPE = 100;
    private static final PendingEventDispatcher<JSONObject> events = new PendingEventDispatcher<>(
            MAX_PENDING_EVENTS_PER_TYPE,
            eventName -> JLogger.w("Pending event limit reached (" + MAX_PENDING_EVENTS_PER_TYPE
                    + "), dropping a waiting event: " + eventName),
            JLogger::d);

    public static void addEventListener(String eventName, Object owner, final JSCallback callback) {
        if (callback == null) return;
        events.register(eventName, owner, params -> {
            try {
                callback.invokeAndKeepAlive(params);
            } catch (Throwable throwable) {
                JLogger.e("sendEvent retained for retry: " + eventName + ", " + throwable.getMessage());
                return false;
            }
            JLogger.d("sendEvent :" + eventName + " accepted by bridge");
            return true;
        });
    }

    public static void removeEventListeners(Object owner) {
        events.unregister(owner);
    }

    private static final ConnectionStateDispatcher connectionStates = new ConnectionStateDispatcher(JLogger::d);

    public static void addConnectEventListener(Object owner, final JSCallback callback) {
        connectionStates.register(owner, connected -> {
            JSONObject params = new JSONObject();
            params.put(JConstants.CONNECT_ENABLE, connected);
            try {
                callback.invokeAndKeepAlive(params);
                JLogger.d("ConnectEvent delivered state:" + connected);
            } catch (Throwable throwable) {
                JLogger.e("ConnectEvent error:" + throwable.getMessage());
            }
        });
    }

    public static void removeConnectEventListener(Object owner) {
        connectionStates.unregister(owner);
    }

    public static void sendConnectEvent(boolean connected) {
        connectionStates.update(connected);
    }

    @SuppressWarnings("deprecation")
    public static void requestInitialConnectionState(Context context) {
        if (!connectionStates.hasState()) {
            JLogger.d("Request initial connection state from SDK");
            // Ignore the synchronous value: the service process replies with cmd 2004.
            JPushInterface.getConnectionState(context);
        } else {
            JLogger.d("Initial connection query skipped: state already known");
        }
    }

    public static void onConnectionStateQueryResult(int command, int code) {
        if (command == 2004 && (code == 0 || code == 1)) {
            if (connectionStates.initializeIfUnknown(code == 0)) {
                JLogger.d("Initial connection state supplied by SDK query:" + (code == 0));
            }
        }
    }

    public static void sendNotifactionEvent(JSONObject params, int notificationType) {
        if (notificationType != 1) {
            JPushHelper.sendEvent(JConstants.NOTIFICATION_EVENT, params);
        } else {
            JPushHelper.sendEvent(JConstants.LOCAL_NOTIFICATION_EVENT, params);
        }

    }

    public static void sendEvent(String eventName, JSONObject params) {
        try {
            if (!TextUtils.isEmpty(eventName) && params != null) {
                JLogger.d("sendEvent :" + eventName + " params:" + params);
                // Detach queued payloads from mutable objects owned by the caller.
                events.publish(eventName, JSONObject.parseObject(
                        JSONObject.toJSONString(params, SerializerFeature.WriteMapNullValue)));
            }
        } catch (Throwable throwable) {
            JLogger.e("sendEvent error:" + throwable.getMessage());
        }
    }

    public static JSONObject convertNotificationToMap(String eventType, NotificationMessage message) {
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
        JSONObject jsonObject = new JSONObject();
        jsonObject.put(JConstants.NOTIFICATION_EVENT_TYPE, eventType);
        jsonObject.put(JConstants.MESSAGE_ID, bundle.getString("cn.jpush.android.MSG_ID", ""));
        jsonObject.put(JConstants.TITLE, bundle.getString("cn.jpush.android.NOTIFICATION_CONTENT_TITLE", ""));
        jsonObject.put(JConstants.CONTENT, bundle.getString("cn.jpush.android.ALERT", ""));
        convertExtras(bundle.getString("cn.jpush.android.EXTRA", ""), jsonObject);
        return jsonObject;
    }

    public static JSONObject convertCustomMessage(CustomMessage customMessage) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put(JConstants.MESSAGE_ID, customMessage.messageId);
        jsonObject.put(JConstants.TITLE, customMessage.title);
        jsonObject.put(JConstants.CONTENT, customMessage.message);
        convertExtras(customMessage.extra, jsonObject);
        jsonObject.put(JConstants.ANDROID, JSONObject.parseObject(JSONObject.toJSONString(customMessage)));
        return jsonObject;
    }

    public static JSONObject convertJPushMessageToMap(int type, JPushMessage message) {
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
        try {
            Intent intent = context.getPackageManager().getLaunchIntentForPackage(context.getPackageName());
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_SINGLE_TOP | Intent.FLAG_ACTIVITY_CLEAR_TOP);
            context.startActivity(intent);
        } catch (Throwable throwable) {
            JLogger.e("");
        }
    }

}
