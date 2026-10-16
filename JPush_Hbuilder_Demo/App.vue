
<script>
	import { updateConnectionState } from './common/connection-state.js'
	import { updateRegistrationID } from './common/registration-state.js'
	var jpushModule = uni.requireNativePlugin("JG-JPush")
	export default {
		onLaunch: function() {
			console.log('App Launch')
			jpushModule.setLoggerEnable(true);
			
			if(uni.getSystemInfoSync().platform == "ios"){
				// 请求定位权限
				let locationServicesEnabled = jpushModule.locationServicesEnabled()
				let locationAuthorizationStatus = jpushModule.getLocationAuthorizationStatus()
				console.log('locationAuthorizationStatus',locationAuthorizationStatus)	
				if (locationServicesEnabled == true && locationAuthorizationStatus < 3) {
					jpushModule.requestLocationAuthorization((result)=>{
						console.log('定位权限',result.status)
					})
				};
				
				
				jpushModule.requestNotificationAuthorization((result)=>{
					let status = result.status
					if (status < 2) {
						uni.showToast({
							icon: 'none',
							title: '您还没有打开通知权限',
							duration: 3000
						})
					}
				});

				jpushModule.addGeofenceListener(result=>{
					let code = result.code
					let type = result.type
					let geofenceId = result.geofenceId
					let userInfo = result.userInfo
					uni.showToast({
						icon: 'none',
						title: '触发地理围栏',
						duration: 3000
					})
				});
				
				// 监听deviToken的状态
				jpushModule.addDeviceTokenListener(result=>{
					let code = result.code
					if (code == 0) {
						let deviceToken = result.deviceToken
						uni.showToast({
							icon: 'none',
							title: deviceToken,
							duration: 3000
						})
						console.log("deviceToken:", deviceToken)
					}else {
						let error = result.msg
					}
				})
			
			};
			
			jpushModule.initJPushService();
			jpushModule.addConnectEventListener(result => {
				console.log('JPush连接状态回调', result.connectEnable)
				updateConnectionState(result.connectEnable)
			});
			// Android getRegistrationID can first return empty, then supply the RID
			// through command 2005. Keep this listener ready before the first query.
			if (uni.getSystemInfoSync().platform === 'android') {
				jpushModule.addCommandListener(result => {
					if (result.command === 2005 && result.commandResult === 0) {
						updateRegistrationID(result.commandMessage)
					}
				});
			}

			jpushModule.addNotificationListener(result=>{
				let notificationEventType = result.notificationEventType
				let messageID = result.messageID
				let title = result.title
				let content = result.content
				let extras = result.extras
				console.log("addNotificationListener:", result)
				uni.showToast({
					icon: 'none',
					title: JSON.stringify(result),
					duration: 3000
				})
				if (notificationEventType == "notificationOpened") {
					uni.navigateTo({
						url:"/pages/index/jump"
					})
				}
			});
			
			jpushModule.addCustomMessageListener(result=>{
				let type = result.type
				let messageType = result.messageType
				let content = result.content
				uni.showToast({
					icon: 'none',
					title: JSON.stringify(result),
					duration: 3000
				})
			});
			 jpushModule.addInMessageListener(result=>{
            				uni.showToast({
            					icon:'none',
            					title: JSON.stringify(result),
            					duration: 3000
            				})
            			});
			jpushModule.addLocalNotificationListener(result=>{
				let messageID = result.messageID
				let title = result.title
				let content = result.content
				let extras = result.extras
				uni.showToast({
					icon: 'none',
					title: JSON.stringify(result),
					duration: 3000
				})
			})
			
		},
		onShow: function() {
			console.log('App Show')
		},
		onHide: function() {
			console.log('App Hide')
		}
	}
</script>

<style>
	/*每个页面公共css */
</style>
