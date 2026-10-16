<template>
    <div>
		</br>
		</br>
		<label style="margin-right: 50rpx;">网络状态:</label>
		<label>{{connectStatus}}</label>
		</br>
		<label style="margin-right: 50rpx;">RegistrationID:</label>
		<label>{{registrationID}}</label>
		</br>
		</br>
		
		<label>---------------------------------</label>
		<button type="primary" @click="openSettingsForNotification">打开通知设置界面</button>
		</br>
		<button type="primary" @click="setLoggerEnable">打开日志</button>
		</br>
		<button type="primary" @click="setLoggerUnEnable">关闭日志</button>
		</br>
		<button type="primary" @click="getRegistrationID">获取注册id</button>
		
    </div>
</template>

<script>
	import { getConnectionState } from '../../common/connection-state.js'
	import { getCachedRegistrationID, updateRegistrationID } from '../../common/registration-state.js'
    // 首先需要通过 uni.requireNativePlugin("ModuleName") 获取 module 
    var jpushModule = uni.requireNativePlugin("JG-JPush")
    export default {
		
		data() {
			return {
				connectStatus: '未链接',
				registrationID: '未获得',
			}
		},
		
		onShow() {
			this.applyConnectionState(getConnectionState())
			this.applyRegistrationID(getCachedRegistrationID())
			this.getRegistrationID()
			if(uni.getSystemInfoSync().platform == "ios"){
				// iOS端使用应用内消息需要在页面进入和离开的时候配置pageEnterTo和pageLeave
				jpushModule.pageEnterTo("HomePage");
			}
		},
		
		onHide() {
			if(uni.getSystemInfoSync().platform == "ios"){
				jpushModule.pageLeave("HomePage");
			}
		},
		
		onLoad() {
			console.log('开始监听连接状态')
			this.connectionListener = connected => this.applyConnectionState(connected)
			uni.$on('connectStatusChange', this.connectionListener)
			this.registrationListener = registrationID => this.applyRegistrationID(registrationID)
			uni.$on('registrationIDChange', this.registrationListener)
			this.applyConnectionState(getConnectionState())
			this.applyRegistrationID(getCachedRegistrationID())
		},
		
		onUnload() {  
			// 移除监听事件  
		    uni.$off('connectStatusChange', this.connectionListener)
		    uni.$off('registrationIDChange', this.registrationListener)
		},
		
        methods: {
			applyRegistrationID(registrationID) {
				if (registrationID) this.registrationID = registrationID
			},
			applyConnectionState(connected) {
				if (typeof connected !== 'boolean') return
				this.connectStatus = connected ? '已连接' : '未连接'
				console.log('页面同步连接状态', connected)
				if (connected) this.getRegistrationID()
			},
			
			openSettingsForNotification() {
				jpushModule.openSettingsForNotification((result)=>{
					this.showToast(result)
				})
			},
			
			setLoggerEnable() {
				jpushModule.setLoggerEnable(true)
			},
			
			setLoggerUnEnable() {
				jpushModule.setLoggerEnable(false)
			},
			
			getRegistrationID() {
				jpushModule.getRegistrationID(result=>{
					let registerID = result.registerID
					console.log(registerID)
					updateRegistrationID(registerID)
				})	
			},
			
			showToast(result){
				uni.showToast({
					icon:'none',
					title: JSON.stringify(result),
					duration: 3000
				})
			}

        }
    }
</script>
