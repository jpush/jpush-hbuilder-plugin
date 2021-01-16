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

NSString *const infoConfig_JPush             = @"JPush";
NSString *const infoConfig_JPush_APP_KEY     = @"APP_KEY";
NSString *const infoConfig_JPush_CHANNEL     = @"CHANNEL";

@interface JPushModule () 

@end


@implementation JPushModule


UNI_EXPORT_METHOD(@selector(setMobileNumber:callback:))
UNI_EXPORT_METHOD(@selector(initCrashHandler))
UNI_EXPORT_METHOD(@selector(setLoggerEnable))

UNI_EXPORT_METHOD(@selector(requestNotificationAuthorization:))
UNI_EXPORT_METHOD(@selector(openSettingsForNotification:))
UNI_EXPORT_METHOD(@selector(getRegistrationID:))

UNI_EXPORT_METHOD(@selector(addPushNotificationReceiveListener:))
UNI_EXPORT_METHOD(@selector(addPushNotificationOpenListener:))
UNI_EXPORT_METHOD(@selector(addCustomNotificationReceiveListener:))

UNI_EXPORT_METHOD(@selector(addTags:callback:))
UNI_EXPORT_METHOD(@selector(updateTags:callback:))
UNI_EXPORT_METHOD(@selector(deleteTag:callback:))
UNI_EXPORT_METHOD(@selector(deleteTags:callback:))
UNI_EXPORT_METHOD(@selector(queryTag:callback:))
UNI_EXPORT_METHOD(@selector(queryTags:callback:))
UNI_EXPORT_METHOD(@selector(setAlias:callback:))
UNI_EXPORT_METHOD(@selector(deleteAlias:callback:))
UNI_EXPORT_METHOD(@selector(queryAlias:callback:))

#pragma - 统计
- (void)setMobileNumber:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    NSString *mobileNumber = params[@"mobileNumber"];
    [JPUSHService setMobileNumber:mobileNumber completion:^(NSError *error) {
        NSDictionary *result = @{@"code":@(!error)};
        callback(result, NO);
    }];
}

// 打开崩溃日志上报
- (void)initCrashHandler {
    [JPUSHService crashLogON];
}

//设置调试模式，默认关闭状态
- (void)setLoggerEnable {
    [JPUSHService setDebugMode];
}


#pragma - 权限
//请求通知权限
- (void)requestNotificationAuthorization:(UniModuleKeepAliveCallback)callback {
    [JPUSHService requestNotificationAuthorization:^(JPAuthorizationStatus status) {
        NSDictionary *authorizationStatus = @{@"status":@(status)};
        callback(authorizationStatus, NO);
    }];
}

//打开通知设置页面
- (void)openSettingsForNotification:(UniModuleKeepAliveCallback)callback {
    [JPUSHService openSettingsForNotification:^(BOOL success) {
        NSDictionary *successState = @{@"code":@(success)};
        callback(successState, NO);
    }];
}

- (void)getRegistrationID:(UniModuleKeepAliveCallback)callback {
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        NSDictionary *result = @{
            @"resCode": @(resCode),
            @"registrationID": registrationID,
        };
        callback(result, NO);
    }];
}

#pragma - 接收通知
// 监听接收到远程推送/应用处于前台
- (void)addPushNotificationReceiveListener:(UniModuleKeepAliveCallback)callback {
    [JPushStore shared].receivePushNotiCallback = callback;
}

// 监听点击通知栏消息事件
- (void)addPushNotificationOpenListener:(UniModuleKeepAliveCallback)callback {
    [JPushStore shared].openPushNotiCallback = callback;
}

// 监听自定义消息/应用处于前台
- (void)addCustomNotificationReceiveListener:(UniModuleKeepAliveCallback)callback {
    [JPushStore shared].receiveCustomNotiCallback = callback;
}


#pragma - tags/alias
- (void)addTags:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    NSSet *tempTags = [NSSet setWithArray:params[@"tags"]];
    NSInteger seq = [params[@"sequence"] intValue];
    [JPUSHService addTags:tempTags completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSDictionary *result = @{
            @"iResCode":@(iResCode),
            @"iTags":iTags,
            @"seq":@(seq)
        };
        callback(result, NO);
    } seq:seq];
}

