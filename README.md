# jpush-hbuilder-plugin

[极光推送](https://www.jiguang.cn/) 官方支持的 Hbuilder 插件（Android & iOS）。是基于 HBuilder 提供的 [uni-app 原生插件扩展](https://ask.dcloud.net.cn/article/35428) 进而开发出的推送插件。

支持 iOS 和 Android 推送，同时适配各大厂商推送。

## uniapp插件市场地址
[极光推送官方SDK]()

## 接入
- 1.将 nativeplugins/JG-JPush 导入项目对应位置。
- 2.项目 manifest.json 中接入 JG-JPush 插件，并配置插件配置。
- 3.在项目中引用插件
```
const jv = uni.requireNativePlugin('JG-JPush');
```
- 4.引入[JG-JCore 插件](https://github.com/jpush/jcore-hbuilder-plugin)，用于适配更多的极光 Uniapp 插件，必须引入。


## DEMO 体验
按照以下步骤快速体验 JPush_Hbuilder_demo：
- 1.在[极光 portal](https://www.jiguang.cn/accounts/platform)注册应用并开通推送功能。
- 2.在项目 manifest.json 中配置您的推送信息
- 3.HbuilderX 中制作打包自定义基座，包名，签名，bundleID 需要与对应 appkey 配置的应用信息保持一致
- 4.HbuilderX 使用自定义基座运行即可