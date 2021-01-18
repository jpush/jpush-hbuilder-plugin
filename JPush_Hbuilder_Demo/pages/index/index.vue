<template>
    <div>
		<button type="primary" @click="requestNotificationAuthorization">检测通知授权状态</button>
		</br>
		<button type="primary" @click="openSettingsForNotification">打开通知设置界面</button>
		</br>
		<button type="primary" @click="setLoggerEnable">打开日志</button>
		</br>
		<button type="primary" @click="setLoggerUnEnable">关闭日志</button>
		</br>
		<button type="primary" @click="addTags">addTags fat old</button>
		</br>
		<button type="primary" @click="updateTags">updateTags fat thin young</button>
		</br>
		<button type="primary" @click="deleteTag">deleteTag fat </button>
		</br>
		<button type="primary" @click="deleteTags">deleteTags</button>
		</br>
		<button type="primary" @click="queryTags">queryTags</button>
		</br>
		<button type="primary" @click="queryTag">queryTag thin </button>
		</br>
		<button type="primary" @click="setAlias">setAlias jgcoder </button>
		</br>
		<button type="primary" @click="deleteAlias">deleteAlias </button>
		</br>
		<button type="primary" @click="queryAlias">queryAlias </button>
		</br>
		
    </div>
</template>

<script>
    // 首先需要通过 uni.requireNativePlugin("ModuleName") 获取 module 
    var jpushModule = uni.requireNativePlugin("JG-JPush")
	var seq = 1
    export default {
        methods: {
			
			openSettingsForNotification() {
				jpushModule.openSettingsForNotification((result)=>{
					uni.showToast({
						icon:'none',
						title: JSON.stringify(result),
						duration: 3000
					})
				})
			},
			
			requestNotificationAuthorization() {
				jpushModule.requestNotificationAuthorization((result)=>{
					uni.showToast({
						icon:'none',
						title: JSON.stringify(result),
						duration: 3000
					})
				})
			},
			
			setLoggerEnable() {
				jpushModule.setLoggerEnable(true)
			},
			
			setLoggerUnEnable() {
				jpushModule.setLoggerEnable(false)
			},
			
			addTags() {
				jpushModule.addTags({
					'tags':['fat','old'],
					'sequence': seq++
				},result=>{
					uni.showToast({
						icon:'none',
						title: JSON.stringify(result),
						duration: 3000
					})
				})
			},
			
			updateTags() {
				jpushModule.updateTags({
					'tags':['fat','thin','young'],
					'sequence': seq++
				},result=>{
					uni.showToast({
						icon:'none',
						title: JSON.stringify(result),
						duration: 3000
					})
				})
			},
			
			deleteTag() {
				jpushModule.deleteTag({
					'tags':['fat'],
					'sequence': seq++
				},result=>{
					uni.showToast({
						icon:'none',
						title: JSON.stringify(result),
						duration: 3000
					})
				})
			},
			
			deleteTags() {
				jpushModule.deleteTags({
					'sequence': seq++
				},result=>{
					uni.showToast({
						icon:'none',
						title: JSON.stringify(result),
						duration: 3000
					})
				})
			},
			
			queryTag() {
				jpushModule.queryTag({
					'tag':'thin',
					'sequence': seq++
				},result=>{
					uni.showToast({
						icon:'none',
						title: JSON.stringify(result),
						duration: 3000
					})
				})
			},
			
			queryTags() {
				jpushModule.queryTags({
					'sequence': seq++
				},result=>{
					uni.showToast({
						icon:'none',
						title: JSON.stringify(result),
						duration: 3000
					})
				})
			},
			
			setAlias() {
				jpushModule.setAlias({
					'alias':'jgcolder',
					'sequence': seq++
				},result=>{
					uni.showToast({
						icon:'none',
						title: JSON.stringify(result),
						duration: 3000
					})
				})
			},
			
			deleteAlias() {
				jpushModule.deleteAlias({
					'sequence': seq++
				},result=>{
					uni.showToast({
						icon:'none',
						title: JSON.stringify(result),
						duration: 3000
					})
				})
			},
			
			queryAlias() {
				jpushModule.queryAlias({
					'sequence': seq++
				},result=>{
					uni.showToast({
						icon:'none',
						title: JSON.stringify(result),
						duration: 3000
					})
				})
			},
			
			showToast(title,content){
				
			}

        }
    }
</script>
