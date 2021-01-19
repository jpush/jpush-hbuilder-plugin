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
		<button type="primary" @click="getRegistrationID">获取注册id</button>
		</br>
		<button type="primary" @click="addLocalNotification">创建一个本地通知</button>
		</br>
		
		<view>
			<input placeholder="请使用tags,作为分隔符" v-model="inputTags"/>
			</br>
			<input placeholder="请输入alias" v-model="inputAlias"/>
			</br>
			<label type="primary" @click="addTags" style="margin-right: 50rpx;">增加tags</label>
			<label type="primary" @click="updateTags" style="margin-right: 50rpx;">覆盖tags</label>
			<label type="primary" @click="queryTags" style="margin-right: 50rpx;">查询Tags</label>
			</br>
			</br>
			<label type="primary" @click="deleteTag" style="margin-right: 30rpx;">删除tags </label>
			<label type="primary" @click="deleteTags" style="margin-right: 30rpx;">清空tags</label>
			<label type="primary" @click="queryTag" style="margin-right: 30rpx;">验证tag </label>
			</br>
			</br>
			<label type="primary" @click="setAlias" style="margin-right: 30rpx;">设置 Alias</label>
			<label type="primary" @click="deleteAlias" style="margin-right: 30rpx;">删除Alias </label>
			<label type="primary" @click="queryAlias" style="margin-right: 30rpx;">查询Alias </label>
		
		</view>
		
		</br>
		</br>
		
		<view>
			<input placeholder="请输入badge"/>
			</br>
			<label @click='setBadge' v-model="inputBadge">设置角标</label>
			</br>
			</br>
			<input placeholder="请输入电话号码" v-model="inputPhoneNumber"/>
			</br>
			<label @click='setMobileNumber'>设置电话号码</label>
			</br>
			</br>
			</br>
			</br>
			</br>
		</view>
		
		
    </div>
</template>

<script>
    // 首先需要通过 uni.requireNativePlugin("ModuleName") 获取 module 
    var jpushModule = uni.requireNativePlugin("JG-JPush")
	var seq = 1
    export default {
		
		data() {
			return {
				inputTags: '',
				inputAlias: '',
				inputPhoneNumber: '',
				inputBadge: '',
				inputPhoneNumber: ''
			}
		},
		
        methods: {
			
			openSettingsForNotification() {
				jpushModule.openSettingsForNotification((result)=>{
					this.showToast(result)
				})
			},
			
			requestNotificationAuthorization() {
				jpushModule.requestNotificationAuthorization((result)=>{
					let code = result.code
					let status = result.status
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
					this.showToast(result)
				})	
			},
			
			addLocalNotification() {
				jpushModule.addLocalNotification({
					messageID:'123',
					title:'title',
					content:'content',
					extras:{
						delay: 10,
						badge: 8,
					}
				})
			},
			
			addTags() {
				var tags = this.inputTags.split(',')
				jpushModule.addTags({
					'tags':tags,
					'sequence': seq++
				},result=>{
					this.showToast(result)
				})
			},
			
			updateTags() {
				var tags = this.inputTags.split(',')
				jpushModule.updateTags({
					'tags':tags,
					'sequence': seq++
				},result=>{
					this.showToast(result)
				})
			},
			
			deleteTag() {
				var tags = this.inputTags.split(',')
				jpushModule.deleteTag({
					'tags':tags,
					'sequence': seq++
				},result=>{
					this.showToast(result)
				})
			},
			
			deleteTags() {
				jpushModule.deleteTags({
					'sequence': seq++
				},result=>{
					this.showToast(result)
				})
			},
			
			queryTag() {
				var tag = this.inputTags
				jpushModule.queryTag({
					'tag':tag,
					'sequence': seq++
				},result=>{
					this.showToast(result)
				})
			},
			
			queryTags() {
				jpushModule.queryTags({
					'sequence': seq++
				},result=>{
					this.showToast(result)
				})
			},
			
			setAlias() {
				let alias = this.inputAlias
				jpushModule.setAlias({
					'alias':alias,
					'sequence': seq++
				},result=>{
					this.showToast(result)
				})
			},
			
			deleteAlias() {
				jpushModule.deleteAlias({
					'sequence': seq++
				},result=>{
					this.showToast(result)
				})
			},
			
			queryAlias() {
				jpushModule.queryAlias({
					'sequence': seq++
				},result=>{
					this.showToast(result)
				})
			},
			
			setMobileNumber() {
				let mobileNumber = this.inputPhoneNumber
				jpushModule.setMobileNumber(mobileNumber,result=>{
					this.showToast(result)
				})
			},
			
			setBadge(){
				jpushModule.setBadge({
					badge: 10,
					appBadge: 11,
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
