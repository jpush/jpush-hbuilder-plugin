package cn.jiguang.uniplugin_jpush.receiver;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.text.TextUtils;

import com.alibaba.fastjson.JSONObject;

import cn.jiguang.uniplugin_jpush.common.JLogger;
import cn.jiguang.uniplugin_jpush.helper.JPushHelper;

/**
 * JPush 事件广播接收器
 * 用于接收从 JPushModuleReceiver 发送的广播数据
 */
public class JPushEventBroadcastReceiver extends BroadcastReceiver {

    public static final String ACTION_EVENT_BROADCAST = "cn.jiguang.uniplugin_jpush.EVENT_BROADCAST";
    public static final String EXTRA_EVENT_NAME = "eventName";
    public static final String EXTRA_EVENT_DATA = "eventData";

    @Override
    public void onReceive(Context context, Intent intent) {
        if (intent == null) {
            JLogger.w("JPushEventBroadcastReceiver onReceive: intent is null");
            return;
        }

        String action = intent.getAction();
        JLogger.d("JPushEventBroadcastReceiver onReceive action=" + action);

        if (ACTION_EVENT_BROADCAST.equals(action)) {
            try {
                String eventName = intent.getStringExtra(EXTRA_EVENT_NAME);
                String eventDataStr = intent.getStringExtra(EXTRA_EVENT_DATA);

                if (TextUtils.isEmpty(eventName)) {
                    JLogger.w("JPushEventBroadcastReceiver: eventName is empty");
                    return;
                }

                if (TextUtils.isEmpty(eventDataStr)) {
                    JLogger.w("JPushEventBroadcastReceiver: eventData is empty");
                    return;
                }

                JSONObject eventData = JSONObject.parseObject(eventDataStr);
                JLogger.d("JPushEventBroadcastReceiver received event: " + eventName + ", data: " + eventData);

                // 在这里执行你的业务逻辑
                handleJPushEvent(context, eventName, eventData);

            } catch (Throwable throwable) {
                JLogger.e("JPushEventBroadcastReceiver onReceive error: " + throwable.getMessage());
            }
        }
    }

    /**
     * 处理接收到的 JPush 事件
     *
     * @param context 上下文
     * @param eventName 事件名称
     * @param eventData 事件数据
     */
    private void handleJPushEvent(Context context, String eventName, JSONObject eventData) {
        JLogger.d("handleJPushEvent eventName=" + eventName + " eventData=" + eventData);
        JPushHelper.sendEvent(eventName, eventData);
    }
}

