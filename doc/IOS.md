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