- (void)updateTags:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    NSSet *tempTags = [NSSet setWithArray:params[@"tags"]];
    NSInteger seq = [params[@"sequence"] intValue];
    [JPUSHService setTags:tempTags completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSDictionary *result = @{
            @"iResCode":@(iResCode),
            @"iTags":iTags,
            @"seq":@(seq)
        };
        callback(result, NO);
    } seq:seq];
}

- (void)deleteTag:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    NSSet *tempTags = [NSSet setWithArray:params[@"tags"]];
    NSInteger seq = [params[@"sequence"] intValue];
    [JPUSHService deleteTags:tempTags completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSDictionary *result = @{
            @"iResCode":@(iResCode),
            @"iTags":iTags,
            @"seq":@(seq)
        };
        callback(result, NO);
    } seq:seq];
}

- (void)deleteTags:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    NSInteger seq = [params[@"sequence"] intValue];
    [JPUSHService cleanTags:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSDictionary *result = @{
            @"iResCode":@(iResCode),
            @"iTags":iTags,
            @"seq":@(seq)
        };
        callback(result, NO);
    } seq:seq];
}


- (void)queryTags:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    NSInteger seq = [params[@"sequence"] intValue];
    [JPUSHService getAllTags:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSDictionary *result = @{
            @"iResCode":@(iResCode),
            @"iTags":iTags,
            @"seq":@(seq)
        };
        callback(result, NO);
    } seq:seq];
}

- (void)queryTag:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    NSString *tag = params[@"tag"];
    NSInteger seq = [params[@"sequence"] intValue];
    [JPUSHService validTag:tag completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq, BOOL isBind) {
        NSDictionary *result = @{
            @"iResCode":@(iResCode),
            @"iTags":iTags,
            @"seq":@(seq),
            @"isBind":@(isBind),
        };
        callback(result, NO);
    } seq:seq];
}

- (void)setAlias:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    NSString *alias = params[@"alias"];
    NSInteger seq = [params[@"sequence"] intValue];
    [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSDictionary *result = @{
            @"iResCode":@(iResCode),
            @"iAlias":iAlias,
            @"seq":@(seq)
        };
        callback(result, NO);
    } seq:seq];
}

- (void)deleteAlias:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    NSInteger seq = [params[@"sequence"] intValue];
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSDictionary *result = @{
            @"iResCode":@(iResCode),
            @"iAlias":iAlias,
            @"seq":@(seq)
        };
        callback(result, NO);
    } seq:seq];
}

- (void)queryAlias:(NSDictionary *)params callback:(UniModuleKeepAliveCallback)callback {
    NSInteger seq = [params[@"sequence"] intValue];
    [JPUSHService getAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSDictionary *result = @{
            @"iResCode":@(iResCode),
            @"iAlias":iAlias,
            @"seq":@(seq)
        };
        callback(result, NO);
    } seq:seq];
}


UNI_EXPORT_METHOD(@selector(setMaxGeofenceNumber:))
UNI_EXPORT_METHOD(@selector(deleteGeofence:))
UNI_EXPORT_METHOD(@selector(addDidEnterRegionListener:))
UNI_EXPORT_METHOD(@selector(addDidExitRegionListener:))


#pragma - 地理围栏
- (void)setMaxGeofenceNumber:(NSInteger)maxCount {
    [JPUSHService setGeofenecMaxCount:maxCount];
}

- (void)deleteGeofence:(NSString *)geofenceID {
    [JPUSHService removeGeofenceWithIdentifier:geofenceID];
}

- (void)addDidEnterRegionListener:(UniModuleKeepAliveCallback)callback {
    [JPushStore shared].didEnterRegionCallback = callback;
}

- (void)addDidExitRegionListener:(UniModuleKeepAliveCallback)callback {
    [JPushStore shared].didExitRegionCallback = callback;
}


@end
