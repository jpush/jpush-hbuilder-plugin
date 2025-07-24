//
//  JPushStore.m
//  UniPluginJPush
//
//  Created by huangshuni on 2021/1/13.
//

#import "JPushStore.h"
#import <UserNotifications/UserNotifications.h>
#import <CoreLocation/CoreLocation.h>



@interface JPushStore () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *currentManager;

@property (nonatomic, strong) NSMutableArray *callBackShowNotisArr; // apns展示型通知已经回调过的
@property (nonatomic, strong) NSMutableArray *callBackOpenNotisArr; // apns点击型通知已经回调过的

@property (nonatomic, strong) NSDictionary *notiForegroundPresentationOptions;

//@property (nonatomic, strong) NSMutableString *loggerStr;

//@property (nonatomic, strong) NSString *logFilePath;

@end

@implementation JPushStore

+ (instancetype)shared {
    static JPushStore *store;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[JPushStore alloc] init];
    });
    return store;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _callBackShowNotisArr = [NSMutableArray array];
        _callBackOpenNotisArr = [NSMutableArray array];
        _logEnable = NO;
//        _loggerStr = [NSMutableString string];
//        [self creatLogFile];
    }
    return self;
}

//- (void)creatLogFile {
//    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSDate *now = [NSDate date];
//    NSTimeInterval timestamp = [now timeIntervalSince1970];
//    NSString *fileName = [NSString stringWithFormat:@"%f.txt",timestamp];
//    _logFilePath = [filePath stringByAppendingPathComponent:fileName];
//}

// jpush初始化
- (void)initJPushService:(NSDictionary *)launchOptions {
    
    [self registerForRemoteNotificationConfig];
    // 地理围栏功能 最好在sdk初始化之前调用
    [JPUSHService registerLbsGeofenceDelegate:[JPushStore shared] withLaunchOptions:launchOptions];
    // 初始化sdk
    [self setupWithOption:launchOptions];
    // 监听透传消息
    [self addCustomMessageObserver];
    // 监听自定义消息
    [self addInappMessageObserve];
}

