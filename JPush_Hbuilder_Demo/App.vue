<script>
	var jpushModule = uni.requireNativePlugin("JG-JPush")
	export default {
		onLaunch: function() {
			console.log('App Launch')
			
			jpushModule.addPushNotificationReceiveListener(result=>{
				uni.showToast({
					icon: 'none',
					title: JSON.stringify(result)
				})
			})
			
			testModule.addPushNotificationOpenListener(result=>{
				uni.showToast({
					icon: 'none',
					title: JSON.stringify(result)
				})
			})
			
			testModule.addCustomNotificationReceiveListener(result=>{
				uni.showToast({
					icon: 'none',
					title: JSON.stringify(result)
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
