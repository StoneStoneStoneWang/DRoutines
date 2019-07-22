//
//  WLUMUtil+Statistics.m
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/4/3.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLUMUtil+Statistics.h"
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
#import <UTDID/UTDevice.h>

@implementation WLUMUtil (Statistics)


- (void)setScenarioType:(NSUInteger)stype {
    
    if ([self checkAppKey]) [MobClick setScenarioType:stype];
}
- (void)mobEvent:(NSString *)event {
    
    if ([self checkAppKey]) [MobClick event:event];
}
- (void)setCrashReportEnabled:(BOOL)enabled {
    
    if ([self checkAppKey]) [MobClick setCrashReportEnabled:enabled];
}

- (void)setLogEnabled:(BOOL) enabled{
    
    if ([self checkAppKey]) [UMConfigure setLogEnabled:enabled];
}
- (NSString *)z_utd {
    
    return [UTDevice utdid];
}

@end
