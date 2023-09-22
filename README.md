# jpush-hbuilder-plugin

[极光推送](https://www.jiguang.cn/) 官方支持的 Hbuilder 插件（Android & iOS）。是基于 HBuilder 提供的 [uni-app 原生插件扩展](https://nativesupport.dcloud.net.cn/NativePlugin/README) 进而开发出的推送插件。

支持 iOS 和 Android 推送，同时适配各大厂商推送。

## uniapp插件市场地址
[极光推送官方SDK](https://ext.dcloud.net.cn/plugin?id=4035)

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

### 1.2 配置插件

**HBuilderX 3.6.2 及之后版本，请打开mainfest配置文件，选择 App模块配置，勾选 Push 模块。**

**注意：不要勾选uniPush！**

打开 manifest.xml，选中App原生插件配置，选择本地插件，导入 JG-JPush

然后配置各个属性，注意在HBuilderX中可能会出现乱序现象，请仔细认真填写

| 属性               | 描述                                            | 示例                               |
| :----------------- | ----------------------------------------------- | ---------------------------------- |
| JPUSH_OPPO_APPKEY   | android oppo appkey（选填）                                | OP-12345678 |
| JPUSH_OPPO_APPID   | android oppo appid（选填）                                | OP-12345678 |
| JPUSH_OPPO_APPSECRET   | android oppo appSecret（选填）                                | OP-12345678 |
| JPUSH_VIVO_APPKEY   | android vivo appkey（选填）                                | 12345678 |
| JPUSH_VIVO_APPID   | android vivo appId（选填）                                | 12345678 |
| JPUSH_MEIZU_APPKEY   | android meizu appkey（选填）                                | MZ-12345678 |
| JPUSH_MEIZU_APPID   | android meizu appId（选填）                                | MZ-12345678 |
| JPUSH_XIAOMI_APPKEY   | android xiaomi appKey（选填）                                | MI-12345678 |
| JPUSH_XIAOMI_APPID   | android xiaomi appId（选填）                                | MI-12345678 |
| JPUSH_HUAWEI_APPID   | android huawei appId（选填）                                | appid=12345678 |
| JPUSH_HONOR_APPID   | android honor appId（选填）                                | 12345678 |
| JPUSH_GOOGLE_API_KEY   | android google api_key（选填）                                | g-12345678 |
| JPUSH_GOOGLE_APP_ID   | android google mobilesdk_app_id（选填）                                | g-12345678 |
| JPUSH_GOOGLE_PROJECT_NUMBER   | android google project_number（选填）                                | g-12345678 |
| JPUSH_GOOGLE_PROJECT_ID   | android google project_id（选填）                                | g-12345678 |
| JPUSH_GOOGLE_STORAGE_BUCKET   | android google storage_bucket（选填）                                | g-12345678 |
|JPUSH_ISPRODUCTION_IOS|iOS 是否是生产环境（选填）|是填true,不是填false或者不填|
|JPUSH_ADVERTISINGID_IOS|iOS 广告标识符（IDFA）（选填）| 如果不需要使用IDFA，可不填|
|JPUSH_DEFAULTINITJPUSH_IOS| iOS 是否默认初始化（选填）|是填true，不是填false或者不填|

#### Android 厂商配置说明
插件支持 OPPO VIVO 魅族 小米 华为 荣耀 FCM 七大厂商推送接入，如需接入请对应配置上述厂商信息。


## API
- [公用 API](https://github.com/jpush/jpush-hbuilder-plugin/blob/master/doc/API.md)
- [Android 独有API](https://github.com/jpush/jpush-hbuilder-plugin/blob/master/doc/ANDROID.md)
- [iOS 独有API](https://github.com/jpush/jpush-hbuilder-plugin/blob/master/doc/IOS.md)

## 参考资料

[官方文档](https://docs.jiguang.cn/jpush/intro/product_guide)

## Support
- 集成前请先尝试 [demo 工程](https://github.com/jpush/jpush-hbuilder-plugin/tree/master/JPush_Hbuilder_Demo)跑通
- 出现问题请先打开 debug 模式，拿到前端和原生日志
- 更多问题请前往[极光社区](http://community.jiguang.cn/)

## License

MIT © [JiGuang](/license)

