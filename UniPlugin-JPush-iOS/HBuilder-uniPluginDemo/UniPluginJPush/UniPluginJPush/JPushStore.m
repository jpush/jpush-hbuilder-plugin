//
//  JPushStore.m
//  UniPluginJPush
//
//  Created by huangshuni on 2021/1/13.
//

#import "JPushStore.h"
#import <UserNotifications/UserNotifications.h>

NSString *const infoConfig_JPush               = @"JVerification";
NSString *const infoConfig_JPush_APP_KEY       = @"APP_KEY";
NSString *const infoConfig_JPush_CHANNEL       = @"CHANNEL";
NSString *const infoConfig_JPush_ISPRODUCTION  = @"ISPRODUCTION";
NSString *const infoConfig_JPush_ADVERTISINGID = @"ADVERTISINGID";

@implementation JPushStore

+ (instancetype)shared {
    static JPushStore *store;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[JPushStore alloc] init];
    });
    return store;
}

// jpush初始化
- (void)initJPushService:(NSDictionary *)launchOptions {
    
    [self registerForRemoteNotificationConfig:nil];
    [self setupWithOption:launchOptions];
    // 监听透传消息
    [self addCustomMessageObserver];
    // 监听连接状态
    [self addConnectEventObserver];
    // 地理围栏功能
    [JPUSHService registerLbsGeofenceDelegate:[JPushStore shared] withLaunchOptions:launchOptions];
    //应用内消息代理
    [JPUSHService setInMessageDelegate:[JPushStore shared]];
}

#pragma mark -
- (void)setupWithOption:(NSDictionary *)launchOptions {

    NSDictionary *launchingOption = launchOptions;

    NSString *path = [[NSBundle mainBundle]pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    // appkey
    NSString *appkey = dict[infoConfig_JPush][infoConfig_JPush_APP_KEY];
    // channel
    NSString *channel = dict[infoConfig_JPush][infoConfig_JPush_CHANNEL];
    if (channel == nil ||channel.length == 0) {
        channel = @"developer-default";
    }
    // isProduction
    BOOL isProduction = NO;
    NSString *isProductionStr = dict[infoConfig_JPush][infoConfig_JPush_ISPRODUCTION];
    if (isProductionStr == nil || isProductionStr.length == 0 || [isProductionStr isEqualToString:@"false"]) {
        isProduction = NO;
    }else if ([isProductionStr isEqualToString:@"true"]) {
        isProduction = YES;
    }
    // advertisingId
    NSString *advertisingId = dict[infoConfig_JPush][infoConfig_JPush_ADVERTISINGID];
    if (![advertisingId isKindOfClass:[NSString class]] || advertisingId == nil || advertisingId.length == 0) {
        advertisingId = nil;
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

#pragma mark - 连接状态
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


#pragma mark - 透传消息
- (void)addCustomMessageObserver {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidReceiveMessage:)
                          name:kJPFNetworkDidReceiveMessageNotification
                        object:nil];
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


#ifdef __IPHONE_10_0
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationAuthorization:(JPAuthorizationStatus)status withInfo:(NSDictionary *)info {
    NSLog(@"receive notification authorization status:%lu, info:%@", (unsigned long)status, info);
}

// 应用在前台 推送消息过来 会触发 需要回调completionHandler才能显示
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //远程推送
        [self handeleApnsCallback:userInfo type:@"notificationArrived"];
    }
//    else {
//        //本地通知
//        if ([JPushStore shared].receiveLocalNotiCallback) {
//            [JPushStore shared].receiveLocalNotiCallback(result, YES);
//        }
//    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
}

// 点击通知会触发
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [self handeleApnsCallback:userInfo type:@"notificationOpened"];
    }
//    else {
//        if ([JPushStore shared].openLocalNotiCallback) {
//            [JPushStore shared].openLocalNotiCallback(result, YES);
//        }
//    }
    completionHandler();
}


#ifdef __IPHONE_12_0
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{

}

#endif

#endif



#pragma mark - JPUSHGeofenceDelegate
- (void)jpushGeofenceIdentifer:(NSString *)geofenceId didEnterRegion:(NSDictionary *)userInfo error:(NSError *)error {
    NSDictionary *result;
    if (error) {
        result = @{
            @"code": @(error.code),
            @"msg": error.description,
            @"type": @"enter"
        };
    }else {
        result = @{
            @"code": @(0),
            @"geofenceId":geofenceId,
            @"userInfo":userInfo,
            @"type": @"enter"
        };
    }
    [JPushStore shared].geofenceCallback(result, YES);
}

- (void)jpushGeofenceIdentifer:(NSString *)geofenceId didExitRegion:(NSDictionary *)userInfo error:(NSError *)error {
    NSDictionary *result;
    if (error) {
        result = @{
            @"code": @(error.code),
            @"msg": error.description,
            @"type": @"exit"
        };
    }else {
        result = @{
            @"code": @(0),
            @"geofenceId":geofenceId,
            @"userInfo":userInfo,
            @"type": @"exit"
        };
    }
    [JPushStore shared].geofenceCallback(result, YES);
}



#pragma mark - 应用内消息
/**
 *是否允许应用内消息弹出,默认为允许
*/
- (BOOL)jPushInMessageIsAllowedInMessagePop {
    return self.allowedInMessagePop;
}

