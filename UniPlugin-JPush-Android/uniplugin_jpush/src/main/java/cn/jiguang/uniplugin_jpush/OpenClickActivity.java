package cn.jiguang.uniplugin_jpush;


import android.app.Activity;
import android.os.Build;
import android.os.Bundle;
import android.text.TextUtils;
import android.widget.TextView;

import com.alibaba.fastjson.JSONException;
import com.alibaba.fastjson.JSONObject;

import java.util.Set;

import cn.jiguang.uniplugin_jpush.common.JLogger;
import cn.jiguang.uniplugin_jpush.helper.JPushHelper;
import cn.jpush.android.api.JPushInterface;

/**
 * Created by jiguang on 17/7/5.
 */

public class OpenClickActivity extends Activity {
    private static final String TAG = "OpenClickActivity";
    /**
     * 消息Id
     **/
    private static final String KEY_MSGID = "msg_id";
    /**
     * 该通知的下发通道
     **/
    private static final String KEY_WHICH_PUSH_SDK = "rom_type";
    /**
     * 通知标题
     **/
    private static final String KEY_TITLE = "n_title";
    /**
     * 通知内容
     **/
    private static final String KEY_CONTENT = "n_content";
    /**
     * 通知附加字段
     **/
    private static final String KEY_EXTRAS = "n_extras";
    private TextView mTextView;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        handleOpenClick();
    }


    /**
     * 处理点击事件，当前启动配置的Activity都是使用
     * Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK
     * 方式启动，只需要在onCreat中调用此方法进行处理
     */
    private void handleOpenClick() {
        JLogger.d(TAG + " user click notification");
        String data = null;
        //获取华为平台附带的jpush信息
        if (getIntent().getData() != null) {
            data = getIntent().getData().toString();
            try {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                    Set<String> queryParameterNames = getIntent().getData().getQueryParameterNames();
                    for (String key : queryParameterNames) {
                        JLogger.d(TAG + " key:" + key + ",value:" + getIntent().getData().getQueryParameter(key));
                    }
                }
//                Log.e(TAG,"decode extras:"+extras);
//               Log.e(TAG,"decode extras:"+ URLDecoder.decode(extras,"utf-8"));
            } catch (Throwable e) {
                e.printStackTrace();
            }
        }

        //获取fcm、oppo、vivo、华硕、小米平台附带的jpush信息
        if (TextUtils.isEmpty(data) && getIntent().getExtras() != null) {
            data = getIntent().getExtras().getString("JMessageExtra");
        }

        if (TextUtils.isEmpty(data) && getIntent().getExtras() != null) {
            data = getIntent().getExtras().getString("asus_data");
        }
        if (getIntent().getExtras() != null) {
            String extra = getIntent().getExtras().getString("extras");
            JLogger.d(TAG + " extras " + String.valueOf(extra));
        }
        JLogger.d(TAG + " msg content is " + String.valueOf(data));
        if (TextUtils.isEmpty(data)) return;
        try {
            JSONObject jsonObject = JSONObject.parseObject(data);
            String msgId = jsonObject.getString(KEY_MSGID);
            byte whichPushSDK = (byte) jsonObject.getIntValue(KEY_WHICH_PUSH_SDK);
            String title = jsonObject.getString(KEY_TITLE);
            String content = jsonObject.getString(KEY_CONTENT);
            String extras = jsonObject.getString(KEY_EXTRAS);
            JSONObject thirdOpenNotification = JPushHelper.convertThirdOpenNotificationToMap(msgId, title, content, extras, data);
            JPushHelper.sendNotifactionEvent(thirdOpenNotification, 0);
            JPushHelper.saveOpenNotifiData(thirdOpenNotification, 0);
            //上报点击事件
            JPushInterface.reportNotificationOpened(this, msgId, whichPushSDK);
            if (!JPushModule.isAppForeground) JPushHelper.launchApp(this);
//            StringBuilder sb = new StringBuilder();
//            sb.append("msgId:");
//            sb.append(String.valueOf(msgId));
//            sb.append("\n");
//            sb.append("title:");
//            sb.append(String.valueOf(title));
//            sb.append("\n");
//            sb.append("content:");
//            sb.append(String.valueOf(content));
//            sb.append("\n");
//            sb.append("extras:");
//            sb.append(String.valueOf(extras));
//            sb.append("\n");
//            sb.append("platform:");
//            sb.append(getPushSDKName(whichPushSDK));
//            mTextView.setText(sb.toString());
        } catch (JSONException e) {
            JLogger.w(TAG + " parse notification error");
        }
        finish();
    }

    private String getPushSDKName(byte whichPushSDK) {
        String name;
        switch (whichPushSDK) {
            case 0:
                name = "jpush";
                break;
            case 1:
                name = "xiaomi";
                break;
            case 2:
                name = "huawei";
                break;
            case 3:
                name = "meizu";
                break;
            case 4:
                name = "oppo";
                break;
            case 5:
                name = "vivo";
                break;
            case 6:
                name = "asus";
                break;
            case 8:
                name = "fcm";
                break;

            default:
                name = "jpush";
        }
        return name;
    }
}
