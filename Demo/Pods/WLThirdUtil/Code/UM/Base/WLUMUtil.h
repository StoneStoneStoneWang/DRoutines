//
//  WLUMUtil.h
//  WLUMStatistics
//
//  Created by three stone 王 on 2019/1/5.
//  Copyright © 2019年 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLUMUtil : NSObject

+ (instancetype)shared;

- (void)regUMAppKey:(NSString *)appkey;

@property (nonatomic , copy, readonly) NSString *appkey;

- (BOOL )checkAppKey;


@end

NS_ASSUME_NONNULL_END
