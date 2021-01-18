//
//  JPushProxy.m
//  UniPluginJPush
//
//  Created by huangshuni on 2021/1/13.
//

#import "JPushProxy.h"
#import "JPushStore.h"
#import "JPUSHService.h"

NSString *const infoConfig_JPush             = @"JPush";
NSString *const infoConfig_JPush_APP_KEY     = @"APP_KEY";
NSString *const infoConfig_JPush_CHANNEL     = @"CHANNEL";

@implementation JPushProxy

- (void)onCreateUniPlugin {
    NSLog(@"UniPluginProtocol Func: %@,%s",self,__func__);
}

- (BOOL)application:(UIApplication *_Nullable)application didFinishLaunchingWithOptions:(NSDictionary *_Nullable)launchOptions {
    NSLog(@"UniPluginProtocol Func: %@,%s",self,__func__);
    
    // jpush初始化
    [self registerForRemoteNotificationConfig:nil];
    [self setupWithOption:launchOptions];
    // 监听透传消息
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
    [JPUSHService registerLbsGeofenceDelegate:[JPushStore shared] withLaunchOptions:launchOptions];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication * _Nullable)application {
    NSLog(@"UniPluginProtocol Func: %@,%s",self,__func__);
}

- (void)applicationDidBecomeActive:(UIApplication *_Nullable)application {
    NSLog(@"UniPluginProtocol Func: %@,%s",self,__func__);
}

- (void)applicationDidEnterBackground:(UIApplication *_Nullable)application {
    NSLog(@"UniPluginProtocol Func: %@,%s",self,__func__);
}

- (void)applicationWillEnterForeground:(UIApplication *_Nullable)application {
    NSLog(@"UniPluginProtocol Func: %@,%s",self,__func__);
}

- (void)applicationWillTerminate:(UIApplication *_Nullable)application {
    NSLog(@"UniPluginProtocol Func: %@,%s",self,__func__);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"UniPluginProtocol Func: %@,%s",self,__func__);
    [JPUSHService registerDeviceToken:deviceToken];
}

// ios8 - ios10 应用前台收到apns消息
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
    if ([JPushStore shared].receivePushNotiCallback) {
        [JPushStore shared].receivePushNotiCallback(userInfo, YES);
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
  
}

// 收到透传消息
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    if ([JPushStore shared].receiveCustomNotiCallback) {
        [JPushStore shared].receiveCustomNotiCallback(userInfo, YES);
    }
}


#pragma mark -
- (void)setupWithOption:(NSDictionary *)launchOptions {

    NSDictionary *launchingOption = launchOptions;
//    BOOL isProduction = [params[@"isProduction"] boolValue];
//    NSString *advertisingId = params[@"advertisingId"];
    BOOL isProduction = YES;
    NSString *advertisingId = @"";

    NSString *path = [[NSBundle mainBundle]pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *appkey = dict[infoConfig_JPush][infoConfig_JPush_APP_KEY];
    NSString *channel = dict[infoConfig_JPush][infoConfig_JPush_CHANNEL];
    if (channel == nil ||channel.length == 0) {
        channel = @"developer-default";
    }

    [JPUSHService setupWithOption:launchingOption appKey:appkey channel:channel apsForProduction:isProduction advertisingIdentifier:advertisingId];

}


- (void)registerForRemoteNotificationConfig:(NSDictionary *)params {
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
        if (@available(iOS 13.0, *)) {
            entity.types = entity.types | JPAuthorizationOptionAnnouncement;
        }
    } else {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:[JPushStore shared]];
    
}


- (void)dealloc {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self];
}


@end
