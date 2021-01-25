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

## 初始化函数

### API - initJPushService()
如果在mainfest.json里 将JPUSH_DEFAULTINITJPUSH_IOS值配置为"true"，就不需要调用该初始化方法。

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
|connectEvent|number|0 - 正在连接中 1 - 建立连接 2 - 关闭连接 3 - 注册成功 4 - 注册失败 5 - 登录成功|

#### 示例
```javascript
jpushModule.addConnectEventListener(result=>{
				let connectEvent = result.connectEvent
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


## 设置是否允许应用内消息弹出

### API - setIsAllowedInMessagePop(Boolean)
设置是否允许应用内消息弹出,默认为允许

#### 参数说明
- true - 允许，false - 不允许

#### 示例
```javascript
jpushModule.setIsAllowedInMessagePop(true)
```

## 应用内消息回调

### API - addInMessageListener(CALLBACK)

#### 参数说明
- CALLBACK

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|eventType|string|show - 应用内消息展示 disappear - 应用内消息已消失 click - 应用内消息点击|
|messageType|string|消息类型, eventType 不为 disappear时返回, inMessageAd - 广告类型的inMessage inMessageNoti - 通知类型的inMessage|
|content|dictionary|应用内消息内容, eventType 不为 disappear 时返回|

#### 示例
```javascript
jpushModule.addCustomMessageListener(result=>{
				let type = result.type
				let messageType = result.messageType
				let content = result.content
			})
```


## 地理围栏事件回调

###  API - addGeofenceListener(CALLBACK)
地理围栏事件监听

#### 参数说明

- CALLBACK

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|code|string|状态码 0 - 成功|
|msg|string|状态码不为0时返回的错误信息|
|type|string|地理围栏事件 enter - 进入地理围栏区域 exit - 离开地理围栏区域|
|geofenceId|string|地理围栏id|
|userInfo|dictionary|地理围栏触发时返回的信息|

#### 示例
```javascript
jpushModule.addGeofenceListener(result=>{
				let code = result.code
				let type = result.type
				let geofenceId = result.geofenceId
				let userInfo = result.userInfo
			})
```

## 新增标签

### API - addTags(Object,CALLBACK)
这个接口是增加逻辑，而不是覆盖逻辑

#### 参数说明
- Object

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|sequence|number|请求时传入的序列号，会在回调时原样返回|
|tags|StringArray|string类型的数组|

- CALLBACK

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|code|number|请求状态码 0 - 成功|
|sequence|number|请求时传入的序列号|
|tags|StringArray|string类型的数组|

#### 示例
```javascript
jpushModule.addTags({
					'tags':['beauty','rich'],
					'sequence': 1
				},result=>{
					let code = result.code
					let sequence = result.sequence
					let tags = result.tags
				})
```

## 覆盖标签

### API - updateTags(Object,CALLBACK)
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
				},result=>{
					let code = result.code
					let sequence = result.sequence
					let tags = result.tags
				})
```


## 删除指定标签

### API - deleteTags(Object,CALLBACK)
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
				},result=>{
					let code = result.code
					let sequence = result.sequence
					let tags = result.tags
				})
```


## 清除所有标签

### API - cleanTags(Object,CALLBACK)
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
				},result=>{
					let code = result.code
					let sequence = result.sequence
					let tags = result.tags
				})
```


## 查询指定 tag 与当前用户绑定的状态

### API - queryTag(Object,CALLBACK)
查询指定 tag 与当前用户绑定的状态

#### 参数说明
- Object

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|sequence|number|请求时传入的序列号，会在回调时原样返回|
|tag|string|需要查询的标签|

- CALLBACK

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|tagEnable|number|0 - 没绑定 1 - 绑定|

#### 示例
```javascript
jpushModule.queryTag({
					'tag':'beauty',
					'sequence': 1
				},result=>{
					let code = result.code
					let sequence = result.sequence
					let tags = result.tags
					let tagEnable = result.tagEnable
				})
```


## 查询所有标签

### API - getAllTags(Object,CALLBACK)
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
				},result=>{
					let code = result.code
					let sequence = result.sequence
					let tags = result.tags
				})
```


## 设置别名

### API - setAlias(Object,CALLBACK)
每次调用设置有效的别名，覆盖之前的设置

#### 参数说明
- Object

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|sequence|number|请求时传入的序列号，会在回调时原样返回|
|alias|string|有效的别名组成：字母（区分大小写）、数字、下划线、汉字、特殊字符@!#$&*+=.|

- CALLBACK

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|code|number|状态码 0 - 成功|
|sequence|number|请求时传入的序列号，会在回调时原样返回|
|alias|string|别名|



#### 示例
```javascript
jpushModule.setAlias({
                'alias' : 'coder',
					'sequence': 1
				},result=>{
					let code = result.code
					let sequence = result.sequence
					let alias = result.alias
				})
