<template>
	<div>
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
			</br>
			<input v-model="latitude"  placeholder="请输入经度"/>
			</br>
			<input v-model="longitude"  placeholder="请输入纬度"/>
			</br>
			<label @click='setLatLng'>setLat&lng</label>
			
		</view>
	</div>
	
</template>

<script>
    // 首先需要通过 uni.requireNativePlugin("ModuleName") 获取 module 
    var jpushModule = uni.requireNativePlugin("JG-JPush")
    export default {
		
		data() {
			return {
				inputPhoneNumber: '',
				inputBadge: '',
				latitude: '',
				longitude: '',
			}
		},
		
        methods: {
			
			setMobileNumber() {
				let mobileNumber = this.inputPhoneNumber
				jpushModule.setMobileNumber(mobileNumber,result=>{
					let code = result.code
					this.showToast(result)
				})
			},
			
			setBadge(){
				jpushModule.setBadge({
					badge: 10,
					appBadge: 11,
				})
			},
			
			setLatLng(){
				jpushModule.setLocation({
					latitude: this.latitude,
					longitude: this.longitude,
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


<style>
</style>
