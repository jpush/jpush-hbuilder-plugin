# JPush Hbuilder API

## 引用方式
```javascript
var jpushModule = uni.requireNativePlugin("JG-JPush");
```

## 设置 debug 模式

### API - setLoggerEnable(Boolean)
开启 debug 模式，默认是关闭

#### 参数说明
- true - 开启，false - 关闭

#### 示例
```javascript
jpushModule.setLoggerEnable(true);
```

## 获取 RegistrationID

### API - getRegistrationID(CALLBACK)
调用此 API 来取得应用程序对应的 RegistrationID。
只有当应用程序成功注册到 JPush 的服务器时才返回对应的值，否则返回空字符串

#### 参数说明
- CALLBACK

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|code|number|状态码 0 - 成功， 1011 - iOS模拟器调用会报此错误|
|registerID|string|返回的 registrationID|


#### 示例
```javascript
jpushModule.getRegistrationID(result=>{
					let registerID = result.registerID
				})	
```

## 打开通知设置页面 

### API - openSettingsForNotification(CALLBACK) 
跳转至系统设置页面

#### 参数说明

- CALLBACK

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|code|number|0 - 成功 1 - 失败|


#### 示例
```javascript
jpushModule.openSettingsForNotification((result)=>{
		let code = result.code
})
```

## 初始化函数

### API - initJPushService()

初始化SDK
iOS 说明:如果在mainfest.json里 将JPUSH_DEFAULTINITJPUSH_IOS值配置为"true"，插件内部将默认初始化JPush，用户则不需要调用该初始化方法。

#### 示例
```javascript
jpushModule.initJPushService()
```


## 连接状态回调

### API - addConnectEventListener(CALLBACK)

#### 参数说明

- CALLBACK

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|connectEnable|boolean|true - 已连接, false - 未连接|

#### 示例
```javascript
jpushModule.addConnectEventListener(result=>{
				let connectEnable = result.connectEnable
			})
```



## 通知事件回调

###  API - addNotificationListener(CALLBACK)
通过CALLBACK 的 notificationEventType字段 区分 是 通知收到 还是 点击通知

#### 参数说明

- CALLBACK

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|messageID|string|唯一标识通知消息的 ID|
|title|string|对应 Portal 推送通知界面上的“通知标题”字段|
|content|string|对应 Portal 推送通知界面上的“通知内容”字段|
|badge|string|对应 Portal 推送通知界面上的可选设置里面的“badge”字段 (ios only)|
|ring|string|推送通知界面上的可选设置里面的“sound”字段 (ios only)|
|extras|dictionary|对应 Portal 推送消息界面上的“可选设置”里的附加字段|
|iOS|dictionary|对应原生返回的通知内容，如需要更多字段请查看该字段内容|
|android|dictionary|对应原生返回的通知内容，如需要更多字段请查看该字段内容|
|notificationEventType|string|分为notificationArrived和notificationOpened两种|

#### 示例
```javascript
jpushModule.addNotificationListener(result=>{
				let notificationEventType = result.notificationEventType
				let messageID = result.messageID
				let title = result.title
				let content = result.content
				let extras = result.extras
			})
```

## 自定义消息事件回调

###  API - addCustomMessageListener(CALLBACK)
监听 Portal 发送的自定义消息

#### 参数说明

- CALLBACK

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|messageID|string|唯一标识通知消息的 ID|
|content|string|对应 Portal 推送通知界面上的“通知内容”字段|
|extras|dictionary|对应 Portal 推送消息界面上的“可选设置”里的附加字段|

#### 示例
```javascript
jpushModule.addCustomMessageListener(result=>{
				let messageID = result.messageID
				let content = result.content
				let extras = result.extras
			})
```


## 应用内消息回调

### API - addInMessageListener(CALLBACK)

#### 参数说明
- CALLBACK

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|eventType|string|show - 应用内消息展示 disappear - 应用内消息已消失 click - 应用内消息点击|
|messageType|string|消息类型, eventType 不为 disappear时返回, inMessageNoti - 通知类型的inMessage|
|content|dictionary|应用内消息内容, eventType 不为 disappear 时返回|

