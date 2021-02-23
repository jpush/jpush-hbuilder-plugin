# JPush Hbuilder API ONLY For Android

## 引用方式
```javascript
var jpushModule = uni.requireNativePlugin("JG-JPush");
```

## 停止推送服务

### API - stopPush()
调用了本 API 后，JPush 推送服务完全被停止。具体表现为：
收不到推送消息
极光推送所有的其他 API 调用都无效，不能通过 JPushInterface.init 恢复，需要调用 resumePush 恢复。

#### 示例
```javascript
jpushModule.stopPush();
```

## 恢复推送服务

### API - resumePush()
调用了此 API 后，极光推送完全恢复正常工作。

#### 示例
```javascript
jpushModule.resumePush();
```

## 恢复推送服务

### API - isPushStopped(CALLBACK)
用来检查 Push Service 是否已经被停止

#### 参数说明

- CALLBACK

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|code|number| 0 - 已停止 1 - 未停止|


#### 示例
```javascript
jpushModule.isPushStopped(result=>{
				let code = result.code
			});
```


## 配置 Channel API

### API - setChannel(Object)
动态配置 channel，优先级比 AndroidManifest 里配置的高

#### 参数说明
- Object

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|channel|string|希望配置的 channel|

#### 示例
```javascript
jpushModule.setChannel({
					'channel':'channel_1'
				});    
```

## 设置允许推送时间 API

### API - setPushTime(Object)
默认情况下用户在任何时间都允许推送。即任何时候有推送下来，客户端都会收到，并展示。

开发者可以调用此 API 来设置允许推送的时间。

如果不在该时间段内收到消息，SDK 的处理是：推送到的通知会被扔掉。

 这是一个纯粹客户端的实现，所以与客户端时间是否准确、时区等这些，都有关系。
 而且该接口仅对通知有效，自定义消息不受影响。

#### 参数说明
- Object

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|pushTimeDays|NumberArray|0 表示星期天，1 表示星期一，以此类推。 （ 7 天制，Set 集合里面的 int 范围为 0 到 6 ）|
|pushTimeStartHour|number|允许推送的开始时间 （ 24 小时制：startHour 的范围为 0 到 23 ）|
|pushTimeEndHour|number|允许推送的结束时间 （ 24 小时制：endHour 的范围为 0 到 23 ）|

#### 示例
```javascript
jpushModule.setPushTime({
					'pushTimeDays':[0,1,2],
                    'pushTimeStartHour':0,
                    'pushTimeEndHour':23
				});    
```

## 设置通知静默时间 API

### API - setSilenceTime(Object)
默认情况下用户在收到推送通知时，客户端可能会有震动，响铃等提示。但用户在睡觉、开会等时间点希望为“免打扰”模式，也是静音时段的概念。

开发者可以调用此 API 来设置静音时段。如果在该时间段内收到消息，则：不会有铃声和震动。

#### 参数说明
- Object

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|silenceTimeStartHour|number|静音时段的开始时间 - 小时 （ 24 小时制，范围：0~23 ）|
|silenceTimeStartMinute|number|静音时段的开始时间 - 分钟（范围：0~59 ）|
|silenceTimeEndHour|number|静音时段的结束时间 - 小时 （ 24 小时制，范围：0~23 ）|
|silenceTimeEndMinute|number|静音时段的结束时间 - 分钟（范围：0~59 ）|

#### 示例
```javascript
jpushModule.setSilenceTime({
					'silenceTimeStartHour':22,
                    'silenceTimeStartMinute':30,
                    'silenceTimeEndHour':8
                    'silenceTimeEndMinute':30
				});    
```

## 设置保留最近通知条数 API

### API - setLatestNotificationNumber(Object)
通过极光推送，推送了很多通知到客户端时，如果用户不去处理，就会有很多保留在那里。

开发者可通过调用此 API 来定义为不同的数量。默认为保留最近 5 条通知。

