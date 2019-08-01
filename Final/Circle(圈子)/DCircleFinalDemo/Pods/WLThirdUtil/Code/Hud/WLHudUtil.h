//
//  WLHudUtil.h
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/4/3.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLHudUtil : NSObject

+ (void)configHud;

+ (void)showActivity;

+ (void)showInfo:(NSString *)msg;

+ (void)showWithStatus:(NSString *)msg;

+ (void)pop;

@end

NS_ASSUME_NONNULL_END
