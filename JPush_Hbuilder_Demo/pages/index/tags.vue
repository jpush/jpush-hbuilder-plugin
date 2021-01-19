<template>
    <div>
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
		
    </div>
</template>

<script>
	// 首先需要通过 uni.requireNativePlugin("ModuleName") 获取 module
	var jpushModule = uni.requireNativePlugin("JG-JPush")
	var seq = 1
	export default{
		data() {
			return {
				inputTags: '',
				inputAlias: '',
			}
		},
		methods: {
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
