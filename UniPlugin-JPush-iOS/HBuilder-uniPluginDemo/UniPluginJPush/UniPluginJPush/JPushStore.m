//
//  JPushStore.m
//  UniPluginJPush
//
//  Created by huangshuni on 2021/1/13.
//

#import "JPushStore.h"

@implementation JPushStore

+ (instancetype)shared {
    static JPushStore *store;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[JPushStore alloc] init];
    });
    return store;
}

@end
