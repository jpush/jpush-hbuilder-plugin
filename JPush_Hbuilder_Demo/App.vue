
<script>
	var jpushModule = uni.requireNativePlugin("JG-JPush")
	export default {
		onLaunch: function() {
			console.log('App Launch')
			
			
			jpushModule.addConnectEventListener(result=>{
				let connectEvent = result.connectEvent
				console.log(connectEvent)
			})
			
			jpushModule.requestNotificationAuthorization((result)=>{
				let status = result.status
				if (status < 2) {
					uni.showToast({
						icon: 'none',
						title: '您还没有打开通知权限',
						duration: 3000
					})
				}
			})
			
			jpushModule.addConnectEventListener(result=>{
				let connectEvent = result.connectEvent
			})
			
			jpushModule.addNotificationListener(result=>{
				let notificationEventType = result.notificationEventType
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
			
			jpushModule.setIsAllowedInMessagePop(true)
			jpushModule.addCustomMessageListener(result=>{
				let type = result.type
				let messageType = result.messageType
				let content = result.content
				uni.showToast({
					icon: 'none',
					title: JSON.stringify(result),
					duration: 3000
				})
			})
			
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
			})
			
			jpushModule.addInMessageListener(result=>{
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
