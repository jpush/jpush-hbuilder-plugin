该module是引用lib.5plus.base-release.aar+第三方开放平台jar的方式集成5+离线SDK的示例demo
lib.5plus.base-release.aar包含了5+SDK的基础模块，

一：

    若需要支持广告业务，须配置示例demo的入口activity为io.dcloud.PandoraEntry.java。
    另外开发者须在AndroidManifest.xml中自行配置DCLOUD_STREAMAPP_CHANNEL该字段对应value值，
    替换appid和adid为自己应用的appid和广告联盟会员id，5+APP的应用资源manifest.json中添加

     ads广告配置信息

    "plus": {
            "ads": {
                "push":"true|false",       // push推送广告
                "splash":"true|false",     // 开屏广告
                "rp":"true|false",         // 悬浮红包广告
                "spot":"true|false",      // 插屏广告
            }
            // ...
        }
    adid广告联盟会员id
    "plus": {
        "adid": "广告联盟会员id "     // 开发者向后台申请后填写
        // ...
    }

    参考http://ask.dcloud.net.cn/article/13141文档配置



二：

    SDK_WebApp为以WebApp方式集成5+ sdk的示例，参考http://ask.dcloud.net.cn/article/81文档配置
    SDK_WebView为以webview控件方式集成5+ sdk的示例，参考http://ask.dcloud.net.cn/article/80文档配置
    这两种方式不支持广告业务。