//
//  JPushProxy.m
//  UniPluginJPush
//
//  Created by huangshuni on 2021/1/13.
//

#import "JPushProxy.h"
#import "JPushStore.h"
#import "JPUSHService.h"

NSString *const infoConfig_JPush               = @"JVerification";
NSString *const infoConfig_JPush_APP_KEY       = @"APP_KEY";
NSString *const infoConfig_JPush_CHANNEL       = @"CHANNEL";
NSString *const infoConfig_JPush_ISPRODUCTION  = @"ISPRODUCTION";
NSString *const infoConfig_JPush_ADVERTISINGID = @"ADVERTISINGID";

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
    [defaultCenter addObserver:self
                      selector:@selector(networkDidReceiveMessage:)
                          name:kJPFNetworkDidReceiveMessageNotification
                        object:nil];
    
    // 监听连接状态
    [self addConnectEventObserver];
    
    // 地理围栏功能
    [JPUSHService registerLbsGeofenceDelegate:[JPushStore shared] withLaunchOptions:launchOptions];
    //应用内消息代理
    [JPUSHService setInMessageDelegate:[JPushStore shared]];
    
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
    NSDictionary *result = @{
//        @"messageID":notification.request.identifier?:@"",
//        @"title":notification.request.content.title?:@"",
//        @"content":notification.request.content.body?:@"",
        @"extras":userInfo?:@{},
        @"notificationEventType":@"notificationArrived",
    };
    if ([JPushStore shared].pushNotiCallback) {
        [JPushStore shared].pushNotiCallback(result, YES);
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSDictionary *content = notification.userInfo;
    NSLog(@"%@",content);
}

// 收到透传消息
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSDictionary *result = @{
        @"messageID":userInfo[@"_j_msgid"]?:@"",
        @"content":userInfo[@"content"]?:@"",
        @"extras":userInfo[@"extras"]?:@{},
    };
    if ([JPushStore shared].receiveCustomNotiCallback) {
        [JPushStore shared].receiveCustomNotiCallback(result, YES);
    }
}


#pragma mark -
- (void)setupWithOption:(NSDictionary *)launchOptions {

    NSDictionary *launchingOption = launchOptions;
//    BOOL isProduction = [params[@"isProduction"] boolValue];
//    NSString *advertisingId = params[@"advertisingId"];
    

    NSString *path = [[NSBundle mainBundle]pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *appkey = dict[infoConfig_JPush][infoConfig_JPush_APP_KEY];
    NSString *channel = dict[infoConfig_JPush][infoConfig_JPush_CHANNEL];
    BOOL isProduction = NO;
    NSString *isProductionStr = dict[infoConfig_JPush][infoConfig_JPush_ISPRODUCTION];
    if (isProductionStr == nil || isProductionStr.length == 0 || [isProductionStr isEqualToString:@"false"]) {
        isProduction = NO;
    }else if ([isProductionStr isEqualToString:@"true"]) {
        isProduction = YES;
    }
    NSString *advertisingId = dict[infoConfig_JPush][infoConfig_JPush_ADVERTISINGID];
    
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


- (void)addConnectEventObserver {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(networkIsConnecting:)
                          name:kJPFNetworkIsConnectingNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidSetup:)
                          name:kJPFNetworkDidSetupNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidClose:)
                          name:kJPFNetworkDidCloseNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidRegister:)
                          name:kJPFNetworkDidRegisterNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidRegisterFailed:)
                          name:kJPFNetworkFailedRegisterNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidLogin:)
                          name:kJPFNetworkDidLoginNotification
                        object:nil];
}

- (void)networkIsConnecting:(NSNotification *)notification {
    if ([JPushStore shared].connectEventCallback) {
        [JPushStore shared].connectEventCallback(@{@"connectEvent":@(0)}, YES);
    }
}

- (void)networkDidSetup:(NSNotification *)notification {
    if ([JPushStore shared].connectEventCallback) {
        [JPushStore shared].connectEventCallback(@{@"connectEvent":@(1)}, YES);
    }
}

- (void)networkDidClose:(NSNotification *)notification {
    if ([JPushStore shared].connectEventCallback) {
        [JPushStore shared].connectEventCallback(@{@"connectEvent":@(2)}, YES);
    }
}

- (void)networkDidRegister:(NSNotification *)notification {
    if ([JPushStore shared].connectEventCallback) {
        [JPushStore shared].connectEventCallback(@{@"connectEvent":@(3)}, YES);
    }
}

- (void)networkDidRegisterFailed:(NSNotification *)notification {
    if ([JPushStore shared].connectEventCallback) {
        [JPushStore shared].connectEventCallback(@{@"connectEvent":@(4)}, YES);
    }
}

- (void)networkDidLogin:(NSNotification *)notification {
    if ([JPushStore shared].connectEventCallback) {
        [JPushStore shared].connectEventCallback(@{@"connectEvent":@(5)}, YES);
    }
}


- (void)dealloc {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self];
}


@end