/**
 *应用内消息已消失
*/
- (void)jPushInMessageAlreadyDisappear {
    NSDictionary *result = @{
        @"type":@"disappear",
    };
    if (self.inMessageCallback) {
        self.inMessageCallback(result, YES);
    }
}


/**
 inMessage展示的回调
 
 @param messageType inMessage
 @param content 下发的数据，广告类的返回数据为空时返回的信息

 */
- (void)jPushInMessageAlreadyPopInMessageType:(JPushInMessageContentType)messageType Content:(NSDictionary *)content {
    
    NSDictionary *result = [self convertInMessageResult:messageType Content:content type:@"show"];
    if (self.inMessageCallback) {
        self.inMessageCallback(result, YES);
    }
}

/**
 inMessage点击的回调
 
 @param messageType inMessage
 @param content 下发的数据，广告类的返回数据为空时返回的信息

 */
- (void)jpushInMessagedidClickInMessageType:(JPushInMessageContentType)messageType Content:(NSDictionary *)content {
    
    NSDictionary *result = [self convertInMessageResult:messageType Content:content type:@"click"];
    if (self.inMessageCallback) {
        self.inMessageCallback(result, YES);
    }
}

- (NSDictionary *)convertInMessageResult:(JPushInMessageContentType)messageType Content:(NSDictionary *)content type:(NSString *)type{
    NSString *inMeassageType = @"";
    switch (messageType) {
        case JPushAdContentType:
            inMeassageType = @"inMessageAd";
            break;
        case JPushNotiContentType:
            inMeassageType = @"inMessageNoti";
            break;
        default:
            break;
    }
    
    NSDictionary *result = @{
        @"messageType":inMeassageType,
        @"type":type?:@"",
        @"content":content?:@{},
    };
    return result;
}


#pragma mark - voip
- (void)initVoipService{
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    PKPushRegistry *voipRegistry = [[PKPushRegistry alloc] initWithQueue:mainQueue];
    voipRegistry.delegate = self;
    // Set the push type to VoIP
    voipRegistry.desiredPushTypes = [NSSet setWithObject:PKPushTypeVoIP];
}

#pragma - PKPushRegistryDelegate
//系统返回VOIP token,提交到极光服务器
- (void)pushRegistry:(nonnull PKPushRegistry *)registry didUpdatePushCredentials:(nonnull PKPushCredentials *)pushCredentials forType:(nonnull PKPushType)type {
    [JPUSHService registerVoipToken:pushCredentials.token];
}

- (void)pushRegistry:(PKPushRegistry *)registry didReceiveIncomingPushWithPayload:(PKPushPayload *)payload forType:(PKPushType)type{
    [JPUSHService handleVoipNotification:payload.dictionaryPayload];
    NSDictionary *result = @{
        @"payload" : payload.dictionaryPayload ?:@{},
    };
    if (self.pushNotiCallback) {
        self.pushNotiCallback(result, YES);
    }
}

/**
 * 接收到Voip推送信息，并向极光服务器上报（iOS 11.0 以后）
 */
- (void)pushRegistry:(PKPushRegistry *)registry didReceiveIncomingPushWithPayload:(PKPushPayload *)payload forType:(PKPushType)type withCompletionHandler:(void(^)(void))completion{
    [JPUSHService handleVoipNotification:payload.dictionaryPayload];
    NSDictionary *result = @{
        @"payload" : payload.dictionaryPayload ?:@{},
    };
    if (self.pushNotiCallback) {
        self.pushNotiCallback(result, YES);
    }
}


#pragma mark -
// 处理远程通知回调
- (void)handeleApnsCallback:(NSDictionary *)userInfo type:(NSString *)type {
    [JPUSHService handleRemoteNotification:userInfo];
    NSDictionary *result = [self convertApnsMessage:userInfo type:type];
    if ([JPushStore shared].pushNotiCallback) {
        [JPushStore shared].pushNotiCallback(result, YES);
    }
}

- (NSDictionary *)convertApnsMessage:(NSDictionary *)userInfo type:(NSString *)type{
    NSMutableDictionary *extras = [NSMutableDictionary dictionary];
    for (NSString *key in userInfo.allKeys) {
        if ([key isEqualToString:@"_j_business"] || [key isEqualToString:@"_j_msgid"] || [key isEqualToString:@"_j_uid"] || [key isEqualToString:@"aps"]) {
            continue;
        }
        [extras setValue:userInfo[key] forKey:key];
    }
    NSDictionary *result = @{
        @"messageID":userInfo[@"_j_msgid"]?:@"",
        @"title":userInfo[@"aps"][@"alert"][@"title"]?:@"",
        @"content":userInfo[@"aps"][@"alert"][@"body"]?:@"",
        @"badge":userInfo[@"aps"][@"badge"]?[NSString stringWithFormat:@"%@",userInfo[@"aps"][@"badge"]]:@"1",
        @"ring":userInfo[@"aps"][@"sound"],
        @"extras":[extras copy]?:@{},
        @"notificationEventType":type,
    };
    return result;
}

#pragma mark -
- (void)dealloc {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self];
}

@end
