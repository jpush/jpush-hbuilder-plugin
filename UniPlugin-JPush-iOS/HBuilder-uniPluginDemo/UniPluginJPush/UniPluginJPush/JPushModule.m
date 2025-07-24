//
//  JPushModule.m
//  UniPluginJPush
//
//  Created by huangshuni on 2021/1/12.
//

#import "JPushModule.h"
#import "JPUSHService.h"
#import "JPushStore.h"
#import <PushKit/PushKit.h>
// 如果需要使用 idfa 功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
#import <UserNotifications/UserNotifications.h>
#import <CoreLocation/CoreLocation.h>


#define weakObj(obj) __weak typeof(obj) weak##obj = obj;


#define MOBILENUMBER      @"mobileNumber"
#define REGISTER_ID       @"registerID"
#define LATITUDE          @"latitude"
#define LONGITUDE         @"longitude"

#define TAGS             @"tags"
#define TAG              @"tag"
#define SEQUENCE         @"sequence"
#define ALIAS            @"alias"
#define TAG_ENABLE       @"tagEnable"
#define CODE             @"code"
#define MESSAGE_ID       @"messageID"
#define TITLE            @"title"
#define CONTENT          @"content"
#define EXTRAS           @"extras"



@interface JPushModule () 

@end

@implementation JPushModule

UNI_EXPORT_METHOD(@selector(setBadge:))
UNI_EXPORT_METHOD(@selector(addMobileNumberListener:))
UNI_EXPORT_METHOD(@selector(setMobileNumber:))
UNI_EXPORT_METHOD(@selector(initCrashHandler))
UNI_EXPORT_METHOD(@selector(setLoggerEnable:))
UNI_EXPORT_METHOD(@selector(getRegistrationID:))

#pragma -

// 设置角标
- (void)setBadge:(NSInteger)badge {
    [self logger:@"setBadge with params" log:@(badge)];
    [JPUSHService setBadge:badge];
}

- (void)addMobileNumberListener:(UniModuleKeepAliveCallback)callback {
    [self logger:@"addMobileNumberListener" log:nil];
    [JPushStore shared].addMobileNumberCallBack = callback;
}

// 设置手机号
- (void)setMobileNumber:(NSDictionary *)params {
    [self logger:@"setMobileNumber with params:" log:params];
    weakObj(self)
    NSString *mobileNumber = params[MOBILENUMBER];
    [JPUSHService setMobileNumber:mobileNumber completion:^(NSError *error) {
        
        NSDictionary *result = [weakself convertResultWithCode:(error?error.code:0) content:nil];
        if ([JPushStore shared].addMobileNumberCallBack) {
            [JPushStore shared].addMobileNumberCallBack(result, YES);
        }
    }];
}

// 打开崩溃日志上报
- (void)initCrashHandler {
    [self logger:@"initCrashHandler" log:nil];
    [JPUSHService crashLogON];
}

//设置调试模式，默认关闭状态
- (void)setLoggerEnable:(BOOL)enable {
    [JPushStore shared].logEnable = enable;
    [self logger:@"setLoggerEnable:" log:(enable?@"true":@"false")];
    if (enable) {
        [JPUSHService setDebugMode];
    }else {
        [JPUSHService setLogOFF];
    }
}

// 获取注册id
- (void)getRegistrationID:(UniModuleKeepAliveCallback)callback {
    [self logger:@"getRegistrationID" log:nil];
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        NSDictionary *content = @{
            REGISTER_ID: registrationID ? registrationID : @"",
        };
        NSDictionary *result = [self convertResultWithCode:resCode content:content];
        callback(result, NO);
    }];
}


UNI_EXPORT_METHOD(@selector(setLocation:))
UNI_EXPORT_METHOD(@selector(setLocationEanable:))

#pragma - 地理位置上报
- (void)setLocation:(NSDictionary *)params {
    [self logger:@"setLatitude with params" log:params];
    double latitude = [params[LATITUDE] doubleValue];
    double longitude = [params[LONGITUDE] doubleValue];
    [JPUSHService setLatitude:latitude longitude:longitude];
}

/*!
 * @abstract 设置SDK地理位置权限开关
 *
 * @discussion 关闭地理位置之后，SDK地理围栏的相关功能将受到影响，默认是开启。
 *
 */
