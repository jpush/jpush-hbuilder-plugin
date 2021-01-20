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


#define weakObj(obj) __weak typeof(obj) weak##obj = obj;


#define Param_RegisterID   @"registerID"
#define Param_Tags       @"tags"
#define Param_Tag        @"tag"
#define Param_Sequence   @"sequence"
#define Param_Alias      @"alias"
#define Param_TagEnable  @"tagEnable"
#define CODE             @"code"


NSString *const infoConfig_JPush             = @"JPush";
NSString *const infoConfig_JPush_APP_KEY     = @"APP_KEY";
NSString *const infoConfig_JPush_CHANNEL     = @"CHANNEL";

@interface JPushModule () 

@end


@implementation JPushModule

BOOL debugMode = NO;

UNI_EXPORT_METHOD(@selector(setBadge:))
UNI_EXPORT_METHOD(@selector(setMobileNumber:callback:))
UNI_EXPORT_METHOD(@selector(initCrashHandler))
UNI_EXPORT_METHOD(@selector(setLoggerEnable:))
UNI_EXPORT_METHOD(@selector(getRegistrationID:))

#pragma -

// 设置角标
- (void)setBadge:(NSDictionary *)params {
    [self logger:@"setBadge with params" log:params];
    NSInteger badge = [params[@"badge"] intValue];
    NSInteger appBadge = [params[@"appBadge"] intValue];
    [JPUSHService setBadge:badge];
    if (appBadge >= 0) {
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:appBadge];
    }
}

// 设置手机号
- (void)setMobileNumber:(NSString *)mobileNumber callback:(UniModuleKeepAliveCallback)callback {
    [self logger:@"setMobileNumber with mobileNumber:" log:mobileNumber];
    weakObj(self)
    [JPUSHService setMobileNumber:mobileNumber completion:^(NSError *error) {
        
        NSDictionary *result = [weakself convertResultWithCode:(error?error.code:0) content:nil];
        callback(result, NO);
    }];
}

// 打开崩溃日志上报
- (void)initCrashHandler {
    [self logger:@"initCrashHandler" log:nil];
    [JPUSHService crashLogON];
}

//设置调试模式，默认关闭状态
- (void)setLoggerEnable:(BOOL)enable {
    [self logger:@"setLoggerEnable:" log:(enable?@"true":@"false")];
    debugMode = enable;
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
            Param_RegisterID: registrationID ? registrationID : @"",
        };
        callback(content, NO);
    }];
}


UNI_EXPORT_METHOD(@selector(setLocation:))
UNI_EXPORT_METHOD(@selector(setLocationEanable:))

#pragma - 地理位置上报
- (void)setLocation:(NSDictionary *)params {
    [self logger:@"setLatitude with params" log:params];
    double latitude = [params[@"latitude"] doubleValue];
    double longitude = [params[@"longitude"] doubleValue];
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


UNI_EXPORT_METHOD(@selector(addConnectEventListener:))

#pragma - 连接状态监听
- (void)addConnectEventListener:(UniModuleKeepAliveCallback)callback {
    [self logger:@"addConnectEventListener" log:nil];
    [JPushStore shared].connectEventCallback = callback;
}



UNI_EXPORT_METHOD(@selector(addNotificationListener:))
UNI_EXPORT_METHOD(@selector(addCustomMessageListener:))

#pragma - 通知回调
// 远程通知事件 notificationEventType：分为notificationArrived和notificationOpened两种
- (void)addNotificationListener:(UniModuleKeepAliveCallback)callback {
    [self logger:@"addPushNotificationReceiveListener" log:nil];
    [JPushStore shared].pushNotiCallback = callback;
}

// 监听自定义消息/应用处于前台
- (void)addCustomMessageListener:(UniModuleKeepAliveCallback)callback {
    [self logger:@"addCustomNotificationReceiveListener" log:nil];
    [JPushStore shared].receiveCustomNotiCallback = callback;
}


UNI_EXPORT_METHOD(@selector(setIsAllowedInMessagePop:))
UNI_EXPORT_METHOD(@selector(addInMessageListener:))

#pragma - 应用内消息
/**
 * 是否允许应用内消息弹出,默认为允许
 */
- (void)setIsAllowedInMessagePop:(BOOL)enable {
    [self logger:@"jPushInMessageIsAllowedInMessagePop" log:enable?@"true":@"false"];
    [JPushStore shared].allowedInMessagePop = enable;
    if ([[JPushStore shared] respondsToSelector:@selector(jPushInMessageIsAllowedInMessagePop)]) {
        [[JPushStore shared] jPushInMessageIsAllowedInMessagePop];
    }
}

// 监听应用内消息
- (void)addInMessageListener:(UniModuleKeepAliveCallback)callback {
    [self logger:@"setInMessageListener" log:nil];
    [JPushStore shared].inMessageCallback = callback;
}


UNI_EXPORT_METHOD(@selector(addTags:callback:))
UNI_EXPORT_METHOD(@selector(updateTags:callback:))
UNI_EXPORT_METHOD(@selector(deleteTags:callback:))
UNI_EXPORT_METHOD(@selector(cleanTags:callback:))
UNI_EXPORT_METHOD(@selector(queryTag:callback:))
UNI_EXPORT_METHOD(@selector(getAllTags:callback:))
UNI_EXPORT_METHOD(@selector(setAlias:callback:))
UNI_EXPORT_METHOD(@selector(deleteAlias:callback:))
UNI_EXPORT_METHOD(@selector(queryAlias:callback:))


#pragma - tags/alias
// 新增tags
- (void)addTags:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    [self logger:@"addTags with params:" log:params];
    NSSet *tags = [NSSet setWithArray:params[Param_Tags]];
    NSInteger seq = [params[Param_Sequence] intValue];
    [JPUSHService addTags:tags completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSArray *tempTags = (iTags.allObjects.count > 0 ? iTags.allObjects : @[]);
        NSDictionary *content = @{
            Param_Tags:tempTags,
            Param_Sequence:@(seq)
        };
        NSDictionary *result = [self convertResultWithCode:iResCode content:content];
        callback(result, NO);
    } seq:seq];
}

