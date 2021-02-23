package cn.jiguang.uniplugin_jpush.helper;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;


import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.taobao.weex.bridge.JSCallback;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import cn.jiguang.uniplugin_jpush.JPushModule;
import cn.jiguang.uniplugin_jpush.common.JConstants;
import cn.jiguang.uniplugin_jpush.common.JLogger;
import cn.jpush.android.api.CustomMessage;
import cn.jpush.android.api.JPushMessage;
import cn.jpush.android.api.NotificationMessage;

public class JPushHelper {


    public static HashMap<String, JSCallback> eventCallback = new HashMap<>();

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
                JSCallback jsCallback = eventCallback.get(eventName);
                if (jsCallback != null) {
                    jsCallback.invokeAndKeepAlive(params);
                    JLogger.e("sendEvent :" + eventName + " success");
                    return;
                }
                JLogger.e("sendEvent :" + eventName + " failed");
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
        jsonObject.put(JConstants.INAPP_MESSAGE_TYPE, message.inAppMsgType);
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

    public static JSONObject OPEN_NOTIFICATION_DATA = null;
    public static int OPEN_NOTIFICATION_TYPE = 0;
    public static boolean IS_DESTROY = true;// 标识当前插件是否被销毁

    /**
     * 缓存通知点击信息，再用户注册监听后返回给用户
     *
     * @param jsonObject
     */
    public static void saveOpenNotifiData(JSONObject jsonObject, int type) {
        if (IS_DESTROY) {
            JLogger.d("saveOpenNotifiData:" + jsonObject);
            OPEN_NOTIFICATION_DATA = jsonObject;
            OPEN_NOTIFICATION_TYPE = type;
        }
    }

    public static void sendCacheOpenNotifiToUser(int type) {
        if (type == 0 && OPEN_NOTIFICATION_TYPE == 1) {
            return;
        }
        if (!IS_DESTROY && OPEN_NOTIFICATION_DATA != null) {
            JLogger.d("sendCacheOpenNotifiToUser:" + OPEN_NOTIFICATION_DATA);
            sendNotifactionEvent(OPEN_NOTIFICATION_DATA, OPEN_NOTIFICATION_TYPE);
            OPEN_NOTIFICATION_DATA = null;
        }
    }

}