- (void)setLocationEanable:(BOOL)isEanble {
    [self logger:@"setLocationEanable" log:isEanble?@"true":@"false"];
    [JPUSHService setLocationEanable:isEanble];
}


UNI_EXPORT_METHOD(@selector(requestNotificationAuthorization:))
UNI_EXPORT_METHOD(@selector(openSettingsForNotification:))
UNI_EXPORT_METHOD(@selector(setNotiForegroundPresentationOptions:))

#pragma - 权限
//请求通知权限
- (void)requestNotificationAuthorization:(UniModuleKeepAliveCallback)callback {
    [self logger:@"requestNotificationAuthorization" log:nil];
    [JPUSHService requestNotificationAuthorization:^(JPAuthorizationStatus status) {
        NSDictionary *result = @{@"status":@(status)};
        callback(result, NO);
    }];
}

//打开通知设置页面
- (void)openSettingsForNotification:(UniModuleKeepAliveCallback)callback {
    [self logger:@"openSettingsForNotification" log:nil];
    [JPUSHService openSettingsForNotification:^(BOOL success) {
        NSDictionary *result = [self convertResultWithCode:(success?0:1) content:nil];
        callback(result, NO);
    }];
}

// 设置通知前台的展示效果
- (void)setNotiForegroundPresentationOptions:(NSDictionary *)options {
    [[JPushStore shared] setNotiForegroundAuthTypes:options];
}


UNI_EXPORT_METHOD_SYNC(@selector(locationServicesEnabled))
UNI_EXPORT_METHOD_SYNC(@selector(getLocationAuthorizationStatus))
UNI_EXPORT_METHOD(@selector(requestLocationAuthorization:))

// 请求位置权限
- (BOOL)locationServicesEnabled {
    [self logger:@"locationServicesEnabled" log:nil];
    BOOL ret = [[JPushStore shared] locationServicesEnabled];
    return ret;
}

- (void)requestLocationAuthorization:(UniModuleKeepAliveCallback)callback {
    [self logger:@"requestLocationAuthorization" log:nil];
    [JPushStore shared].locationAuthorizationCallBack = callback;
    [[JPushStore shared] requestLocationAuthorization];
}

- (int)getLocationAuthorizationStatus {
    [self logger:@"getLocationAuthorizationStatus" log:nil];
    int ret = [[JPushStore shared] getLocationAuthorizationStatus];
    return ret;
}


UNI_EXPORT_METHOD(@selector(initJPushService))
UNI_EXPORT_METHOD(@selector(addConnectEventListener:))

#pragma  初始化
- (void)initJPushService {
    [self logger:@"initJPushService" log:nil];
    [[JPushStore shared] initJPushService:[JPushStore shared].launchOptions];
}

#pragma - 连接状态监听
- (void)addConnectEventListener:(UniModuleKeepAliveCallback)callback {
    [self logger:@"addConnectEventListener" log:nil];
    // 监听连接状态
    [[JPushStore shared] addConnectEventObserver];
    [JPushStore shared].connectEventCallback = callback;
}



UNI_EXPORT_METHOD(@selector(addNotificationListener:))
UNI_EXPORT_METHOD(@selector(addCustomMessageListener:))
UNI_EXPORT_METHOD(@selector(addDeviceTokenListener:))
UNI_EXPORT_METHOD(@selector(addInMessageListener:))