#pragma mark - 初始化
- (void)setupWithOption:(NSDictionary *)launchOptions {

    NSDictionary *launchingOption = launchOptions;

    NSString *path = [[NSBundle mainBundle]pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    // appkey
    NSString *appkey = dict[infoConfig_JCore][infoConfig_JCore_APP_KEY];
    // channel
    NSString *channel = dict[infoConfig_JCore][infoConfig_JCore_CHANNEL];
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

- (void)registerForRemoteNotificationConfig {
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
        if (@available(iOS 13.0, *)) {
            entity.types = entity.types | JPAuthorizationOptionAnnouncement;
        }
    } else {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    }
    
    if (@available(iOS 10.0, *)) {
        UNNotificationCategory *sumFormatCategory = [UNNotificationCategory categoryWithIdentifier:@"jpush_noti_dismissAction_callback_category" actions:@[] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
        entity.categories = [NSSet setWithObject:sumFormatCategory];
    }
    
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:[JPushStore shared]];
    
}

- (void)setNotiForegroundAuthTypes:(NSDictionary *)types {
    self.notiForegroundPresentationOptions = types;
}

#pragma mark - 连接状态
- (void)addConnectEventObserver {
    
    if ([JPushStore shared].connectEventCallback) {
        // 已经观察过
        return;
    }
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidClose:)
                          name:kJPFNetworkDidCloseNotification
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


- (void)networkDidClose:(NSNotification *)notification {
    [self connectEventCallbackHandle:notification];
}

- (void)networkDidRegisterFailed:(NSNotification *)notification {
    [self connectEventCallbackHandle:notification];
}

- (void)networkDidLogin:(NSNotification *)notification {
    [self connectEventCallbackHandle:notification];
}

- (void)connectEventCallbackHandle:(NSNotification *)notification {
    
    BOOL isConnect = false;
    NSNotificationName notificationName = notification.name;
    if([notificationName isEqualToString:kJPFNetworkDidLoginNotification]){
        isConnect = true;
    }
    NSDictionary *responseData = @{CONNECT_ENABLE:@(isConnect)};
    if ([JPushStore shared].connectEventCallback) {
        [JPushStore shared].connectEventCallback(responseData, YES);
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

#pragma mark - 自定义消息
- (void)addInappMessageObserve {
    [JPUSHService setInAppMessageDelegate:self];
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
    [self logger:[NSString stringWithFormat:@"UniPluginProtocol Func: %@,%s",self,__func__] log:nil];
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //远程推送
        [self handeleApnsCallback:userInfo type:NOTIFICATION_ARRIVED];
    }
    else {
        //本地通知
        [self handlerLocalNotiCallback:userInfo type:NOTIFICATION_ARRIVED];
    }
    
    UNNotificationPresentationOptions options = (UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
    if (self.notiForegroundPresentationOptions) {
        options = UNNotificationPresentationOptionNone;
        if ([self.notiForegroundPresentationOptions[@"sound"] boolValue]) {
            options |= UNNotificationPresentationOptionSound;
        }
        if ([self.notiForegroundPresentationOptions[@"alert"] boolValue]) {
            options |= UNNotificationPresentationOptionAlert;
        }
        if ([self.notiForegroundPresentationOptions[@"badge"] boolValue]) {
            options |= UNNotificationPresentationOptionBadge;
        }
    }
    
    completionHandler(options);
    
}

// 点击通知会触发
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    [self logger:[NSString stringWithFormat:@"UniPluginProtocol Func: %@,%s",self,__func__] log:nil];
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        if ([response.actionIdentifier isEqualToString:UNNotificationDismissActionIdentifier]){
            [self handeleApnsCallback:userInfo type:NOTIFICATION_DISMISSED];
        }else {
            [self handeleApnsCallback:userInfo type:NOTIFICATION_OPENED];
        }
    }
    else {
        if ([response.actionIdentifier isEqualToString:UNNotificationDismissActionIdentifier]){
            [self handlerLocalNotiCallback:userInfo type:NOTIFICATION_DISMISSED];
        }else {
            [self handlerLocalNotiCallback:userInfo type:NOTIFICATION_OPENED];
        }
    }
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
    if ([JPushStore shared].geofenceCallback) {
        [JPushStore shared].geofenceCallback(result, YES);
    }
}

- (void)jpushGeofenceIdentifer:(NSString *)geofenceId didExitRegion:(NSDictionary *)userInfo error:(NSError *)error {
    NSDictionary *result;
    if (error) {
        result = @{
            @"code": @(error.code),
            @"msg": error.description?:@"",
            @"type": @"exit"
        };
    }else {
        result = @{
            @"code": @(0),
            @"geofenceId":geofenceId?:@"",
            @"userInfo":userInfo?:@{},
            @"type": @"exit"
        };
    }
    if ([JPushStore shared].geofenceCallback) {
        [JPushStore shared].geofenceCallback(result, YES);
    }
}

#pragma mark - JPUSHInAppMessageDelegate
- (void)jPushInAppMessageDidShow:(JPushInAppMessage *)inAppMessage {
    if ([JPushStore shared].inAppMessageCallback) {
        NSDictionary *result = [self convertInappMsg:inAppMessage isShow:YES];
        [JPushStore shared].inAppMessageCallback(result, YES);
    }
}

- (void)jPushInAppMessageDidClick:(JPushInAppMessage *)inAppMessage {
    if ([JPushStore shared].inAppMessageCallback) {
        NSDictionary *result = [self convertInappMsg:inAppMessage isShow:NO];
        [JPushStore shared].inAppMessageCallback(result, YES);
    }
}

#pragma mark - voip
- (void)initVoipService{
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    PKPushRegistry *voipRegistry = [[PKPushRegistry alloc] initWithQueue:mainQueue];
    voipRegistry.delegate = self;
    // Set the push type to VoIP
    if (@available(iOS 9.0, *)) {
        voipRegistry.desiredPushTypes = [NSSet setWithObject:PKPushTypeVoIP];
    }
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
    if (self.voipCallback) {
        self.voipCallback(result, YES);
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
    if (self.voipCallback) {
        self.voipCallback(result, YES);
    }
}


#pragma mark -
// 处理远程通知回调
- (void)handeleApnsCallback:(NSDictionary *)userInfo type:(NSString *)type {
    [self logger:[NSString stringWithFormat:@"Func: %@,%s",self,__func__] log:nil];
    if (!userInfo || ![userInfo isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    [JPUSHService handleRemoteNotification:userInfo];
    
    if (![JPushStore shared].pushNotiCallback) {
        [self logger:@"no pushNotiCallback, return" log:nil];
        return;
    }
    
    NSMutableArray *callArr = nil;
    if ([type isEqualToString:NOTIFICATION_ARRIVED]) {
        callArr = self.callBackShowNotisArr;
    }else if ([type isEqualToString:NOTIFICATION_OPENED]) {
        callArr = self.callBackOpenNotisArr;
    }
    
    // 处理带有content-available 推送唤醒通知送达时会回调两次的问题
    NSNumber *notiId = userInfo[@"_j_msgid"];
    for (NSDictionary *info in [callArr mutableCopy]) {
        if ([info isKindOfClass:[NSDictionary class]]) {
            NSNumber *messageID = info[@"_j_msgid"];
            if (notiId && [notiId isKindOfClass:[NSNumber class]] && messageID && [messageID isKindOfClass:[NSNumber class]] && [[notiId stringValue] isEqualToString:[messageID stringValue]]) {
                [self logger:@"already callback" log:nil];
                [callArr removeAllObjects];
                return;
            }
        }
    }
    
    NSDictionary *aps = userInfo[@"aps"];
    if (aps && [aps isKindOfClass:[NSDictionary class]]) {
        if([aps.allKeys containsObject:@"content-available"]){
            NSNumber *contentavailable = aps[@"content-available"];
            if (contentavailable && [contentavailable isKindOfClass:[NSNumber class]] && [contentavailable boolValue]) {
                [callArr addObject:userInfo];
            }
        }
    }
   
    
    // 
    NSDictionary *result = [self convertApnsMessage:userInfo type:type];
    if ([JPushStore shared].pushNotiCallback) {
        [self logger:[NSString stringWithFormat:@"callback %@",type] log:nil];
        [JPushStore shared].pushNotiCallback(result, YES);
    }
}

- (NSDictionary *)convertApnsMessage:(NSDictionary *)userInfo type:(NSString *)type{
    NSMutableDictionary *extras = [NSMutableDictionary dictionary];
    for (NSString *key in userInfo.allKeys) {
        if ([key isEqualToString:@"_j_business"] || [key isEqualToString:@"_j_msgid"] || [key isEqualToString:@"_j_uid"] || [key isEqualToString:@"aps"] || [key isEqualToString:@"_j_geofence"] || [key isEqualToString:@"_j_extras"] || [key isEqualToString:@"_j_ad_content"] || [key isEqualToString:@"_j_data_"]) {
            continue;
        }
        [extras setValue:userInfo[key] forKey:key];
    }

    id alertData =  userInfo[@"aps"][@"alert"];
    NSString *badge = userInfo[@"aps"][@"badge"]?[userInfo[@"aps"][@"badge"] stringValue]:@"";
    NSString *sound = userInfo[@"aps"][@"sound"]?userInfo[@"aps"][@"sound"]:@"";
    NSString *title = @"";
    NSString *content = @"";
    if([alertData isKindOfClass:[NSString class]]){
        content = alertData;
    }else if([alertData isKindOfClass:[NSDictionary class]]){
        title = alertData[@"title"]?alertData[@"title"]:@"";
        content = alertData[@"body"]?alertData[@"body"]:@"";
    }
    
    if (userInfo[@"_j_extras"] && [userInfo[@"_j_extras"] isKindOfClass:[NSDictionary class]]) {
        badge = userInfo[@"_j_extras"][@"badge"];
        sound = userInfo[@"_j_extras"][@"sound"];
        if ([userInfo[@"_j_extras"][@"alert"] isKindOfClass:[NSDictionary class]]) {
            title = userInfo[@"_j_extras"][@"alert"][@"title"];
            content = userInfo[@"_j_extras"][@"alert"][@"body"];
        }
    }

    NSMutableDictionary *temResult = [NSMutableDictionary dictionaryWithDictionary:@{
        @"messageID":userInfo[@"_j_msgid"]?:@"",
        @"title":title?:@"",
        @"content":content?:@"",
        @"badge":badge?:@"",
        @"ring":sound?:@"",
        @"extras":[extras copy]?:@{},
        @"iOS":userInfo?:@{},
        NOTIFICATION_EVENTTYPE:type,
    }];

    NSDictionary *result = [temResult copy];
    
    return result;
}

// 处理本地通知回调
- (void)handlerLocalNotiCallback:(NSDictionary *)userInfo type:(NSString *)type {
   
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    if (userInfo && [userInfo isKindOfClass:[NSDictionary class]]) {
       result = [NSMutableDictionary dictionaryWithDictionary:userInfo];
    }
    [result setValue:type forKey:NOTIFICATION_EVENTTYPE];
    if ([JPushStore shared].localNotiCallback) {
        [JPushStore shared].localNotiCallback(result, YES);
    }
}

- (NSDictionary *)convertInappMsg:(JPushInAppMessage *)inAppMessage isShow:(BOOL)isShow {
    
    NSString *target = @"";
    if (inAppMessage.target && [inAppMessage.target isKindOfClass:[NSArray class]] && inAppMessage.target.count > 0) {
        target = [inAppMessage.target objectAtIndex:0];
    }
    
    NSString *extras = @"";
    if (inAppMessage.extras && [inAppMessage.extras isKindOfClass:[NSDictionary class]]) {
        NSError *error;
       NSData *data = [NSJSONSerialization dataWithJSONObject:inAppMessage.extras options:0 error:&error];
        if (!error) {
            extras = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
    }
    
    NSDictionary *result = @{
        @"eventType": isShow? @"show": @"click",
        @"messageID": inAppMessage.mesageId?:@"", // 消息id
        @"title": inAppMessage.title?:@"",       // 标题
        @"content": inAppMessage.content?:@"",   // 内容
        @"inAppShowTarget": target?:@"",     // 目标页面
        @"inAppClickAction": inAppMessage.clickAction?:@"",  // 跳转地址
        @"inAppExtras": inAppMessage.extras?:@"", // 附加字段
    };
    return result;
}

// devicetoken
- (void)handleDeviceTokenSuccess:(NSData *)deviceToken {
    const unsigned int *tokenBytes = [deviceToken bytes];
    NSString *tokenString = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    NSDictionary *resultDic = @{
        @"code": @(0),
        @"deviceToken": tokenString?:@""
    };
    if ([JPushStore shared].devicetokenEventCallback) {
        [JPushStore shared].devicetokenEventCallback(resultDic, YES);
    }
}

- (void)handleDeviceTokenFail:(NSError *)err {
    NSDictionary *resultDic = @{
        @"code": @(-1),
        @"msg": err.localizedDescription?:@""
    };
    if ([JPushStore shared].devicetokenEventCallback) {
        [JPushStore shared].devicetokenEventCallback(resultDic, YES);
    }
}

#pragma mark - 地理位置权限
// 请求定位权限
- (void)requestLocationAuthorization {
    if (!_currentManager) {
        _currentManager = [[CLLocationManager alloc] init];
    }
    _currentManager.delegate = self;
    [_currentManager requestAlwaysAuthorization];
    [_currentManager requestWhenInUseAuthorization];
}

- (int)getLocationAuthorizationStatus {
    int status = [CLLocationManager authorizationStatus];
    return status;
}

- (BOOL)locationServicesEnabled {
    // yes -- "您的设备的［设置］－［隐私］－［定位］已开启"
    return [CLLocationManager locationServicesEnabled];
}

#pragma - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if ([JPushStore shared].locationAuthorizationCallBack) {
        NSDictionary *result = @{
            @"status": @(status)
        };
        [JPushStore shared].locationAuthorizationCallBack(result, YES);
    }
}

#pragma mark -
- (void)dealloc {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self];
}

// debug 打印控制
+ (void)logger:(NSObject *)tag log:(NSObject *)log
{
    [[JPushStore shared] logger:tag log:log];
}


// debug 打印控制
- (void)logger:(NSObject *)tag log:(NSObject *)log
{
//    NSString *a = [NSString stringWithFormat:@"JPushModule--->%@ %@ \n", tag,log];
//    [_loggerStr appendString:a];
//    [self writeToFile:_loggerStr];
    if (self.logEnable) {
        NSLog(@"JPushModule--->%@ %@", tag,log);
    }
    
}

//- (void)writeToFile:(NSString *)str {
//   
//    NSError *error = nil;
//    BOOL success = [str writeToFile:_logFilePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
//    if (success) {
//        NSLog(@"File created and content written successfully.");
//    } else {
//        NSLog(@"Error writing file: %@", error.localizedDescription);
//    }
//}

@end
