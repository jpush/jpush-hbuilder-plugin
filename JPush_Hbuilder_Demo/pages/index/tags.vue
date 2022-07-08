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
	var jpushModule = uni.requireNativePlugin("JG-JPush-Google")
	var seq = 1
	jpushModule.addTagAliasListener(result=>{
		uni.showToast({
			icon:'none',
			title: JSON.stringify(result),
			duration: 3000
		})
	})
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
				})
			},
			
			updateTags() {
				var tags = this.inputTags.split(',')
				jpushModule.updateTags({
					'tags':tags,
					'sequence': seq++
				})
			},
			
			deleteTag() {
				var tags = this.inputTags.split(',')
				jpushModule.deleteTags({
					'tags':tags,
					'sequence': seq++
				})
			},
			
			deleteTags() {
				jpushModule.cleanTags({
					'sequence': seq++
				})
			},
			
			queryTag() {
				var tag = this.inputTags
				jpushModule.queryTag({
					'tag':tag,
					'sequence': seq++
				})
			},
			
			queryTags() {
				jpushModule.getAllTags({
					'sequence': seq++
				})
			},
			
			setAlias() {
				let alias = this.inputAlias
				jpushModule.setAlias({
					'alias':alias,
					'sequence': seq++
				})
			},
			
			deleteAlias() {
				jpushModule.deleteAlias({
					'sequence': seq++
				})
			},
			
			queryAlias() {
				jpushModule.queryAlias({
					'sequence': seq++
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