#pragma - 通知回调
// 远程通知事件 notificationEventType：分为notificationArrived和notificationOpened两种
- (void)addNotificationListener:(UniModuleKeepAliveCallback)callback {
    [self logger:@"addPushNotificationReceiveListener" log:nil];
    [JPushStore shared].pushNotiCallback = callback;
    
    /* 经测试，app杀死的情况，点击通知进入app，各函数的执行情况为：
     1. application:didFinishLaunchingWithOptions:
     2. jpushNotificationCenter:didReceiveNotificationResponse: withCompletionHandler:
     3. uniapp --- onLaunch()
    以下代码为了防止的情况：当app杀死的情况下，点击通知进入app，因为该方法在点击通知的回调方法(jpushNotificationCenter:didReceiveNotificationResponse: withCompletionHandler:)之后,callback值为空，所以并没有回调值给js端，导致js端监听不到通知。
     */
    static BOOL onceLaunchPushBack = NO;
    if (onceLaunchPushBack == YES) {
        [self logger:@"addNotificationListener,onceLaunchPushBack,return" log:nil];
        return;
    }
    onceLaunchPushBack = YES;
    if ([JPushStore shared].launchOptions == nil || ![[JPushStore shared].launchOptions isKindOfClass:[NSDictionary class]]) {
        [self logger:@"addNotificationListener,no launchOptions ,return" log:nil];
        return;
    }
    if ([[JPushStore shared].launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey] != nil) {
        UIApplicationState state = [[UIApplication sharedApplication] applicationState];
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSDictionary *sceneDic = [infoDictionary valueForKey:@"UIApplicationSceneManifest"];
        BOOL isScene = sceneDic?YES:NO;
        [self logger:[NSString stringWithFormat:@"lauch NOTIFICATION_OPENED - %ld", (long)state] log:nil];
        if (state == UIApplicationStateBackground && !isScene) {
            [self logger:@"lauch UIApplicationStateBackground - may be content-available" log:nil];
            return;
        }
        [[JPushStore shared] handeleApnsCallback:[[JPushStore shared].launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey] type:NOTIFICATION_OPENED];
    }
}

// 监听自定义消息/应用处于前台
- (void)addCustomMessageListener:(UniModuleKeepAliveCallback)callback {
    [self logger:@"addCustomNotificationReceiveListener" log:nil];
    [JPushStore shared].receiveCustomNotiCallback = callback;
}


// 监听devicetoken的状态
- (void)addDeviceTokenListener:(UniModuleKeepAliveCallback)callback {
    [self logger:@"addDeviceTokenListener" log:nil];
    [JPushStore shared].devicetokenEventCallback = callback;
}

// 监听inapp消息
- (void)addInMessageListener:(UniModuleKeepAliveCallback)callback {
    [self logger:@"addInMessageListener" log:nil];
    [JPushStore shared].inAppMessageCallback = callback;
}

UNI_EXPORT_METHOD(@selector(pageEnterTo:))
UNI_EXPORT_METHOD(@selector(pageLeave:))

// 应用内消息需要配置以下两个接口
- (void)pageEnterTo:(NSString *)pageName{
    [JPUSHService pageEnterTo:pageName];
}

- (void)pageLeave:(NSString *)pageName{
    [JPUSHService pageLeave:pageName];
}

UNI_EXPORT_METHOD(@selector(addTagAliasListener:))
UNI_EXPORT_METHOD(@selector(addTags:))
UNI_EXPORT_METHOD(@selector(updateTags:))
UNI_EXPORT_METHOD(@selector(deleteTags:))
UNI_EXPORT_METHOD(@selector(cleanTags:))
UNI_EXPORT_METHOD(@selector(queryTag:))
UNI_EXPORT_METHOD(@selector(getAllTags:))
UNI_EXPORT_METHOD(@selector(setAlias:))
UNI_EXPORT_METHOD(@selector(deleteAlias:))
UNI_EXPORT_METHOD(@selector(queryAlias:))


#pragma mark - tags/alias

- (void)addTagAliasListener:(UniModuleKeepAliveCallback)callback {
    [self logger:@"addTagAliasListener" log:nil];
    [JPushStore shared].tagAliasCallBack = callback;
}


// 新增tags
- (void)addTags:(NSDictionary *)params {
    [self logger:@"addTags with params:" log:params];
    NSSet *tags = [NSSet setWithArray:params[TAGS]];
    NSInteger seq = params[SEQUENCE]?[params[SEQUENCE] integerValue]:-1;
    weakObj(self)
    [JPUSHService addTags:tags completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSArray *tempTags = (iTags.allObjects.count > 0 ? iTags.allObjects : @[]);
        NSDictionary *content = @{
            TAGS:tempTags,
            SEQUENCE:@(seq)
        };
        NSDictionary *result = [weakself convertResultWithCode:iResCode content:content];
        if ([JPushStore shared].tagAliasCallBack) {
            [JPushStore shared].tagAliasCallBack(result, YES);
        }
    } seq:seq];
}

