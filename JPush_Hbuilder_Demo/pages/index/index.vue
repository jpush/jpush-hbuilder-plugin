<template>
    <div>
		<button type="primary" @click="printSth()">初始化</button>
    </div>
</template>

<script>
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
</script>