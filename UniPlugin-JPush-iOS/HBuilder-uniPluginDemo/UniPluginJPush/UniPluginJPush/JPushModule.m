//
//  JPushModule.m
//  UniPluginJPush
//
//  Created by huangshuni on 2021/1/12.
//

#import "JPushModule.h"
#import "JPUSHService.h"
#import "JPushStore.h"
#import <UserNotifications/UserNotifications.h>

#define weakObj(obj) __weak typeof(obj) weak##obj = obj;


NSString *const infoConfig_JPush             = @"JPush";
NSString *const infoConfig_JPush_APP_KEY     = @"APP_KEY";
NSString *const infoConfig_JPush_CHANNEL     = @"CHANNEL";

@interface JPushModule () 

@end


@implementation JPushModule

BOOL debugMode = NO;


UNI_EXPORT_METHOD(@selector(setMobileNumber:callback:))
UNI_EXPORT_METHOD(@selector(initCrashHandler))
UNI_EXPORT_METHOD(@selector(setLoggerEnable:))
UNI_EXPORT_METHOD(@selector(getRegistrationID:))

#pragma -
// 设置手机号
- (void)setMobileNumber:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    [self logger:@"setMobileNumber with mobileNumber:" log:params];
    NSString *mobileNumber = params[@"mobileNumber"];
    weakObj(self)
    [JPUSHService setMobileNumber:mobileNumber completion:^(NSError *error) {
        NSDictionary *result = [weakself convertResultWithCode:(error?1:0) content:nil];
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
            @"registrationID": registrationID ? registrationID : @"",
        };
        NSDictionary *result = [self convertResultWithCode:resCode content:content];
        callback(result, NO);
    }];
}

UNI_EXPORT_METHOD(@selector(requestNotificationAuthorization:))
UNI_EXPORT_METHOD(@selector(openSettingsForNotification:))

#pragma - 权限
//请求通知权限
- (void)requestNotificationAuthorization:(UniModuleKeepAliveCallback)callback {
    [self logger:@"requestNotificationAuthorization" log:nil];
    [JPUSHService requestNotificationAuthorization:^(JPAuthorizationStatus status) {
        NSDictionary *result = [self convertResultWithCode:0 content:@{@"status":@(status)}];
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

UNI_EXPORT_METHOD(@selector(addPushNotificationReceiveListener:))
UNI_EXPORT_METHOD(@selector(addPushNotificationOpenListener:))
UNI_EXPORT_METHOD(@selector(addCustomNotificationReceiveListener:))

#pragma - 接收通知
// 监听接收到远程推送/应用处于前台
- (void)addPushNotificationReceiveListener:(UniModuleKeepAliveCallback)callback {
    [self logger:@"addPushNotificationReceiveListener" log:nil];
    [JPushStore shared].receivePushNotiCallback = callback;
}

// 监听点击通知栏消息事件
- (void)addPushNotificationOpenListener:(UniModuleKeepAliveCallback)callback {
    [self logger:@"addPushNotificationOpenListener" log:nil];
    [JPushStore shared].openPushNotiCallback = callback;
}

// 监听自定义消息/应用处于前台
- (void)addCustomNotificationReceiveListener:(UniModuleKeepAliveCallback)callback {
    [self logger:@"addCustomNotificationReceiveListener" log:nil];
    [JPushStore shared].receiveCustomNotiCallback = callback;
}


UNI_EXPORT_METHOD(@selector(addTags:callback:))
UNI_EXPORT_METHOD(@selector(updateTags:callback:))
UNI_EXPORT_METHOD(@selector(deleteTag:callback:))
UNI_EXPORT_METHOD(@selector(deleteTags:callback:))
UNI_EXPORT_METHOD(@selector(queryTag:callback:))
UNI_EXPORT_METHOD(@selector(queryTags:callback:))
UNI_EXPORT_METHOD(@selector(setAlias:callback:))
UNI_EXPORT_METHOD(@selector(deleteAlias:callback:))
UNI_EXPORT_METHOD(@selector(queryAlias:callback:))


#pragma - tags/alias
- (void)addTags:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    [self logger:@"addTags with params:" log:params];
    NSSet *tags = [NSSet setWithArray:params[@"tags"]];
    NSInteger seq = [params[@"sequence"] intValue];
    [JPUSHService addTags:tags completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSArray *tempTags = (iTags.allObjects.count > 0 ? iTags.allObjects : @[]);
        NSDictionary *content = @{
            @"iTags":tempTags,
            @"seq":@(seq)
        };
        NSDictionary *result = [self convertResultWithCode:iResCode content:content];
        callback(result, NO);
    } seq:seq];
}

- (void)updateTags:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    [self logger:@"updateTags with params:" log:params];
    NSSet *tags = [NSSet setWithArray:params[@"tags"]];
    NSInteger seq = [params[@"sequence"] intValue];
    [JPUSHService setTags:tags completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSArray *tempTags = (iTags.allObjects.count > 0 ? iTags.allObjects : @[]);
        NSDictionary *content = @{
            @"iTags":tempTags,
            @"seq":@(seq)
        };
        NSDictionary *result = [self convertResultWithCode:iResCode content:content];
        callback(result, NO);
    } seq:seq];
}

