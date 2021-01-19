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

@interface JPushStore : NSObject <JPUSHRegisterDelegate, JPUSHGeofenceDelegate>

+ (instancetype)shared;

//@property (nonatomic, strong) NSDictionary *launchOptions;

@property (nonatomic, copy) UniModuleKeepAliveCallback pushNotiCallback;
//@property (nonatomic, copy) UniModuleKeepAliveCallback openPushNotiCallback;
@property (nonatomic, copy) UniModuleKeepAliveCallback receiveCustomNotiCallback;

//@property (nonatomic, copy) UniModuleKeepAliveCallback receiveLocalNotiCallback;
//@property (nonatomic, copy) UniModuleKeepAliveCallback openLocalNotiCallback;

@property (nonatomic, copy) UniModuleKeepAliveCallback didEnterRegionCallback;
@property (nonatomic, copy) UniModuleKeepAliveCallback didExitRegionCallback;


@end

NS_ASSUME_NONNULL_END
