-optimizationpasses 5
-dontusemixedcaseclassnames
-dontskipnonpubliclibraryclasses
-dontpreverify
-verbose

#-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*
-dontoptimize

-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference
-keep public class * extends io.dcloud.common.DHInterface.IPlugin
-keep public class * extends io.dcloud.common.DHInterface.IFeature
-keep public class * extends io.dcloud.common.DHInterface.IBoot
-keep public class * extends io.dcloud.common.DHInterface.IReflectAble

-keep class io.dcloud.feature.speech.** {*;}
-keep class io.dcloud.net.** {*;}
-keep class io.dcloud.common.constant.** {*;}
-keep class io.dcloud.common.sonic.** {*;}
-keep class io.dcloud.common.DHInterface.** {*;}
-keep class io.dcloud.common.util.** {*;}
-keep class io.dcloud.common.adapter.** {*;}
-keep class io.dcloud.feature.internal.reflect.** {*;} 
-keep class io.dcloud.feature.internal.sdk.** {*;}
-keep class io.dcloud.feature.payment.** {*;}
-keep class io.dcloud.sdk.** {*;}
-keep class com.** {*;}
-keep class io.dcloud.nineoldandroids.** {*;}
-keep class vi.com.gdi.** {*;} 
-keep class android.support.v4.** {*;}
-dontwarn pl.droidsonroids.gif.**

-keepclasseswithmembers class * extends io.dcloud.js.geolocation.GeoManagerBase {
    <methods>;
}

-keep class io.dcloud.share.AbsWebviewClient
-keepclasseswithmembers class io.dcloud.share.AbsWebviewClient {
    <methods>;
}

-keep class io.dcloud.share.ShareAuthorizeView
-keepclasseswithmembers class io.dcloud.share.ShareAuthorizeView {
    <methods>;
}
-keep class io.dcloud.share.IFShareApi
-keep public class * extends io.dcloud.share.IFShareApi
-keepclasseswithmembers class io.dcloud.share.IFShareApi {
    <methods>;
}




-keepattributes Exceptions,InnerClasses,Signature,Deprecated, SourceFile,LineNumberTable,*Annotation*,EnclosingMethod
-keep class io.dcloud.appstream.StreamAppManager
-keepclasseswithmembers class io.dcloud.appstream.StreamAppManager {
    public protected <methods>;
}

-keep class io.dcloud.common.DHInterface.IReflectAble
-keep public class * extends io.dcloud.common.DHInterface.IReflectAble{
  public protected <methods>;  
  public protected *;
}
-keep class **.R
-keep class **.R$* {
    public static <fields>;
}
-keep public class * extends io.dcloud.common.DHInterface.IJsInterface{
  public protected <methods>;  
  public protected *;
}

-keepclasseswithmembers class io.dcloud.EntryProxy {
    <methods>;  
} 

-keep class * implements android.os.IInterface {
  <methods>; 
}

-keepclasseswithmembers class *{
  public static java.lang.String getJsContent();
}
-keepclasseswithmembers class io.dcloud.appstream.StreamAppScriptEntry {
    <methods>;
}
-keepclasseswithmembers class *{
	public static void onReceiver1(android.content.Intent, android.content.Context);
}

-keepclasseswithmembers class *{
  public static io.dcloud.share.AbsWebviewClient getWebviewClient(io.dcloud.share.ShareAuthorizeView);
}
-keepclasseswithmembers class *{
	public java.lang.String exec(java.lang.String,java.lang.String,java.lang.String[]);
}
-keepattributes Exceptions,InnerClasses,Signature,Deprecated, SourceFile,LineNumberTable,*Annotation*,EnclosingMethod

-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet);
}

-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet, int);
}

-keep public class * extends android.app.Application{
  public static <methods>;
  public *;
}

-keepclassmembers class * extends android.app.Activity {
   public void *(android.view.View);
   public static <methods>;
}

-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}

-keepattributes Signature
-keep class io.dcloud.encryption.K {*;}
-dontwarn com.igexin.**
-keep class org.json.** { *; }
-dontwarn com.amap.**
-dontwarn org.apache.commons.**
-dontwarn com.sina.weibo.sdk.**