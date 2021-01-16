<template>
    <div>
		
		<!-- <button type="primary" @click="addPushNotificationReceiveListener">addPushNotificationReceiveListener</button>
		</br>
		<button type="primary" @click="addPushNotificationOpenListener">addPushNotificationOpenListener</button>
		</br>
		<button type="primary" @click="addCustomNotificationReceiveListener">addCustomNotificationReceiveListener</button>
		</br> -->
		
		<button type="primary" @click="addTags">addTags</button>
		</br>
		<!-- <button type="primary" @click="setTags">setTags</button>
		</br>
		<button type="primary" @click="deleteTags">deleteTags</button>
		</br>
		<button type="primary" @click="cleanTags">cleanTags</button>
		</br>
		<button type="primary" @click="getAllTags">getAllTags</button>
		</br>
		<button type="primary" @click="validTag">validTag</button>
		</br> -->
		
    </div>
</template>

<script>
    // 首先需要通过 uni.requireNativePlugin("ModuleName") 获取 module 
    var jpushModule = uni.requireNativePlugin("JG-JPush")
    export default {
        methods: {
			
			addTags() {
				jpushModule.addTags(['fat','old'],result=>{
					uni.showToast({
						title: JSON.stringify(result),
						duration: 3000
					})
				})
			}
			
			

        }
    }
</script>

<!-- <script>
    // 首先需要通过 uni.requireNativePlugin("ModuleName") 获取 module 
	const jpushModule = uni.requireNativePlugin('JG-JPush')
    export default {
		data() {
			return {
				title: 'Hello',
				msg: "",
				jpushModule
			}
		},
		onLoad() {
		},
        methods: {
			
			printSth:function(){
				console.log("hello");
				let self = this;
				self.jpushModule.printSth(result=>{
					// self.showModal('printSth',JSON.stringify(result));
					console.log(JSON.stringify(result))
					console.log("sn");
				})
			},
			
        }
    }
</script> -->