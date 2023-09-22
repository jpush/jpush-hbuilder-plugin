package cn.jiguang.uniplugin_jpush.receiver;

import android.content.Context;

import com.alibaba.fastjson.JSONObject;

import cn.jiguang.uniplugin_jpush.JPushModule;
import cn.jiguang.uniplugin_jpush.common.JConstants;
import cn.jiguang.uniplugin_jpush.common.JLogger;
import cn.jiguang.uniplugin_jpush.helper.JPushHelper;
import cn.jpush.android.api.CmdMessage;
import cn.jpush.android.api.CustomMessage;
import cn.jpush.android.api.JPushMessage;
import cn.jpush.android.api.NotificationMessage;
import cn.jpush.android.service.JPushMessageReceiver;

public class JPushModuleReceiver extends JPushMessageReceiver {

    @Override
    public void onMessage(Context context, CustomMessage customMessage) {
        JLogger.d("onMessage:" + customMessage.toString());
        JSONObject jsonObject = JPushHelper.convertCustomMessage(customMessage);
        JPushHelper.sendEvent(JConstants.CUSTOM_MESSAGE_EVENT, jsonObject);
    }

    @Override
    public void onNotifyMessageArrived(Context context, NotificationMessage notificationMessage) {
        JLogger.d("onNotifyMessageArrived:" + notificationMessage.toString());
        JSONObject jsonObject = JPushHelper.convertNotificationToMap(JConstants.NOTIFICATION_ARRIVED, notificationMessage);
        JPushHelper.sendNotifactionEvent(jsonObject, notificationMessage.notificationType);
    }


    @Override
    public void onNotifyMessageOpened(Context context, NotificationMessage notificationMessage) {
        JLogger.d("onNotifyMessageOpened:" + notificationMessage.toString());
        if (!JPushModule.isAppForeground) JPushHelper.launchApp(context);
        JSONObject jsonObject = JPushHelper.convertNotificationToMap(JConstants.NOTIFICATION_OPENED, notificationMessage);
        JPushHelper.sendNotifactionEvent(jsonObject, notificationMessage.notificationType);
        JPushHelper.saveOpenNotifiData(jsonObject, notificationMessage.notificationType);

    }

    @Override
    public void onNotifyMessageDismiss(Context context, NotificationMessage notificationMessage) {
        JLogger.d("onNotifyMessageDismiss:" + notificationMessage.toString());
        JSONObject jsonObject = JPushHelper.convertNotificationToMap(JConstants.NOTIFICATION_DISMISSED, notificationMessage);
        JPushHelper.sendNotifactionEvent(jsonObject, notificationMessage.notificationType);
    }

    @Override
    public void onRegister(Context context, String registrationId) {
        JLogger.d("onRegister:" + registrationId);
    }

    @Override
    public void onConnected(Context context, boolean state) {
        JLogger.d("onConnected state:" + state);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put(JConstants.CONNECT_ENABLE, state);
        JPushHelper.sendEvent(JConstants.CONNECT_EVENT, jsonObject);
    }

    @Override
    public void onCommandResult(Context context, CmdMessage message) {
        JLogger.d("onCommandResult:" + message.toString());
        JSONObject jsonObject = new JSONObject();
        jsonObject.put(JConstants.COMMAND, message.cmd);
        jsonObject.put(JConstants.COMMAND_EXTRA, message.extra.toString());
        jsonObject.put(JConstants.COMMAND_MESSAGE, message.msg);
        jsonObject.put(JConstants.COMMAND_RESULT, message.errorCode);
        JPushHelper.sendEvent(JConstants.COMMAND_EVENT, jsonObject);
    }

    @Override
    public void onTagOperatorResult(Context context, JPushMessage jPushMessage) {
        JLogger.d("onTagOperatorResult:" + jPushMessage.toString());
        JSONObject jsonObject = JPushHelper.convertJPushMessageToMap(1, jPushMessage);
        JPushHelper.sendEvent(JConstants.TAG_ALIAS_EVENT, jsonObject);
    }

    @Override
    public void onCheckTagOperatorResult(Context context, JPushMessage jPushMessage) {
        JLogger.d("onCheckTagOperatorResult:" + jPushMessage.toString());
        JSONObject jsonObject = JPushHelper.convertJPushMessageToMap(2, jPushMessage);
        JPushHelper.sendEvent(JConstants.TAG_ALIAS_EVENT, jsonObject);
    }

    @Override
    public void onAliasOperatorResult(Context context, JPushMessage jPushMessage) {
        JLogger.d("onAliasOperatorResult:" + jPushMessage.toString());
        JSONObject jsonObject = JPushHelper.convertJPushMessageToMap(3, jPushMessage);
        JPushHelper.sendEvent(JConstants.TAG_ALIAS_EVENT, jsonObject);
    }

    @Override
    public void onMobileNumberOperatorResult(Context context, JPushMessage jPushMessage) {
        JLogger.d("onMobileNumberOperatorResult:" + jPushMessage.toString());
        JSONObject jsonObject = new JSONObject();
        jsonObject.put(JConstants.CODE, jPushMessage.getErrorCode());
        jsonObject.put(JConstants.SEQUENCE, jPushMessage.getSequence());
        JPushHelper.sendEvent(JConstants.MOBILE_NUMBER_EVENT, jsonObject);
    }

    public static boolean IS_NEED_SHOW_INAPP_MESSAGE = true;

    @Override
    public boolean isNeedShowInAppMessage(Context context, NotificationMessage notificationMessage, String s) {
        return IS_NEED_SHOW_INAPP_MESSAGE;
    }

    @Override
    public void onInAppMessageShow(Context context, NotificationMessage notificationMessage) {
        JLogger.d("onInAppMessageShow:" + notificationMessage.toString());
        JSONObject jsonObject = JPushHelper.convertInAppMessageToMap(JConstants.INAPP_MESSAGE_SHOW, notificationMessage);
        JPushHelper.sendEvent(JConstants.INAPP_MESSAGE_EVENT, jsonObject);
    }

    @Override
    public void onInAppMessageClick(Context context, NotificationMessage notificationMessage) {
        JLogger.d("onInAppMessageClick:" + notificationMessage.toString());
        JSONObject jsonObject = JPushHelper.convertInAppMessageToMap(JConstants.INAPP_MESSAGE_OPENED, notificationMessage);
        JPushHelper.sendEvent(JConstants.INAPP_MESSAGE_EVENT, jsonObject);
    }


}
