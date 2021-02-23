//
//  JPushStore.h
//  UniPluginJPush
//
//  Created by huangshuni on 2021/1/13.
//

#import <Foundation/Foundation.h>
#import "DCUniModule.h"
#import "JPUSHService.h"
#import <PushKit/PushKit.h>


 
#define infoConfig_JCore                   @"JCore"
#define infoConfig_JCore_APP_KEY           @"APP_KEY"
#define infoConfig_JCore_CHANNEL           @"CHANNEL"

#define infoConfig_JPush                   @"JPush"
#define infoConfig_JPush_ISPRODUCTION      @"ISPRODUCTION"
#define infoConfig_JPush_ADVERTISINGID     @"ADVERTISINGID"
#define infoConfig_JPush_DEFAULTINITJPUSH  @"DEFAULTINITJPUSH"


#define CONNECT_ENABLE          @"connectEnable"
#define NOTIFICATION_EVENTTYPE  @"notificationEventType"
#define NOTIFICATION_ARRIVED    @"notificationArrived"
#define NOTIFICATION_OPENED     @"notificationOpened"


NS_ASSUME_NONNULL_BEGIN

@interface JPushStore : NSObject <JPUSHRegisterDelegate, JPUSHGeofenceDelegate,JPushInMessageDelegate,PKPushRegistryDelegate>

@property (nonatomic, copy) UniModuleKeepAliveCallback connectEventCallback; // 连接状态
@property (nonatomic, copy) UniModuleKeepAliveCallback pushNotiCallback; // apns推送消息
@property (nonatomic, copy) UniModuleKeepAliveCallback receiveCustomNotiCallback; //自定义消息

@property (nonatomic, assign) BOOL allowedInMessagePop;// 是否允许应用内消息弹出
@property (nonatomic, copy) UniModuleKeepAliveCallback inMessageCallback; // 应用内消息(ad and 应用内通知)

@property (nonatomic, copy) UniModuleKeepAliveCallback localNotiCallback; // 本地通知

@property (nonatomic, copy) UniModuleKeepAliveCallback geofenceCallback;
@property (nonatomic, copy) UniModuleKeepAliveCallback voipCallback;

@property (nonatomic, copy) UniModuleKeepAliveCallback locationAuthorizationCallBack;

@property (nonatomic, copy) UniModuleKeepAliveCallback tagAliasCallBack;

@property (nonatomic, copy) UniModuleKeepAliveCallback addMobileNumberCallBack;

@property (nonatomic, strong) NSDictionary *launchOptions;

+ (instancetype)shared;

// 初始化jpush
- (void)initJPushService:(NSDictionary *)launchOptions;

- (void)addConnectEventObserver;

- (void)initVoipService;

- (void)handeleApnsCallback:(NSDictionary *)userInfo type:(NSString *)type;

- (void)handlerLocalNotiCallback:(NSDictionary *)userInfo type:(NSString *)type;

//
- (void)requestLocationAuthorization;

- (int)getLocationAuthorizationStatus;

- (BOOL)locationServicesEnabled;

@end

NS_ASSUME_NONNULL_END