// 更新tags
- (void)updateTags:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    [self logger:@"updateTags with params:" log:params];
    NSSet *tags = [NSSet setWithArray:params[Param_Tags]];
    NSInteger seq = [params[Param_Sequence] intValue];
    [JPUSHService setTags:tags completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSArray *tempTags = (iTags.allObjects.count > 0 ? iTags.allObjects : @[]);
        NSDictionary *content = @{
            Param_Tags:tempTags,
            Param_Sequence:@(seq)
        };
        NSDictionary *result = [self convertResultWithCode:iResCode content:content];
        callback(result, NO);
    } seq:seq];
}

// 删除所有tags
- (void)cleanTags:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    [self logger:@"deleteTags with params:" log:params];
    NSInteger seq = [params[Param_Sequence] intValue];
    [JPUSHService cleanTags:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSArray *tempTags = (iTags.allObjects.count > 0 ? iTags.allObjects : @[]);
        NSDictionary *content = @{
            Param_Tags:tempTags,
            Param_Sequence:@(seq)
        };
        NSDictionary *result = [self convertResultWithCode:iResCode content:content];
        callback(result, NO);
    } seq:seq];
}

// 删除指定的tags
- (void)deleteTags:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    [self logger:@"deleteTag with params:" log:params];
    NSSet *tags = [NSSet setWithArray:params[Param_Tags]];
    NSInteger seq = [params[Param_Sequence] intValue];
    [JPUSHService deleteTags:tags completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSArray *tempTags = (iTags.allObjects.count > 0 ? iTags.allObjects : @[]);
        NSDictionary *content = @{
            Param_Tags:tempTags,
            Param_Sequence:@(seq)
        };
        NSDictionary *result = [self convertResultWithCode:iResCode content:content];
        callback(result, NO);
    } seq:seq];
}

// 查询tags
- (void)getAllTags:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    [self logger:@"queryTags with params:" log:params];
    NSInteger seq = [params[Param_Sequence] intValue];
    [JPUSHService getAllTags:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSArray *tempTags = (iTags.allObjects.count > 0 ? iTags.allObjects : @[]);
        NSDictionary *content = @{
            Param_Tags:tempTags,
            Param_Sequence:@(seq)
        };
        NSDictionary *result = [self convertResultWithCode:iResCode content:content];
        callback(result, NO);
    } seq:seq];
}

// 查询某一个tag
- (void)queryTag:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    [self logger:@"queryTag with params:" log:params];
    NSString *tag = params[Param_Tag];
    NSInteger seq = [params[Param_Sequence] intValue];
    [JPUSHService validTag:tag completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq, BOOL isBind) {
        NSArray *tempTags = (iTags.allObjects.count > 0 ? iTags.allObjects : @[]);
        NSDictionary *content = @{
            Param_Tags:tempTags,
            Param_Sequence:@(seq),
            Param_TagEnable:@(isBind),
        };
        NSDictionary *result = [self convertResultWithCode:iResCode content:content];
        callback(result, NO);
    } seq:seq];
}

