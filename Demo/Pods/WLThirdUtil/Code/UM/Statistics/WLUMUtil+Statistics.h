//
//  WLUMUtil+Statistics.h
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/4/3.
//  Copyright © 2019 three stone 王. All rights reserved.
//


#import "WLUMUtil.h"
NS_ASSUME_NONNULL_BEGIN

@interface WLUMUtil (Statistics)

- (void)setScenarioType:(NSUInteger) stype;

- (void)mobEvent:(NSString *)event;

- (void)setCrashReportEnabled:(BOOL) enabled;

- (NSString *)z_utd;

- (void)setLogEnabled:(BOOL) enabled;

@end

NS_ASSUME_NONNULL_END
