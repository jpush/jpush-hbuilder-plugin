
使用方法：修改需求里的内容，将需求和步骤内容作为指令让cursor进行执行。cursor只能完整部分操作，请关注下手动操作部分。和自测环节。


需求：
1. 更新iOS JPush SDK 到 x.x.x 版本,  JPush SDK 包的路径是：xxx （.xcframework包路径）
2. 更新Android JPush SDK 到 x.x.x 版本, JPush SDK 包的路径是：xxx(这里直接放jenkins打出来的包路径)。 将libs文件夹中的jar包、third-push文件中各个厂商文件夹的jar包和aar包 更新到 UniPlugin-JPush-Android/uniplugin_jpush/libs 和 UniPlugin-JPush-Android/app/libs 中。
3. 将原生iOS、Android SDK 新增的方法，封装在插件中。
   原生SDK新增方法一：
   iOS ：
   
   ```
   ```
   
   Android:
   
   ```
   ```
   
    统一封装为 方法名为 "" 的对外方法。
    

请按照以下步骤完成：

1. 找到需要升级的iOS JPush SDK，替换/UniPlugin-JPush-iOS/HBuilder-uniPluginDemo/UniPluginJPush/UniPluginJPush/jpush-ios-x.x.x.xcframework 为需要更新的版本。
2. 找到需要升级的Android JPush SDK，替换/Users/shunihuang/Desktop/JGPlugins/jpush-hbuilder-plugin/UniPlugin-JPush-Android/uniplugin_jpush/libs/jpush-android-5.7.0.jar  为需要更新的版本。
3. 在插件中封装需求中需要封装的SDK方法，并在插件示例demo中提供示例调用代码，在doc 文件夹中找到相应的md文档 补充新增的插件方法。（如果需求中没有需要新增的方法，则跳过该步骤）
4. 在/JPush_Hbuilder_Demo/nativeplugins/JG-JPush/package.json中更新插件版本号，在现有版本号上 + 0.0.1
5. 在CHANGELOG.md 中 更新 该插件本次的变更内容。




---- 
上诉cursor只步骤只能完成部分操作，还需要以下手动操作部分。
手动步骤：
1、 iOS 编译出 UniPluginJPush.framework 包, 放到 JPush_Hbuilder_Demo/nativeplugins/JG-JPush/ios 中。
2、 android 的 fcm厂商包 需要单独制作，不能直接使用SDK包中的。
3、 android 也需打出 uniplugin_jpush-release.aar 包，放到 JPush_Hbuilder_Demo/nativeplugins/JG-JPush/android 中。
4、 android 的厂商和SDK包需要手动拷贝到JPush_Hbuilder_Demo/nativeplugins/JG-JPush/android 中。