- (void)deleteTags:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    [self logger:@"deleteTags with params:" log:params];
    NSInteger seq = [params[@"sequence"] intValue];
    [JPUSHService cleanTags:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSArray *tempTags = (iTags.allObjects.count > 0 ? iTags.allObjects : @[]);
        NSDictionary *content = @{
            @"iTags":tempTags,
            @"seq":@(seq)
        };
        NSDictionary *result = [self convertResultWithCode:iResCode content:content];
        callback(result, NO);
    } seq:seq];
}

- (void)deleteTag:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    [self logger:@"deleteTag with params:" log:params];
    NSSet *tags = [NSSet setWithArray:params[@"tags"]];
    NSInteger seq = [params[@"sequence"] intValue];
    [JPUSHService deleteTags:tags completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSArray *tempTags = (iTags.allObjects.count > 0 ? iTags.allObjects : @[]);
        NSDictionary *content = @{
            @"iTags":tempTags,
            @"seq":@(seq)
        };
        NSDictionary *result = [self convertResultWithCode:iResCode content:content];
        callback(result, NO);
    } seq:seq];
}


- (void)queryTags:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    [self logger:@"queryTags with params:" log:params];
    NSInteger seq = [params[@"sequence"] intValue];
    [JPUSHService getAllTags:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSArray *tempTags = (iTags.allObjects.count > 0 ? iTags.allObjects : @[]);
        NSDictionary *content = @{
            @"iTags":tempTags,
            @"seq":@(seq)
        };
        NSDictionary *result = [self convertResultWithCode:iResCode content:content];
        callback(result, NO);
    } seq:seq];
}

- (void)queryTag:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    [self logger:@"queryTag with params:" log:params];
    NSString *tag = params[@"tag"];
    NSInteger seq = [params[@"sequence"] intValue];
    [JPUSHService validTag:tag completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq, BOOL isBind) {
        NSArray *tempTags = (iTags.allObjects.count > 0 ? iTags.allObjects : @[]);
        NSDictionary *content = @{
            @"iTags":tempTags,
            @"seq":@(seq),
            @"isBind":@(isBind),
        };
        NSDictionary *result = [self convertResultWithCode:iResCode content:content];
        callback(result, NO);
    } seq:seq];
}

- (void)setAlias:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    [self logger:@"setAlias with params:" log:params];
    NSString *alias = params[@"alias"];
    NSInteger seq = [params[@"sequence"] intValue];
    [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSDictionary *content = @{
            @"iAlias":iAlias? iAlias : @"",
            @"seq":@(seq)
        };
        NSDictionary *result = [self convertResultWithCode:iResCode content:content];
        callback(result, NO);
    } seq:seq];
}

- (void)deleteAlias:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    [self logger:@"deleteAlias with params:" log:params];
    NSInteger seq = [params[@"sequence"] intValue];
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSDictionary *content = @{
            @"iAlias":iAlias? iAlias : @"",
            @"seq":@(seq)
        };
        NSDictionary *result = [self convertResultWithCode:iResCode content:content];
        callback(result, NO);
    } seq:seq];
}

- (void)queryAlias:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    [self logger:@"queryAlias with params:" log:params];
    NSInteger seq = [params[@"sequence"] intValue];
    [JPUSHService getAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSDictionary *content = @{
            @"iAlias":iAlias? iAlias : @"",
            @"seq":@(seq)
        };
        NSDictionary *result = [self convertResultWithCode:iResCode content:content];
        callback(result, NO);
    } seq:seq];
}


UNI_EXPORT_METHOD(@selector(setMaxGeofenceNumber:))
UNI_EXPORT_METHOD(@selector(deleteGeofence:))
UNI_EXPORT_METHOD(@selector(addDidEnterRegionListener:))
UNI_EXPORT_METHOD(@selector(addDidExitRegionListener:))


#pragma - 地理围栏
- (void)setMaxGeofenceNumber:(NSInteger)maxCount {
    [self logger:@"setMaxGeofenceNumber with maxCount:" log:@(maxCount)];
    [JPUSHService setGeofenecMaxCount:maxCount];
}

- (void)deleteGeofence:(NSString *)geofenceID {
    [self logger:@"deleteGeofence with geofenceID:" log:geofenceID];
    [JPUSHService removeGeofenceWithIdentifier:geofenceID];
}

- (void)addDidEnterRegionListener:(UniModuleKeepAliveCallback)callback {
    [self logger:@"addDidEnterRegionListener" log:nil];
    [JPushStore shared].didEnterRegionCallback = callback;
}

- (void)addDidExitRegionListener:(UniModuleKeepAliveCallback)callback {
    [self logger:@"addDidExitRegionListener" log:nil];
    [JPushStore shared].didExitRegionCallback = callback;
}


#pragma - 本地通知


#pragma - tools
- (NSDictionary *)convertResultWithCode:(NSInteger)code content:(NSDictionary *)dicInfo {
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    result[@"code"] = @(code);
    [dicInfo enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if(![key isEqualToString:@"code"]) {
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