// 更新tags
- (void)updateTags:(NSDictionary *)params {
    [self logger:@"updateTags with params:" log:params];
    NSSet *tags = [NSSet setWithArray:params[TAGS]];
    NSInteger seq = params[SEQUENCE]?[params[SEQUENCE] integerValue]:-1;
    weakObj(self)
    [JPUSHService setTags:tags completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSArray *tempTags = (iTags.allObjects.count > 0 ? iTags.allObjects : @[]);
        NSDictionary *content = @{
            TAGS:tempTags,
            SEQUENCE:@(seq)
        };
        NSDictionary *result = [weakself convertResultWithCode:iResCode content:content];
        if ([JPushStore shared].tagAliasCallBack) {
            [JPushStore shared].tagAliasCallBack(result, YES);
        }
    } seq:seq];
}

// 删除所有tags
- (void)cleanTags:(NSDictionary *)params {
    [self logger:@"deleteTags with params:" log:params];
    NSInteger seq = params[SEQUENCE]?[params[SEQUENCE] integerValue]:-1;
    weakObj(self)
    [JPUSHService cleanTags:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSArray *tempTags = (iTags.allObjects.count > 0 ? iTags.allObjects : @[]);
        NSDictionary *content = @{
            TAGS:tempTags,
            SEQUENCE:@(seq)
        };
        NSDictionary *result = [weakself convertResultWithCode:iResCode content:content];
        if ([JPushStore shared].tagAliasCallBack) {
            [JPushStore shared].tagAliasCallBack(result, YES);
        }
    } seq:seq];
}

// 删除指定的tags
- (void)deleteTags:(NSDictionary *)params {
    [self logger:@"deleteTag with params:" log:params];
    NSSet *tags = [NSSet setWithArray:params[TAGS]];
    NSInteger seq = params[SEQUENCE]?[params[SEQUENCE] integerValue]:-1;
    weakObj(self)
    [JPUSHService deleteTags:tags completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSArray *tempTags = (iTags.allObjects.count > 0 ? iTags.allObjects : @[]);
        NSDictionary *content = @{
            TAGS:tempTags,
            SEQUENCE:@(seq)
        };
        NSDictionary *result = [weakself convertResultWithCode:iResCode content:content];
        if ([JPushStore shared].tagAliasCallBack) {
            [JPushStore shared].tagAliasCallBack(result, YES);
        }
    } seq:seq];
}

// 查询tags
- (void)getAllTags:(NSDictionary *)params {
    [self logger:@"queryTags with params:" log:params];
    NSInteger seq = params[SEQUENCE]?[params[SEQUENCE] integerValue]:-1;
    weakObj(self)
    [JPUSHService getAllTags:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSArray *tempTags = (iTags.allObjects.count > 0 ? iTags.allObjects : @[]);
        NSDictionary *content = @{
            TAGS:tempTags,
            SEQUENCE:@(seq)
        };
        NSDictionary *result = [weakself convertResultWithCode:iResCode content:content];
        if ([JPushStore shared].tagAliasCallBack) {
            [JPushStore shared].tagAliasCallBack(result, YES);
        }
    } seq:seq];
}

// 查询某一个tag
- (void)queryTag:(NSDictionary *)params {
    [self logger:@"queryTag with params:" log:params];
    NSString *tag = params[TAG];
    NSInteger seq = params[SEQUENCE]?[params[SEQUENCE] integerValue]:-1;
    weakObj(self)
    [JPUSHService validTag:tag completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq, BOOL isBind) {
        NSArray *tempTags = (iTags.allObjects.count > 0 ? iTags.allObjects : @[]);
        NSDictionary *content = @{
            TAGS:tempTags,
            SEQUENCE:@(seq),
            TAG_ENABLE:@(isBind),
        };
        NSDictionary *result = [weakself convertResultWithCode:iResCode content:content];
        if ([JPushStore shared].tagAliasCallBack) {
            [JPushStore shared].tagAliasCallBack(result, YES);
        }
    } seq:seq];
}

// 设置别名
- (void)setAlias:(NSDictionary *)params {
    [self logger:@"setAlias with params:" log:params];
    NSString *alias = params[ALIAS];
    NSInteger seq = params[SEQUENCE]?[params[SEQUENCE] integerValue]:-1;
    weakObj(self)
    [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSDictionary *content = @{
            ALIAS:iAlias? iAlias : @"",
            SEQUENCE:@(seq)
        };
        NSDictionary *result = [weakself convertResultWithCode:iResCode content:content];
        if ([JPushStore shared].tagAliasCallBack) {
            [JPushStore shared].tagAliasCallBack(result, YES);
        }
    } seq:seq];
}

