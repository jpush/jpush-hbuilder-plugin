//
//  JPushStore.m
//  UniPluginJPush
//
//  Created by huangshuni on 2021/1/13.
//

#import "JPushStore.h"
#import <UserNotifications/UserNotifications.h>

@implementation JPushStore

+ (instancetype)shared {
    static JPushStore *store;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[JPushStore alloc] init];
    });
    return store;
}



#ifdef __IPHONE_10_0
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationAuthorization:(JPAuthorizationStatus)status withInfo:(NSDictionary *)info {
    NSLog(@"receive notification authorization status:%lu, info:%@", status, info);
}

// 应用在前台 推送消息过来 会触发 需要回调completionHandler才能显示
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    NSDictionary *result = @{
        @"messageID":notification.request.identifier?:@"",
        @"title":notification.request.content.title?:@"",
        @"content":notification.request.content.body?:@"",
        @"extras":notification.request.content.userInfo?:@{},
        @"notificationEventType":@"notificationArrived",
    };
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //远程推送
        [JPUSHService handleRemoteNotification:userInfo];
        if ([JPushStore shared].pushNotiCallback) {
            [JPushStore shared].pushNotiCallback(result, YES);
        }
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
    NSDictionary *result = @{
        @"messageID":response.notification.request.identifier?:@"",
        @"title":response.notification.request.content.title?:@"",
        @"content":response.notification.request.content.body?:@"",
        @"extras":response.notification.request.content.userInfo?:@{},
        @"notificationEventType":@"notificationOpened",
    };
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        if ([JPushStore shared].pushNotiCallback) {
            [JPushStore shared].pushNotiCallback(result, YES);
        }
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
            @"msg": error.description
        };
    }else {
        result = @{
            @"code": @(0),
            @"geofenceId":geofenceId,
            @"userInfo":userInfo,
        };
    }
    [JPushStore shared].didEnterRegionCallback(result, YES);
}

- (void)jpushGeofenceIdentifer:(NSString *)geofenceId didExitRegion:(NSDictionary *)userInfo error:(NSError *)error {
    NSDictionary *result;
    if (error) {
        result = @{
            @"code": @(error.code),
            @"msg": error.description
        };
    }else {
        result = @{
            @"code": @(0),
            @"geofenceId":geofenceId,
            @"userInfo":userInfo,
        };
    }
    [JPushStore shared].didExitRegionCallback(result, YES);
}

@end
