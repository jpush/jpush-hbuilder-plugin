
<script>
	var jpushModule = uni.requireNativePlugin("JG-JPushGoogle")
	export default {
		onLaunch: function() {
			console.log('App Launch')
			
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
			jpushModule.setLoggerEnable(true);
			jpushModule.addConnectEventListener(result=>{
				let connectEnable = result.connectEnable
				uni.$emit('connectStatusChange',connectEnable)
			});
			
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
