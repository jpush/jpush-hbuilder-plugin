//
//  JPushStore.h
//  UniPluginJPush
//
//  Created by huangshuni on 2021/1/13.
//

#import <Foundation/Foundation.h>
#import "DCUniModule.h"
#import "JPUSHService.h"

NS_ASSUME_NONNULL_BEGIN

@interface JPushStore : NSObject <JPUSHRegisterDelegate, JPUSHGeofenceDelegate,JPushInMessageDelegate>

+ (instancetype)shared;


@property (nonatomic, copy) UniModuleKeepAliveCallback pushNotiCallback; // apns推送消息
@property (nonatomic, copy) UniModuleKeepAliveCallback receiveCustomNotiCallback; //自定义消息

@property (nonatomic, assign) BOOL allowedInMessagePop;// 是否允许应用内消息弹出
@property (nonatomic, copy) UniModuleKeepAliveCallback inMessageCallback; // 应用内消息(ad and 应用内通知)

//@property (nonatomic, copy) UniModuleKeepAliveCallback receiveLocalNotiCallback;
//@property (nonatomic, copy) UniModuleKeepAliveCallback openLocalNotiCallback;

@property (nonatomic, copy) UniModuleKeepAliveCallback didEnterRegionCallback;
@property (nonatomic, copy) UniModuleKeepAliveCallback didExitRegionCallback;


@end

NS_ASSUME_NONNULL_END
