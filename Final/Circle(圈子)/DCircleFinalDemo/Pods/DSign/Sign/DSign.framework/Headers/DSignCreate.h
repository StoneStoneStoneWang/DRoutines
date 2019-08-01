//
//  DSign.h
//  DSign
//
//  Created by three stone 王 on 2019/7/2.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSignCreate : NSObject
// 传入所有请求参数
+ (NSString *)createSign:(NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END
