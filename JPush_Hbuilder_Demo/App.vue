


<script>
	var jpushModule = uni.requireNativePlugin("JG-JPush")
	export default {
		onLaunch: function() {
			console.log('App Launch')
			
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
			
			
			jpushModule.addNotificationListener(result=>{
				uni.showToast({
					icon: 'none',
					title: JSON.stringify(result),
					duration: 3000
				})
			})
			
			jpushModule.addCustomMessageListener(result=>{
				uni.showToast({
					icon: 'none',
					title: JSON.stringify(result),
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