```

## 删除别名

### API - deleteAlias(Object,CALLBACK)
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
				},result=>{
					let code = result.code
					let sequence = result.sequence
					let alias = result.alias
				})
```


## 查询别名

### API - queryAlias(Object,CALLBACK)
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
				},result=>{
					let code = result.code
					let sequence = result.sequence
					let alias = result.alias
				})
```


## 开启 CrashLog 上报

### API - initCrashHandler()
开启Crash日志收集，默认是关闭状态。

#### 示例
```javascript
jpushModule.initCrashHandler()
```

## 获取通知的授权状态
### API - requestNotificationAuthorization(CALLBACK)
获取通知的授权状态

#### 参数说明

- CALLBACK

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|status|number|0 - NotDetermined 1 - Denied 2 - Authorized 3 - Provisional (ios 12 及以上才有)|

#### 示例
```javascript
jpushModule.requestNotificationAuthorization((result)=>{
		let status = result.status
})
```

## 打开通知设置页面 (iOS Only)

### API - openSettingsForNotification(CALLBACK) 
跳转至系统设置页面，iOS8及以上有效

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

## 获取系统定位服务是否开启（iOS only）

对应iOS设备的［设置］－［隐私］－［定位］按钮是否开启

### API - locationServicesEnabled()
返回值 boolean类型 true - 开启 false - 关闭

#### 示例

```javascript
let enable = jpushModule.locationServicesEnabled()
```

## 获取用户定位权限状态（iOS only）

### API - getLocationAuthorizationStatus()

#### 返回值
int类型 
参考 requestLocationAuthorization(CALLBACK) 方法返回值status字段

#### 示例

```javascript
let authorizationStatus = jpushModule.getLocationAuthorizationStatus()
```

## 请求定位权限 （iOS only）

### API - requestLocationAuthorization(CALLBACK)

#### 参数说明
- CALLBACK

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|status|number|0 - kCLAuthorizationStatusNotDetermined <br>1 - kCLAuthorizationStatusRestricted <br>2 - kCLAuthorizationStatusDenied <br>3 - kCLAuthorizationStatusAuthorizedAlways <br>4 - kCLAuthorizationStatusAuthorizedWhenInUse <br>5 - kCLAuthorizationStatusAuthorized|

#### 示例

```javascript
jpushModule.requestLocationAuthorization((result)=>{
					let status = result.status
				})
```


## 设置地理围栏的最大个数

### API - setMaxGeofenceNumber(number)
默认值为 10 ，iOS系统默认地理围栏最大个数为20

#### 示例
```javascript
jpushModule.setMaxGeofenceNumber(15)
```

## 删除指定id的地理围栏

### API - setMaxGeofenceNumber(string)
 删除指定id的地理围栏

#### 示例
```javascript
jpushModule.deleteGeofence('beijing')
```

## 注册voip服务

### API - initVoipService()

#### 示例
```javascript
jpushModule.initVoipService()
```

## voip消息回调

### API - addVoipPushIncomingListener(CALLBACK)

#### 参数说明

- CALLBACK

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|payload|dictionary|收到的voip消息|

#### 示例
```javascript
jpushModule.openSettingsForNotification((result)=>{
		let payload = result.payload
})
```


## 设置 Badge (iOS Only)

### API - setBadge(Object)

#### 参数说明

- Object

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|badge|number|JPush封装badge功能，允许应用上传 badge 值至 JPush 服务器，由 JPush 后台帮助管理每个用户所对应的推送 badge 值，简化了设置推送 badge 的操作。设置的值小于0时，sdk不作处理。|
|appBadge|number|iOS 用来标记应用程序状态的一个数字，出现在程序图标右上角。设置的值小于0时，sdk不作处理。|

#### 示例
```javascript
jpushModule.setBadge({
					badge: 10,
					appBadge: 11,
				})
```

## 设置手机号码

### API - setMobileNumber(string,CALLBACK)
设置手机号码后，可实现“推送不到短信到”的通知方式，提高推送达到率。

#### 参数说明
- string 手机号码 会与用户信息一一对应。可为空，为空则清除号码

#### 示例
```javascript
jpushModule.setMobileNumber('15889230000',result=>{
					let code = result.code
				})
```

## 地理位置上报

### API - setLocation(Object)

#### 参数说明

- Object

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|latitude|number|纬度|
|longitude|number|经度|


#### 示例
```javascript
jpushModule.setLocation({
					latitude: 22.27,
					longitude: 113.46,
				})
```

## 设置地理位置权限开关

### API - setLocationEanable(Boolean)
关闭地理位置之后，SDK地理围栏的相关功能将受到影响，默认是开启。

#### 参数说明

- true - 开启, false - 关闭

#### 示例
```javascript
jpushModule.setLocationEanable(true)
```


