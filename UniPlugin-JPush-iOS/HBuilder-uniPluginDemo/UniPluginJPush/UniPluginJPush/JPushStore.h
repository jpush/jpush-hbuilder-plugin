//
//  JPushStore.h
//  UniPluginJPush
//
//  Created by huangshuni on 2021/1/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JPushStore : NSObject

+ (instancetype)shared;

@property (nonatomic, strong) NSDictionary *options;

@end

NS_ASSUME_NONNULL_END
