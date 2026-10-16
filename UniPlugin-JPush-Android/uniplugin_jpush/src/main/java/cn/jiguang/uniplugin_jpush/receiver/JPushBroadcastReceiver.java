package cn.jiguang.uniplugin_jpush.receiver;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import cn.jiguang.uniplugin_jpush.common.JLogger;
import cn.jiguang.uniplugin_jpush.common.JConstants;
import cn.jiguang.uniplugin_jpush.helper.JPushHelper;
import cn.jpush.android.api.JPushInterface;

public class JPushBroadcastReceiver extends BroadcastReceiver {

    @Override
    public void onReceive(Context context, Intent data) {
        if (JPushInterface.ACTION_NOTIFICATION_OPENED.equals(data.getAction())) {
            JLogger.d("JPushBroadcastReceiver ACTION_NOTIFICATION_OPENED");
            try {
                Bundle bundle = data.getExtras();
                if (bundle != null) {
                    JPushHelper.sendEvent(JConstants.NOTIFICATION_EVENT,
                            JPushHelper.convertNotificationBundleToMap(JConstants.NOTIFICATION_OPENED, bundle));
                }
                JPushHelper.launchApp(context);
            } catch (Throwable throwable) {
                JLogger.e("JPushBroadcastReceiver ACTION_NOTIFICATION_OPENED error:" + throwable.getMessage());
            }
        }
    }

}