// 删除别名
- (void)deleteAlias:(NSDictionary *)params {
    [self logger:@"deleteAlias with params:" log:params];
    NSInteger seq = params[SEQUENCE]?[params[SEQUENCE] integerValue]:-1;
    weakObj(self)
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSDictionary *content = @{
            ALIAS:iAlias? iAlias : @"",
            SEQUENCE:@(seq)
        };
        NSDictionary *result = [weakself convertResultWithCode:iResCode content:content];
        if ([JPushStore shared].tagAliasCallBack) {
            [JPushStore shared].tagAliasCallBack(result, YES);
        }
    } seq:seq];
}

// 查询别名
- (void)queryAlias:(NSDictionary *)params {
    [self logger:@"queryAlias with params:" log:params];
    NSInteger seq = params[SEQUENCE]?[params[SEQUENCE] integerValue]:-1;
    weakObj(self)
    [JPUSHService getAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSDictionary *content = @{
            ALIAS:iAlias? iAlias : @"",
            SEQUENCE:@(seq)
        };
        NSDictionary *result = [weakself convertResultWithCode:iResCode content:content];
        if ([JPushStore shared].tagAliasCallBack) {
            [JPushStore shared].tagAliasCallBack(result, YES);
        }
    } seq:seq];
}


UNI_EXPORT_METHOD(@selector(setMaxGeofenceNumber:))
UNI_EXPORT_METHOD(@selector(deleteGeofence:))
UNI_EXPORT_METHOD(@selector(addGeofenceListener:))


#pragma mark - 地理围栏
- (void)setMaxGeofenceNumber:(NSInteger)maxCount {
    [self logger:@"setMaxGeofenceNumber with maxCount:" log:@(maxCount)];
    [JPUSHService setGeofeneceMaxCount:maxCount];
}

- (void)deleteGeofence:(NSString *)geofenceID {
    [self logger:@"deleteGeofence with geofenceID:" log:geofenceID];
    [JPUSHService removeGeofenceWithIdentifier:geofenceID];
}

#pragma - 地理围栏监听
- (void)addGeofenceListener:(UniModuleKeepAliveCallback)callback {
    [self logger:@"addDidEnterRegionListener" log:nil];
    [JPushStore shared].geofenceCallback = callback;
}


UNI_EXPORT_METHOD(@selector(addLocalNotificationListener:))
UNI_EXPORT_METHOD(@selector(addLocalNotification:))
UNI_EXPORT_METHOD(@selector(removeLocalNotification:))
UNI_EXPORT_METHOD(@selector(clearLocalNotifications))


#pragma mark - 本地通知

