# JPush Hbuilder API

## 引用方式
```javascript
var jpushModule = uni.requireNativePlugin("JG-JPush");
```

## 获取通知的授权状态
### API - requestNotificationAuthorization(CALLBACK)
获取通知的授权状态

#### 示例
```javascript
jpushModule.requestNotificationAuthorization((result)=>{
		let code = result.code
		let status = result.status
})
```



