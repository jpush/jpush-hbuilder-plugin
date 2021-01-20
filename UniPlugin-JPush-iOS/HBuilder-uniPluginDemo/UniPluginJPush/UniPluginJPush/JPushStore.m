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



#pragma -
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


- (void)initVoipService{
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    PKPushRegistry *voipRegistry = [[PKPushRegistry alloc] initWithQueue:mainQueue];
    voipRegistry.delegate = self;
    // Set the push type to VoIP
    voipRegistry.desiredPushTypes = [NSSet setWithObject:PKPushTypeVoIP];
}

#pragma mark - PKPushRegistryDelegate
//系统返回VOIP token,提交到极光服务器
- (void)JPushRegistry:(PKPushRegistry *)registry didUpdatePushCredentials:(PKPushCredentials *)pushCredentials forType:(PKPushType)type{
  [JPUSHService registerVoipToken:pushCredentials.token];
}

- (void)pushRegistry:(PKPushRegistry *)registry didReceiveIncomingPushWithPayload:(PKPushPayload *)payload forType:(PKPushType)type{
  [JPUSHService handleVoipNotification:payload.dictionaryPayload];
    
}

/**
 * 接收到Voip推送信息，并向极光服务器上报（iOS 11.0 以后）
 */
- (void)pushRegistry:(PKPushRegistry *)registry didReceiveIncomingPushWithPayload:(PKPushPayload *)payload forType:(PKPushType)type withCompletionHandler:(void(^)(void))completion{
  [JPUSHService handleVoipNotification:payload.dictionaryPayload];
  
}


@end
