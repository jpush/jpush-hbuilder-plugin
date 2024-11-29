package cn.jiguang.uniplugin_jpush.common;

public class JConstants {

    public static final String DEBUG = "debug";

    public static final String REGISTRATION_ID = "registerID";
    public static final String IMEI = "imei";
    public static final String IMSI = "imsi";
    public static final String MAC = "mac";
    public static final String WIFI = "wifi";
    public static final String BSSID = "bssid";
    public static final String SSID = "ssid";
    public static final String CELL = "cell";
    public static final String CODE = "code";
    public static final int CODE_SUCESS = 0;
    public static final String CHANNEL = "channel";
    public static final String CHANNEL_ID = "channel_id";
    public static final String SOUND = "sound";
    public static final String SEQUENCE = "sequence";
    public static final String CONNECT_ENABLE = "connectEnable";
    //电话号码
    public static final String MOBILE_NUMBER = "mobileNumber";
    //pushTime
    public static final String PUSH_TIME_DAYS = "pushTimeDays";
    public static final String PUSH_TIME_START_HOUR = "pushTimeStartHour";
    public static final String PUSH_TIME_END_HOUR = "pushTimeEndHour";
    //silenceTime
    public static final String SILENCE_TIME_START_HOUR = "silenceTimeStartHour";
    public static final String SILENCE_TIME_START_MINUTE = "silenceTimeStartMinute";
    public static final String SILENCE_TIME_END_HOUR = "silenceTimeEndHour";
    public static final String SILENCE_TIME_END_MINUTE = "silenceTimeEndMinute";
    //消息
    public static final String MESSAGE_ID = "messageID";
    public static final String TITLE = "title";
    public static final String CONTENT = "content";
    public static final String PLATFORM = "platform";
    public static final String EXTRAS = "extras";
    public static final String ANDROID = "android";//透传所有消息字段
    public static final String INAPPCLICKACTION = "inAppClickAction";
    public static final String INAPPEXTRAS = "inAppExtras";
    public static final String INAPPSHOWTARGET = "inAppShowTarget";

    //消息事件类型
    public static final String NOTIFICATION_ARRIVED = "notificationArrived";
    public static final String NOTIFICATION_OPENED = "notificationOpened";
    public static final String NOTIFICATION_DISMISSED = "notificationDismissed";
    public static final String NOTIFICATION_UNSHOW = "notificationUnShow";
    //应用内消息事件类型
    public static final String INAPP_MESSAGE_SHOW = "show";
    public static final String INAPP_MESSAGE_OPENED = "click";
    public static final String INAPP_MESSAGE_DISMISSED = "disappear";
    public static final String INAPP_MESSAGE_EVENT_TYPE = "eventType";
    public static final String INAPP_MESSAGE_TYPE = "messageType";
    //通知消息
    public static final String NOTIFICATION_EVENT_TYPE = "notificationEventType";
    public static final String NOTIFICATION_MAX_NUMBER = "notificationMaxNumber";
    public static final String NOTIFICATION_ID = "notificationId";
    //cmd消息
    public static final String COMMAND = "command";
    public static final String COMMAND_EXTRA = "commandExtra";
    public static final String COMMAND_RESULT = "commandResult";
    public static final String COMMAND_MESSAGE = "commandMessage";
    //地理围栏
    public static final String GEO_FENCE_ID = "geoFenceID";
    public static final String GEO_FENCE_INTERVAL = "geoFenceInterval";
    public static final String GEO_FENCE_MAX_NUMBER = "geoFenceMaxNumber";
    //tag alias
    public static final String TAG = "tag";
    public static final String TAGS = "tags";
    public static final String ALIAS = "alias";
    public static final String TAG_ENABLE = "tagEnable";
    //error
    public static final String PARAMS_NULL = "params cant be null";
    public static final String PARAMS_ILLEGAL = "params illegal";
    public static final String PARAMS_ILLEGAL_CHANNEL = "params illegal,channel and channel id must config";
    public static final String CALLBACK_NULL = "callback cant be null";
    //event
    public static final String CONNECT_EVENT = "ConnectEvent";
    public static final String NOTIFICATION_EVENT = "NotificationEvent";
    public static final String CUSTOM_MESSAGE_EVENT = "CustomMessageEvent";
    public static final String LOCAL_NOTIFICATION_EVENT = "LocalNotificationEvent";
    public static final String TAG_ALIAS_EVENT = "TagAliasEvent";
    public static final String MOBILE_NUMBER_EVENT = "MobileNumberEvent";
    public static final String COMMAND_EVENT = "CommandEvent";
    public static final String INAPP_MESSAGE_EVENT = "InappMessageEvent";
}
