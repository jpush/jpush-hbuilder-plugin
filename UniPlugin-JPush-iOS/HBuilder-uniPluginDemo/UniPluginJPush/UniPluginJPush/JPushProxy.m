//
//  JPushProxy.m
//  UniPluginJPush
//
//  Created by huangshuni on 2021/1/13.
//

#import "JPushProxy.h"
#import "JPushStore.h"
#import "JPUSHService.h"


@implementation JPushProxy

- (void)onCreateUniPlugin {
    NSLog(@"JPushModule--->UniPluginProtocol Func: %@,%s",self,__func__);
}

- (BOOL)application:(UIApplication *_Nullable)application didFinishLaunchingWithOptions:(NSDictionary *_Nullable)launchOptions {
    NSLog(@"JPushModule--->UniPluginProtocol Func: %@,%s",self,__func__);
    
    [JPushStore shared].launchOptions = launchOptions;
    
    // 初始化
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *defaultInitJpush = dict[infoConfig_JPush][infoConfig_JPush_DEFAULTINITJPUSH];
    if ([defaultInitJpush isEqualToString:@"true"]) {
        [[JPushStore shared] initJPushService:launchOptions];
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication * _Nullable)application {
    NSLog(@"JPushModule--->UniPluginProtocol Func: %@,%s",self,__func__);
}

- (void)applicationDidBecomeActive:(UIApplication *_Nullable)application {
    NSLog(@"JPushModule--->UniPluginProtocol Func: %@,%s",self,__func__);
}

- (void)applicationDidEnterBackground:(UIApplication *_Nullable)application {
    NSLog(@"JPushModule--->UniPluginProtocol Func: %@,%s",self,__func__);
}

- (void)applicationWillEnterForeground:(UIApplication *_Nullable)application {
    NSLog(@"JPushModule--->UniPluginProtocol Func: %@,%s",self,__func__);
}

- (void)applicationWillTerminate:(UIApplication *_Nullable)application {
    NSLog(@"JPushModule--->UniPluginProtocol Func: %@,%s",self,__func__);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"JPushModule--->UniPluginProtocol Func: %@,%s",self,__func__);
    [JPUSHService registerDeviceToken:deviceToken];
    [[JPushStore shared] handleDeviceTokenSuccess:deviceToken];
}

- (void)didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    [[JPushStore shared] handleDeviceTokenFail:err];
}

// 推送唤醒会走这里
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"JPushModule--->UniPluginProtocol Func: %@,%s",self,__func__);
    [[JPushStore shared] handeleApnsCallback:userInfo type:NOTIFICATION_ARRIVED];
}




@end
