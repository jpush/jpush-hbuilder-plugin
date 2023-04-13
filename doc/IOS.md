# JPush Hbuilder API Only for iOS

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


## 获取系统定位服务是否开启

对应iOS设备的［设置］－［隐私］－［定位］按钮是否开启

### API - locationServicesEnabled()
返回值 boolean类型 true - 开启 false - 关闭

#### 示例

```javascript
let enable = jpushModule.locationServicesEnabled()
```

## 获取用户定位权限状态

### API - getLocationAuthorizationStatus()

#### 返回值
int类型 
参考 requestLocationAuthorization(CALLBACK) 方法返回值status字段

#### 示例

```javascript
let authorizationStatus = jpushModule.getLocationAuthorizationStatus()
```

## 请求定位权限 

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

## DeviceToken信息回调

###  API - addDeviceTokenListener(CALLBACK)
DeviceToken回调监听

#### 参数说明

- CALLBACK

|参数名称|参数类型|参数说明|
|:-----:|:----:|:-----:|
|code|string|状态码 0 - 成功|
|msg|string|状态码不为0时返回的错误信息|
|deviceToken|string|状态码为0时返回的deviceToken|

#### 示例
```javascript
jpushModule.addDeviceTokenListener(result=>{
					let code = result.code
					if (code == 0) {
						let deviceToken = result.deviceToken
					}else {
						let error = result.msg
					}
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


## 注册voip服务

### API - initVoipService()

iOS9.0及以上可用

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
jpushModule.addVoipPushIncomingListener((result)=>{
		let payload = result.payload
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

## 进入页面

### API - pageEnterTo(String)
进入页面，使用应用内消息功能，需要配置该函数，与pageLeave函数配套使用

#### 参数说明

- String ： 页面名

#### 示例
```javascript
jpushModule.pageEnterTo("页面名称")
```

## 离开页面

### API - pageLeave(String)
离开页面，使用应用内消息功能，需要配置该函数，与pageEnterTo函数配套使用

#### 参数说明

- String ： 页面名

#### 示例
```javascript
jpushModule.pageLeave("页面名称")
```