#### 示例
```javascript
jpushModule.addInMessageListener(result=>{
				let type = result.type
				let messageType = result.messageType
				let content = result.content
			})
```

## 本地通知事件回调

### API - addLocalNotificationListener(CALLBACK)

#### 参数说明

- CALLBACK

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|messageID|string|唯一标识通知消息的ID|
|title|string|对应“通知标题”字段|
|content|string|对应“通知内容”字段|
|extras|dictionary|对应“附加内容”字段|

#### 示例
```javascript
jpushModule.addLocalNotificationListener(result=>{
				let messageID = result.messageID
				let title = result.title
				let content = result.content
				let extras = result.extras
				
			})
```

## 添加一个本地通知

### API - addLocalNotification(Object)
添加一个本地通知

### 参数说明

- Object

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|messageID|string|唯一标识通知消息的ID|
|title|string|对应“通知标题”字段|
|content|string|对应“通知内容”字段|
|extras|dictionary|对应“附加内容”字段|

#### 示例
```javascript
jpushModule.addLocalNotification({
					messageID:'123',
					title:'title',
					content:'content',
					extras:{
						name: 'Cindy',
						age: '16'
					}
				})
```

## 移除指定的本地通知

### API - removeLocalNotification(Object)
移除指定的本地通知

#### 参数说明

- CALLBACK

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|messageID|string|唯一标识通知消息的ID|

#### 示例
```javascript
jpushModule.removeLocalNotification({
					messageID:'123'
				})
```

## 移除所有的本地通知

### API - clearLocalNotifications()
移除所有的本地通知

#### 示例
```javascript
jpushModule.clearLocalNotifications()
```

## 标签别名事件回调

### API - addTagAliasListener(CALLBACK)

#### 参数说明

- CALLBACK

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|code|number|请求状态码 0 - 成功|
|sequence|number|请求时传入的序列号,会在回调时原样返回|
|tags|StringArray|执行tag数组操作时返回|
|tag|string|执行查询指定tag(queryTag)操作时会返回|
|tagEnable|boolean|执行查询指定tag(queryTag)操作时会返回是否可用|
|alias|string|对alias进行操作时返回|

#### 示例

```javascript
jpushModule.addTagAliasListener(result=>{
					let code = result.code
					let sequence = result.sequence
					let tags = result.tags
					let tag = result.tag
					let tagEnable = result.tagEnable
					let alias = result.alias
				})
```


## 新增标签

### API - addTags(Object)
这个接口是增加逻辑，而不是覆盖逻辑

#### 参数说明
- Object

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|sequence|number|请求时传入的序列号，会在回调时原样返回|
|tags|StringArray|string类型的数组|

#### 示例
```javascript
jpushModule.addTags({
					'tags':['beauty','rich'],
					'sequence': 1
				})
```

## 覆盖标签

### API - updateTags(Object)
需要理解的是，这个接口是覆盖逻辑，而不是增量逻辑。即新的调用会覆盖之前的设置

#### 参数说明
- Object

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|sequence|number|请求时传入的序列号，会在回调时原样返回|
|tags|StringArray|string类型的数组|

#### 示例
```javascript
jpushModule.updateTags({
					'tags':['beauty','rich'],
					'sequence': 1
				})
```


## 删除指定标签

### API - deleteTags(Object)
删除指定标签

#### 参数说明
- Object

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|sequence|number|请求时传入的序列号，会在回调时原样返回|
|tags|StringArray|string类型的数组|

#### 示例
```javascript
jpushModule.deleteTags({
					'tags':['beauty','rich'],
					'sequence': 1
				})
```


## 清除所有标签

### API - cleanTags(Object)
清除所有标签

#### 参数说明
- Object

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|sequence|number|请求时传入的序列号，会在回调时原样返回|

#### 示例
```javascript
jpushModule.cleanTags({
					'sequence': 1
				})
```


