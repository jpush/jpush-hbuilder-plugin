(this["webpackJsonp"]=this["webpackJsonp"]||[]).push([["app-service"],{"0696":function(t,e,n){"use strict";n.d(e,"b",(function(){return i})),n.d(e,"c",(function(){return o})),n.d(e,"a",(function(){}));var i=function(){var t=this.$createElement,e=this._self._c||t;return e("div",[e("br"),e("button",{attrs:{_i:2},on:{click:this.addLocalNotification}}),e("br"),e("button",{attrs:{_i:4},on:{click:this.removeLocalNotification}}),e("br"),e("button",{attrs:{_i:6},on:{click:this.clearLocalNotifications}}),e("br")])},o=[]},"0ab2":function(t,e,n){"use strict";var i=n("4ea4"),o=i(n("9523"));n("8276"),n("29ad");var r=i(n("8bbf")),a=i(n("aba7"));function u(t,e){var n=Object.keys(t);if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(t);e&&(i=i.filter((function(e){return Object.getOwnPropertyDescriptor(t,e).enumerable}))),n.push.apply(n,i)}return n}r.default.config.productionTip=!1,a.default.mpType="app";var s=new r.default(function(t){for(var e=1;e<arguments.length;e++){var n=null!=arguments[e]?arguments[e]:{};e%2?u(Object(n),!0).forEach((function(e){(0,o.default)(t,e,n[e])})):Object.getOwnPropertyDescriptors?Object.defineProperties(t,Object.getOwnPropertyDescriptors(n)):u(Object(n)).forEach((function(e){Object.defineProperty(t,e,Object.getOwnPropertyDescriptor(n,e))}))}return t}({},a.default));s.$mount()},"0de9":function(t,e,n){"use strict";function i(t){var e=Object.prototype.toString.call(t);return e.substring(8,e.length-1)}function o(){return"string"===typeof __channelId__&&__channelId__}function r(t,e){switch(i(e)){case"Function":return"function() { [native code] }";default:return e}}function a(t){for(var e=arguments.length,n=new Array(e>1?e-1:0),i=1;i<e;i++)n[i-1]=arguments[i];console[t].apply(console,n)}function u(){for(var t=arguments.length,e=new Array(t),n=0;n<t;n++)e[n]=arguments[n];var a=e.shift();if(o())return e.push(e.pop().replace("at ","uni-app:///")),console[a].apply(console,e);var u=e.map((function(t){var e=Object.prototype.toString.call(t).toLowerCase();if("[object object]"===e||"[object array]"===e)try{t="---BEGIN:JSON---"+JSON.stringify(t,r)+"---END:JSON---"}catch(o){t=e}else if(null===t)t="---NULL---";else if(void 0===t)t="---UNDEFINED---";else{var n=i(t).toUpperCase();t="NUMBER"===n||"BOOLEAN"===n?"---BEGIN:"+n+"---"+t+"---END:"+n+"---":String(t)}return t})),s="";if(u.length>1){var c=u.pop();s=u.join("---COMMA---"),0===c.indexOf(" at ")?s+=c:s+="---COMMA---"+c}else s=u[0];console[a](s)}n.r(e),n.d(e,"log",(function(){return a})),n.d(e,"default",(function(){return u}))},"1b75":function(t,e,n){"use strict";n.r(e);var i=n("e804"),o=n.n(i);for(var r in i)["default"].indexOf(r)<0&&function(t){n.d(e,t,(function(){return i[t]}))}(r);e["default"]=o.a},"29ad":function(t,e){uni.invokePushCallback({type:"enabled",offline:!0}),Promise.resolve().then((function(){(function(){"undefined"!==typeof plus&&plus.push&&plus.globalEvent.addEventListener("newPath",(function(t){var e=t.path;if(e){var n=getCurrentPages(),i=n[n.length-1];i&&i.$page&&i.$page.fullPath===e||uni.navigateTo({url:e,fail:function(t){t.errMsg.indexOf("tabbar")>-1?uni.switchTab({url:e,fail:function(t){console.error(t.errMsg)}}):console.error(t.errMsg)}})}}))})(),plus.push.setAutoNotification&&plus.push.setAutoNotification(!1)}))},"2e44":function(t,e,n){"use strict";n.r(e);var i=n("6a0f"),o=n.n(i);for(var r in i)["default"].indexOf(r)<0&&function(t){n.d(e,t,(function(){return i[t]}))}(r);e["default"]=o.a},3395:function(t,e,n){"use strict";n.r(e);var i=n("c3b5"),o=n("2e44");for(var r in o)["default"].indexOf(r)<0&&function(t){n.d(e,t,(function(){return o[t]}))}(r);var a=n("f0c5"),u=Object(a["a"])(o["default"],i["b"],i["c"],!1,null,null,null,!1,i["a"],void 0);e["default"]=u.exports},"3b3a":function(t,e,n){"use strict";n.r(e);var i=n("0696"),o=n("e6a5");for(var r in o)["default"].indexOf(r)<0&&function(t){n.d(e,t,(function(){return o[t]}))}(r);var a=n("f0c5"),u=Object(a["a"])(o["default"],i["b"],i["c"],!1,null,null,null,!1,i["a"],void 0);e["default"]=u.exports},"429d":function(t,e,n){"use strict";n.r(e);var i=n("780f"),o=n.n(i);for(var r in i)["default"].indexOf(r)<0&&function(t){n.d(e,t,(function(){return i[t]}))}(r);e["default"]=o.a},"4ea4":function(t,e){t.exports=function(t){return t&&t.__esModule?t:{default:t}},t.exports.__esModule=!0,t.exports["default"]=t.exports},"57ab":function(t,e,n){"use strict";n.r(e);var i=n("c877"),o=n("429d");for(var r in o)["default"].indexOf(r)<0&&function(t){n.d(e,t,(function(){return o[t]}))}(r);var a=n("f0c5"),u=Object(a["a"])(o["default"],i["b"],i["c"],!1,null,null,null,!1,i["a"],void 0);e["default"]=u.exports},"59c5":function(t,e,n){"use strict";n.d(e,"b",(function(){return i})),n.d(e,"c",(function(){return o})),n.d(e,"a",(function(){}));var i=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",[n("view",[n("input",{directives:[{name:"model",rawName:"v-model",value:t.inputTags,expression:"inputTags"}],attrs:{_i:2},domProps:{value:t._$s(2,"v-model",t.inputTags)},on:{input:function(e){e.target.composing||(t.inputTags=e.target.value)}}}),n("br"),n("input",{directives:[{name:"model",rawName:"v-model",value:t.inputAlias,expression:"inputAlias"}],attrs:{_i:4},domProps:{value:t._$s(4,"v-model",t.inputAlias)},on:{input:function(e){e.target.composing||(t.inputAlias=e.target.value)}}}),n("br"),n("label",{attrs:{_i:6},on:{click:t.addTags}}),n("label",{attrs:{_i:7},on:{click:t.updateTags}}),n("label",{attrs:{_i:8},on:{click:t.queryTags}}),n("br"),n("br"),n("label",{attrs:{_i:11},on:{click:t.deleteTag}}),n("label",{attrs:{_i:12},on:{click:t.deleteTags}}),n("label",{attrs:{_i:13},on:{click:t.queryTag}}),n("br"),n("br"),n("label",{attrs:{_i:16},on:{click:t.setAlias}}),n("label",{attrs:{_i:17},on:{click:t.deleteAlias}}),n("label",{attrs:{_i:18},on:{click:t.queryAlias}})])])},o=[]},"6a0f":function(t,e,n){"use strict";Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0;var i=uni.requireNativePlugin("JG-JPush");i.addMobileNumberListener((function(t){t.code;uni.showToast({icon:"none",title:JSON.stringify(t),duration:3e3})}));var o={data:function(){return{inputPhoneNumber:"",inputBadge:"",latitude:"",longitude:""}},methods:{setMobileNumber:function(){var t=this.inputPhoneNumber;i.setMobileNumber({mobileNumber:t})},setBadge:function(){var t=parseInt(this.inputBadge);i.setBadge(t)},setLatLng:function(){"ios"==uni.getSystemInfoSync().platform&&i.setLocation({latitude:parseFloat(this.latitude),longitude:parseFloat(this.longitude)})},showToast:function(t){uni.showToast({icon:"none",title:JSON.stringify(t),duration:3e3})}}};e.default=o},7037:function(t,e){function n(e){return t.exports=n="function"==typeof Symbol&&"symbol"==typeof Symbol.iterator?function(t){return typeof t}:function(t){return t&&"function"==typeof Symbol&&t.constructor===Symbol&&t!==Symbol.prototype?"symbol":typeof t},t.exports.__esModule=!0,t.exports["default"]=t.exports,n(e)}t.exports=n,t.exports.__esModule=!0,t.exports["default"]=t.exports},"780f":function(t,e,n){"use strict";(function(t){Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0;var n=uni.requireNativePlugin("JG-JPush"),i={data:function(){return{connectStatus:"\u672a\u94fe\u63a5",registrationID:"\u672a\u83b7\u5f97"}},onLoad:function(){var e=this;t("log","\u5f00\u59cb\u76d1\u542c\u8fde\u63a5\u72b6\u6001"," at pages/index/index.vue:38"),uni.$on("connectStatusChange",(function(n){var i="";1==n?(i="\u5df2\u8fde\u63a5",e.getRegistrationID()):i="\u672a\u8fde\u63a5",t("log","\u76d1\u542c\u5230\u4e86\u8fde\u63a5\u72b6\u6001\u53d8\u5316 --- ",i," at pages/index/index.vue:47"),e.connectStatus=i}))},onUnload:function(){uni.$off("connectStatusChange")},methods:{openSettingsForNotification:function(){var t=this;n.openSettingsForNotification((function(e){t.showToast(e)}))},setLoggerEnable:function(){n.setLoggerEnable(!0)},setLoggerUnEnable:function(){n.setLoggerEnable(!1)},getRegistrationID:function(){var e=this;n.getRegistrationID((function(n){var i=n.registerID;t("log",i," at pages/index/index.vue:76"),e.registrationID=i}))},showToast:function(t){uni.showToast({icon:"none",title:JSON.stringify(t),duration:3e3})}}};e.default=i}).call(this,n("0de9")["default"])},"78ac":function(t,e,n){"use strict";n.r(e);var i=n("59c5"),o=n("1b75");for(var r in o)["default"].indexOf(r)<0&&function(t){n.d(e,t,(function(){return o[t]}))}(r);var a=n("f0c5"),u=Object(a["a"])(o["default"],i["b"],i["c"],!1,null,null,null,!1,i["a"],void 0);e["default"]=u.exports},8276:function(t,e,n){if("undefined"===typeof Promise||Promise.prototype.finally||(Promise.prototype.finally=function(t){var e=this.constructor;return this.then((function(n){return e.resolve(t()).then((function(){return n}))}),(function(n){return e.resolve(t()).then((function(){throw n}))}))}),"undefined"!==typeof uni&&uni&&uni.requireGlobal){var i=uni.requireGlobal();ArrayBuffer=i.ArrayBuffer,Int8Array=i.Int8Array,Uint8Array=i.Uint8Array,Uint8ClampedArray=i.Uint8ClampedArray,Int16Array=i.Int16Array,Uint16Array=i.Uint16Array,Int32Array=i.Int32Array,Uint32Array=i.Uint32Array,Float32Array=i.Float32Array,Float64Array=i.Float64Array,BigInt64Array=i.BigInt64Array,BigUint64Array=i.BigUint64Array}uni.restoreGlobal&&uni.restoreGlobal(weex,plus,setTimeout,clearTimeout,setInterval,clearInterval),__definePage("pages/index/index",(function(){return Vue.extend(n("57ab").default)})),__definePage("pages/index/tags",(function(){return Vue.extend(n("78ac").default)})),__definePage("pages/index/localNoti",(function(){return Vue.extend(n("3b3a").default)})),__definePage("pages/index/other",(function(){return Vue.extend(n("3395").default)}))},"8bbf":function(t,e){t.exports=Vue},"8f1d":function(t,e,n){"use strict";(function(t){Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0;var n=uni.requireNativePlugin("JG-JPush"),i={onLaunch:function(){if(t("log","App Launch"," at App.vue:6"),"ios"==uni.getSystemInfoSync().platform){var e=n.locationServicesEnabled(),i=n.getLocationAuthorizationStatus();t("log","locationAuthorizationStatus",i," at App.vue:11"),1==e&&i<3&&n.requestLocationAuthorization((function(e){t("log","\u5b9a\u4f4d\u6743\u9650",e.status," at App.vue:14")})),n.requestNotificationAuthorization((function(t){var e=t.status;e<2&&uni.showToast({icon:"none",title:"\u60a8\u8fd8\u6ca1\u6709\u6253\u5f00\u901a\u77e5\u6743\u9650",duration:3e3})})),n.addGeofenceListener((function(t){t.code,t.type,t.geofenceId,t.userInfo;uni.showToast({icon:"none",title:"\u89e6\u53d1\u5730\u7406\u56f4\u680f",duration:3e3})})),n.addDeviceTokenListener((function(e){var n=e.code;if(0==n){var i=e.deviceToken;uni.showToast({icon:"none",title:i,duration:3e3}),t("log","deviceToken:",i," at App.vue:52")}else e.msg}))}n.initJPushService(),n.setLoggerEnable(!0),n.addConnectEventListener((function(t){var e=t.connectEnable;uni.$emit("connectStatusChange",e)})),n.addNotificationListener((function(t){t.notificationEventType,t.messageID,t.title,t.content,t.extras;uni.showToast({icon:"none",title:JSON.stringify(t),duration:3e3})})),n.addCustomMessageListener((function(t){t.type,t.messageType,t.content;uni.showToast({icon:"none",title:JSON.stringify(t),duration:3e3})})),n.addLocalNotificationListener((function(t){t.messageID,t.title,t.content,t.extras;uni.showToast({icon:"none",title:JSON.stringify(t),duration:3e3})}))},onShow:function(){t("log","App Show"," at App.vue:107")},onHide:function(){t("log","App Hide"," at App.vue:110")}};e.default=i}).call(this,n("0de9")["default"])},"90f4":function(t,e,n){"use strict";Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0;var i=uni.requireNativePlugin("JG-JPush"),o={data:function(){return{}},methods:{addLocalNotification:function(){i.addLocalNotification({messageID:"123",title:"title",content:"content",extras:{name:"Cindy",age:"16"}})},removeLocalNotification:function(){i.removeLocalNotification({messageID:"123"})},clearLocalNotifications:function(){i.clearLocalNotifications()},showToast:function(t){uni.showToast({icon:"none",title:JSON.stringify(t),duration:3e3})}}};e.default=o},9523:function(t,e,n){var i=n("a395");t.exports=function(t,e,n){return e=i(e),e in t?Object.defineProperty(t,e,{value:n,enumerable:!0,configurable:!0,writable:!0}):t[e]=n,t},t.exports.__esModule=!0,t.exports["default"]=t.exports},a395:function(t,e,n){var i=n("7037")["default"],o=n("e50d");t.exports=function(t){var e=o(t,"string");return"symbol"===i(e)?e:String(e)},t.exports.__esModule=!0,t.exports["default"]=t.exports},aba7:function(t,e,n){"use strict";n.r(e);var i=n("fa80");for(var o in i)["default"].indexOf(o)<0&&function(t){n.d(e,t,(function(){return i[t]}))}(o);var r=n("f0c5"),a=Object(r["a"])(i["default"],void 0,void 0,!1,null,null,null,!1,void 0,void 0);e["default"]=a.exports},c3b5:function(t,e,n){"use strict";n.d(e,"b",(function(){return i})),n.d(e,"c",(function(){return o})),n.d(e,"a",(function(){}));var i=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",[n("view",[n("input",{directives:[{name:"model",rawName:"v-model",value:t.inputBadge,expression:"inputBadge"}],attrs:{_i:2},domProps:{value:t._$s(2,"v-model",t.inputBadge)},on:{input:function(e){e.target.composing||(t.inputBadge=e.target.value)}}}),n("br"),n("label",{attrs:{_i:4},on:{click:t.setBadge}}),n("br"),n("br"),n("input",{directives:[{name:"model",rawName:"v-model",value:t.inputPhoneNumber,expression:"inputPhoneNumber"}],attrs:{_i:7},domProps:{value:t._$s(7,"v-model",t.inputPhoneNumber)},on:{input:function(e){e.target.composing||(t.inputPhoneNumber=e.target.value)}}}),n("br"),n("label",{attrs:{_i:9},on:{click:t.setMobileNumber}}),n("br"),n("br"),n("br"),n("br"),n("br"),n("br"),n("input",{directives:[{name:"model",rawName:"v-model",value:t.latitude,expression:"latitude"}],attrs:{_i:16},domProps:{value:t._$s(16,"v-model",t.latitude)},on:{input:function(e){e.target.composing||(t.latitude=e.target.value)}}}),n("br"),n("input",{directives:[{name:"model",rawName:"v-model",value:t.longitude,expression:"longitude"}],attrs:{_i:18},domProps:{value:t._$s(18,"v-model",t.longitude)},on:{input:function(e){e.target.composing||(t.longitude=e.target.value)}}}),n("br"),n("label",{attrs:{_i:20},on:{click:t.setLatLng}})])])},o=[]},c877:function(t,e,n){"use strict";n.d(e,"b",(function(){return i})),n.d(e,"c",(function(){return o})),n.d(e,"a",(function(){}));var i=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",[n("br"),n("br"),n("label"),n("label",[t._v(t._$s(4,"t0-0",t._s(t.connectStatus)))]),n("br"),n("label"),n("label",[t._v(t._$s(7,"t0-0",t._s(t.registrationID)))]),n("br"),n("br"),n("label"),n("button",{attrs:{_i:11},on:{click:t.openSettingsForNotification}}),n("br"),n("button",{attrs:{_i:13},on:{click:t.setLoggerEnable}}),n("br"),n("button",{attrs:{_i:15},on:{click:t.setLoggerUnEnable}}),n("br"),n("button",{attrs:{_i:17},on:{click:t.getRegistrationID}})])},o=[]},e50d:function(t,e,n){var i=n("7037")["default"];t.exports=function(t,e){if("object"!==i(t)||null===t)return t;var n=t[Symbol.toPrimitive];if(void 0!==n){var o=n.call(t,e||"default");if("object"!==i(o))return o;throw new TypeError("@@toPrimitive must return a primitive value.")}return("string"===e?String:Number)(t)},t.exports.__esModule=!0,t.exports["default"]=t.exports},e6a5:function(t,e,n){"use strict";n.r(e);var i=n("90f4"),o=n.n(i);for(var r in i)["default"].indexOf(r)<0&&function(t){n.d(e,t,(function(){return i[t]}))}(r);e["default"]=o.a},e804:function(t,e,n){"use strict";Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0;var i=uni.requireNativePlugin("JG-JPush"),o=1;i.addTagAliasListener((function(t){uni.showToast({icon:"none",title:JSON.stringify(t),duration:3e3})}));var r={data:function(){return{inputTags:"",inputAlias:""}},methods:{addTags:function(){var t=this.inputTags.split(",");i.addTags({tags:t,sequence:o++})},updateTags:function(){var t=this.inputTags.split(",");i.updateTags({tags:t,sequence:o++})},deleteTag:function(){var t=this.inputTags.split(",");i.deleteTags({tags:t,sequence:o++})},deleteTags:function(){i.cleanTags({sequence:o++})},queryTag:function(){var t=this.inputTags;i.queryTag({tag:t,sequence:o++})},queryTags:function(){i.getAllTags({sequence:o++})},setAlias:function(){var t=this.inputAlias;i.setAlias({alias:t,sequence:o++})},deleteAlias:function(){i.deleteAlias({sequence:o++})},queryAlias:function(){i.queryAlias({sequence:o++})},showToast:function(t){uni.showToast({icon:"none",title:JSON.stringify(t),duration:3e3})}}};e.default=r},f0c5:function(t,e,n){"use strict";function i(t,e,n,i,o,r,a,u,s,c){var l,f="function"===typeof t?t.options:t;if(s){f.components||(f.components={});var d=Object.prototype.hasOwnProperty;for(var p in s)d.call(s,p)&&!d.call(f.components,p)&&(f.components[p]=s[p])}if(c&&("function"===typeof c.beforeCreate&&(c.beforeCreate=[c.beforeCreate]),(c.beforeCreate||(c.beforeCreate=[])).unshift((function(){this[c.__module]=this})),(f.mixins||(f.mixins=[])).push(c)),e&&(f.render=e,f.staticRenderFns=n,f._compiled=!0),i&&(f.functional=!0),r&&(f._scopeId="data-v-"+r),a?(l=function(t){t=t||this.$vnode&&this.$vnode.ssrContext||this.parent&&this.parent.$vnode&&this.parent.$vnode.ssrContext,t||"undefined"===typeof __VUE_SSR_CONTEXT__||(t=__VUE_SSR_CONTEXT__),o&&o.call(this,t),t&&t._registeredComponents&&t._registeredComponents.add(a)},f._ssrRegister=l):o&&(l=u?function(){o.call(this,this.$root.$options.shadowRoot)}:o),l)if(f.functional){f._injectStyles=l;var v=f.render;f.render=function(t,e){return l.call(e),v(t,e)}}else{var g=f.beforeCreate;f.beforeCreate=g?[].concat(g,l):[l]}return{exports:t,options:f}}n.d(e,"a",(function(){return i}))},fa80:function(t,e,n){"use strict";n.r(e);var i=n("8f1d"),o=n.n(i);for(var r in i)["default"].indexOf(r)<0&&function(t){n.d(e,t,(function(){return i[t]}))}(r);e["default"]=o.a}},[["0ab2","app-config"]]]);