// 设置别名
- (void)setAlias:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    [self logger:@"setAlias with params:" log:params];
    NSString *alias = params[Param_Alias];
    NSInteger seq = [params[Param_Sequence] intValue];
    [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSDictionary *content = @{
            Param_Alias:iAlias? iAlias : @"",
            Param_Sequence:@(seq)
        };
        NSDictionary *result = [self convertResultWithCode:iResCode content:content];
        callback(result, NO);
    } seq:seq];
}

// 删除别名
- (void)deleteAlias:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    [self logger:@"deleteAlias with params:" log:params];
    NSInteger seq = [params[Param_Sequence] intValue];
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSDictionary *content = @{
            Param_Alias:iAlias? iAlias : @"",
            Param_Sequence:@(seq)
        };
        NSDictionary *result = [self convertResultWithCode:iResCode content:content];
        callback(result, NO);
    } seq:seq];
}

// 查询别名
- (void)queryAlias:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    [self logger:@"queryAlias with params:" log:params];
    NSInteger seq = [params[Param_Sequence] intValue];
    [JPUSHService getAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSDictionary *content = @{
            Param_Alias:iAlias? iAlias : @"",
            Param_Sequence:@(seq)
        };
        NSDictionary *result = [self convertResultWithCode:iResCode content:content];
        callback(result, NO);
    } seq:seq];
}


UNI_EXPORT_METHOD(@selector(setMaxGeofenceNumber:))
UNI_EXPORT_METHOD(@selector(deleteGeofence:))
UNI_EXPORT_METHOD(@selector(addGeofenceListener:))


#pragma - 地理围栏
- (void)setMaxGeofenceNumber:(NSInteger)maxCount {
    [self logger:@"setMaxGeofenceNumber with maxCount:" log:@(maxCount)];
    [JPUSHService setGeofenecMaxCount:maxCount];
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



UNI_EXPORT_METHOD(@selector(addLocalNotification:))

#pragma - 本地通知
- (void)addLocalNotification:(NSDictionary *)params {
    
    NSString *requestIdentifier = params[@"messageID"];
    NSString *title = params[@"title"];
    NSString *content = params[@"content"];
    NSDictionary *extras = params[@"extras"];
    
    JPushNotificationContent *notiContent = [[JPushNotificationContent alloc] init];
    notiContent.title = title;
    notiContent.body = content;
    notiContent.badge = @([extras[@"badge"] intValue]);
    if ([extras[@"sound"] isKindOfClass:[NSString class]] && [extras[@"sound"] length] > 0) {
        notiContent.sound = extras[@"sound"];
    }
   
    JPushNotificationTrigger *notiTrigger = [[JPushNotificationTrigger alloc] init];
    NSTimeInterval delay = 0;
    if (extras != nil && extras[@"delay"]) {
        delay = [extras[@"delay"] intValue];
    }
    if (@available(iOS 10.0, *)) {
        notiTrigger.timeInterval = delay;
    } else {
        notiTrigger.fireDate = [NSDate dateWithTimeIntervalSinceNow:delay];
    }
    
    JPushNotificationRequest *request = [[JPushNotificationRequest alloc] init];
    request.requestIdentifier = requestIdentifier;
    request.content = notiContent;
    request.trigger = notiTrigger;
    [JPUSHService addNotification:request];
    
}

// 移除指定的本地通知
- (void)removeLocalNotification:(NSDictionary *)params {
    [self logger:@"removeLocalNotification with params" log:params];
    NSArray *messageIDs = params[@"identifiers"];
    JPushNotificationIdentifier *identifier = [[JPushNotificationIdentifier alloc] init];
    identifier.identifiers = messageIDs;
    if (@available(iOS 10.0, *)) {
        BOOL delivered = [params[@"delivered"] boolValue];
        identifier.delivered = delivered;
    }
    [JPUSHService removeNotification:identifier];
}

// 移除所有的本地通知
- (void)clearLocalNotifications {
    [self logger:@"clearLocalNotifications" log:nil];
    [JPUSHService removeNotification:nil];
}


UNI_EXPORT_METHOD(@selector(initVoipService))

#pragma - voip
// 注册voip服务
- (void)initVoipService {
    [self logger:@"initVoipService" log:nil];
    [[JPushStore shared] initVoipService];
}


#pragma - tools
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
    if(debugMode){
          NSLog(@"JPushModule--->%@ %@", tag,log);
    }
}

@end
