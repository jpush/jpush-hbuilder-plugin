//
//  JPushModule.m
//  UniPluginJPush
//
//  Created by huangshuni on 2021/1/12.
//

#import "JPushModule.h"
#import "JPUSHService.h"
#import "JPushStore.h"

@implementation JPushModule

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(printSth:))

- (void)printSth:(WXModuleKeepAliveCallback)callback {
    NSLog(@"hello sn");
    
    NSDictionary *data = [JPushStore shared].options;
    callback(data,NO);
}



@end