- (void)addLocalNotificationListener:(UniModuleKeepAliveCallback)callback {
    [self logger:@"addLocalNotificationListener" log:nil];
    [JPushStore shared].localNotiCallback = callback;
    
    // 解决 app被本地通知唤醒 接收不到通知回调
    static BOOL onceLaunchLocalPushBack = NO;
    if (onceLaunchLocalPushBack == YES) {
        return;
    }
    onceLaunchLocalPushBack = YES;
    if ([JPushStore shared].launchOptions == nil || ![[JPushStore shared].launchOptions isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    if ([[JPushStore shared].launchOptions valueForKey:UIApplicationLaunchOptionsLocalNotificationKey] != nil){
        UILocalNotification *localNotification = [[JPushStore shared].launchOptions valueForKey:UIApplicationLaunchOptionsLocalNotificationKey];
        [[JPushStore shared] handlerLocalNotiCallback:localNotification.userInfo type:NOTIFICATION_OPENED];
    }
}

- (void)addLocalNotification:(NSDictionary *)params {

    NSString *messageID = params[MESSAGE_ID]?params[MESSAGE_ID]:@"";
    
    JPushNotificationContent *content = [[JPushNotificationContent alloc] init];
    NSString *notificationTitle = params[TITLE]?params[TITLE]:@"";
    NSString *notificationContent = params[CONTENT]?params[CONTENT]:@"";
    content.title = notificationTitle;
    content.body = notificationContent;
    content.categoryIdentifier = @"jpush_noti_dismissAction_callback_category";
    if(params[EXTRAS]){
        content.userInfo = @{MESSAGE_ID:messageID,TITLE:notificationTitle,CONTENT:notificationContent,EXTRAS:params[EXTRAS]};
    }else{
        content.userInfo = @{MESSAGE_ID:messageID,TITLE:notificationTitle,CONTENT:notificationContent};
    }
    content.sound = params[@"sound"];
    JPushNotificationTrigger *trigger = [[JPushNotificationTrigger alloc] init];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    components = dateComponent;
    components.second = [dateComponent second]+1;
    if (@available(iOS 10.0, *)) {
        trigger.dateComponents = components;
    } else {
        trigger.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
    }
    if (@available(iOS 15.0, *)) {
      content.interruptionLevel = UNNotificationInterruptionLevelTimeSensitive;
      content.relevanceScore = 1;
    }
    JPushNotificationRequest *request = [[JPushNotificationRequest alloc] init];
    request.requestIdentifier = messageID;
    request.content = content;
    request.trigger = trigger;
    [JPUSHService addNotification:request];
    
}

// 移除指定的本地通知
- (void)removeLocalNotification:(NSDictionary *)params {
    NSString *requestIdentifier = params[MESSAGE_ID];
    if ([requestIdentifier isKindOfClass:[NSString class]]) {
        JPushNotificationIdentifier *identifier = [[JPushNotificationIdentifier alloc] init];
        identifier.identifiers = @[requestIdentifier];
        if (@available(iOS 10.0, *)) {
            identifier.delivered = YES;
        }
        [JPUSHService removeNotification:identifier];
    }
}

// 移除所有的本地通知
- (void)clearLocalNotifications {
    [self logger:@"clearLocalNotifications" log:nil];
    [JPUSHService removeNotification:nil];
}

UNI_EXPORT_METHOD(@selector(setCollectControl:))
UNI_EXPORT_METHOD(@selector(setSmartPushEnable:))
- (void)setCollectControl:(NSDictionary *)params {
    JPushCollectControl *control = [[JPushCollectControl alloc] init];
    BOOL gps = YES;
    BOOL cell = YES;
    BOOL bssid = YES;
    BOOL ssid = YES;
    if (params[@"gps"] && [params[@"gps"] isKindOfClass:[NSNumber class]]) {
        gps = [params[@"gps"] boolValue];
    }
    if (params[@"cell"] && [params[@"cell"] isKindOfClass:[NSNumber class]]) {
        cell = [params[@"cell"] boolValue];
    }
    if (params[@"bssid"] && [params[@"bssid"] isKindOfClass:[NSNumber class]]) {
        bssid = [params[@"bssid"] boolValue];
    }
    if (params[@"ssid"] && [params[@"ssid"] isKindOfClass:[NSNumber class]]) {
        ssid = [params[@"ssid"] boolValue];
    }
    control.gps = gps;
    control.cell = cell;
    control.bssid = bssid;
    control.ssid = ssid;
    [JPUSHService setCollectControl:control];
}

- (void)setSmartPushEnable:(BOOL)enable {
    [JPUSHService setSmartPushEnable:enable];
}


UNI_EXPORT_METHOD(@selector(initVoipService))
UNI_EXPORT_METHOD(@selector(addVoipPushIncomingListener:))

#pragma mark - voip
// 注册voip服务
- (void)initVoipService {
    [self logger:@"initVoipService" log:nil];
    [[JPushStore shared] initVoipService];
}

- (void)addVoipPushIncomingListener:(UniModuleKeepAliveCallback)callback {
    [self logger:@"addVoipPushIncomingListener" log:nil];
    [JPushStore shared].voipCallback = callback;
}

#pragma mark - other
- (NSDictionary *)convertResultWithCode:(NSInteger)code content:(NSDictionary *)dicInfo {
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    result[CODE] = @(code);
    [dicInfo enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if(![key isEqualToString:CODE]) {
            [result setObject:obj forKey:key];
        }
    }];
    return [result copy];
}

// debug 打印控制
- (void)logger:(NSObject *)tag log:(NSObject *)log
{
    [JPushStore logger:tag log:log];
}

@end