## 查询指定 tag 与当前用户绑定的状态

### API - queryTag(Object)
查询指定 tag 与当前用户绑定的状态

#### 参数说明
- Object

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|sequence|number|请求时传入的序列号，会在回调时原样返回|
|tag|string|需要查询的标签|


#### 示例
```javascript
jpushModule.queryTag({
					'tag':'beauty',
					'sequence': 1
				})
```


## 查询所有标签

### API - getAllTags(Object)
查询所有标签

#### 参数说明
- Object

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|sequence|number|请求时传入的序列号，会在回调时原样返回|


#### 示例
```javascript
jpushModule.getAllTags({
					'sequence': 1
				})
```


## 设置别名

### API - setAlias(Object)
每次调用设置有效的别名，覆盖之前的设置

#### 参数说明
- Object

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|sequence|number|请求时传入的序列号，会在回调时原样返回|
|alias|string|有效的别名组成：字母（区分大小写）、数字、下划线、汉字、特殊字符@!#$&\*+=.\||

#### 示例
```javascript
jpushModule.setAlias({
                'alias' : 'coder',
					'sequence': 1
				})
```

## 删除别名

### API - deleteAlias(Object)
删除别名

#### 参数说明
- Object

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|sequence|number|请求时传入的序列号，会在回调时原样返回|


#### 示例
```javascript
jpushModule.deleteAlias({
					'sequence': 1
				})
```


## 查询别名

### API - queryAlias(Object)
删除别名

#### 参数说明
- Object

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|sequence|number|请求时传入的序列号，会在回调时原样返回|


#### 示例
```javascript
jpushModule.queryAlias({
					'sequence': 1
				})
```


## 开启 CrashLog 上报

### API - initCrashHandler()
开启Crash日志收集，默认是关闭状态。

#### 示例
```javascript
jpushModule.initCrashHandler()
```

## 设置地理围栏的最大个数

### API - setMaxGeofenceNumber(number)
默认值为 10 ，iOS系统默认地理围栏最大个数为20

#### 示例
```javascript
jpushModule.setMaxGeofenceNumber(15)
```

## 删除指定id的地理围栏

### API - deleteGeofence(string)
 删除指定id的地理围栏

#### 示例
```javascript
jpushModule.deleteGeofence('beijing')
```


## 设置 Badge

### API - setBadge(number)

本接口用于配合 JPush 提供的服务器端角标功能.
iOS:该功能解决的问题是, 服务器端推送 APNs 时, 并不知道客户端原来已经存在的角标是多少, 指定一个固定的数字不太合理.

 - 通过本 API 把当前客户端(当前这个用户的) 的实际 badge 设置到服务器端保存起来;
 - 调用服务器端 API 发 APNs 时(通常这个调用是批量针对大量用户),
   使用 "+1" 的语义, 来表达需要基于目标用户实际的 badge 值(保存的) +1 来下发通知时带上新的 badge 值;

Android:仅支持华为

#### 示例
```javascript
jpushModule.setBadge(10)
```

## 设置手机号码

### API - setMobileNumber(Object)
设置手机号码后，可实现“推送不到短信到”的通知方式，提高推送达到率。

#### 参数说明

- Object

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|mobileNumber|string|手机号码 会与用户信息一一对应。可为空，为空则清除号码。|
|sequence|number|请求时传入的序列号,会在回调时原样返回|


#### 示例
```javascript
jpushModule.setMobileNumber({
					mobileNumber: '15889230000'
				})
```

## 设置手机号码回调

### API - addMobileNumberListener(CALLBACK)

#### 参数说明

- CALLBACK

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|code|number|状态码 0 - 成功|
|sequence|number|请求时传入的序列号,会在回调时原样返回|

#### 示例
```javascript
jpushModule.addMobileNumberListener(result=>{
		let code = result.code
	})
```


## 错误码

请参考[极光官网](https://docs.jiguang.cn/jpush/client/iOS/ios_api/)