仅对通知有效。所谓保留最近的，意思是，如果有新的通知到达，之前列表里最老的那条会被移除。
例如，设置为保留最近 5 条通知。假设已经有 5 条显示在通知栏，当第 6 条到达时，第 1 条将会被移除。

#### 参数说明
- Object

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|notificationMaxNumber|number|最多显示的条数|

#### 示例
```javascript
jpushModule.setLatestNotificationNumber({
					'notificationMaxNumber':22
				});    
```

## 停止推送服务

### API - requestPermission()
在 Android 6.0 及以上的系统上，需要去请求一些用到的权限，JPush SDK 用到的一些需要请求如下权限，因为需要这些权限使统计更加精准，功能更加丰富，建议开发者调用。

"android.permission.READ_PHONE_STATE"
"android.permission.WRITE_EXTERNAL_STORAGE"
"android.permission.READ_EXTERNAL_STORAGE"
"android.permission.ACCESS_FINE_LOCATIO

#### 示例
```javascript
jpushModule.requestPermission();
```

## 统计分析 API

### API - onResume() / onPause()
本 API 用于“用户使用时长”，“活跃用户”，“用户打开次数”的统计，并上报到服务器，在 Portal 上展示给开发者。

#### 示例
```javascript
// 页面加载时调用：
jpushModule.onResume();

// 页面退出时调用：
jpushModule.onPause();
```


## 清除通知 API

### API - clearNotificationById()
此 API 提供清除通知的功能，清除指定某个通知。

#### 示例
```javascript
jpushModule.clearNotificationById();
```

### API - clearAllNotifications()
此 API 提供清除通知的功能，清除所有 JPush 展现的通知（不包括非 JPush SDK 展现的）；

#### 示例
```javascript
jpushModule.clearAllNotifications();
```

## 通知开关 API

### API - isNotificationEnabled(CALLBACK)
检查当前应用的通知开关是否开启

#### 参数说明

- CALLBACK

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|code|number| -1 - 检测失败 0 - 关闭 1 - 开启|

#### 示例
```javascript
jpushModule.isNotificationEnabled(result=>{//number
				let code = result.code
			});
```
## Android 厂商推送注意事项

厂商跳转需要配置应用原生的 Activity，具体配置参考[各厂商集成文档](https://docs.jiguang.cn/jpush/client/Android/android_sdk/)。

使用[极光 restapi 推送](https://docs.jiguang.cn/jpush/server/push/rest_api_v3_push/#notification)进行厂商推送时,需要配合设置对应的 "uri_action","uri_activity" 参数。

如不配置，将无法拿到厂商通知点击内容。

### 针对 Uniapp 插件预留的厂商跳转页面
Uniapp 插件用户可以直接指定以下跳转参数，轻松实现厂商的[通知点击事件回调](https://github.com/jpush/jpush-hbuilder-plugin/blob/master/doc/API.md#%E9%80%9A%E7%9F%A5%E4%BA%8B%E4%BB%B6%E5%9B%9E%E8%B0%83)兼容。

- "uri_action":"cn.jiguang.uniplugin_jpush.OpenClickActivity",
- "uri_activity":"cn.jiguang.uniplugin_jpush.OpenClickActivity"

### 自定义 Activity
如果您配置了自己的跳转 Activity，如需兼容插件[通知点击事件回调](https://github.com/jpush/jpush-hbuilder-plugin/blob/master/doc/API.md#%E9%80%9A%E7%9F%A5%E4%BA%8B%E4%BB%B6%E5%9B%9E%E8%B0%83)，可以通过调用以下原生方法实现：

```java
JSONObject thirdOpenNotification = JPushHelper.convertThirdOpenNotificationToMap(msgId, title, content, extras, data);
JPushHelper.sendNotifactionEvent(thirdOpenNotification, 0);
JPushHelper.saveOpenNotifiData(thirdOpenNotification, 0);
```




