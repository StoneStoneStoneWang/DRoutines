//
//  WLReportImpl.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/13.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLReportImpl.h"

@implementation WLReportImpl

+ (instancetype)createReportImpl {
    
    return [self new];
}
@synthesize itemColor;

- (NSString *)itemColor {
    
    return @WL_P_Color;
}
@synthesize normalIcon;
- (NSString *)normalIcon {
    
    return @ReportNIcon;
}

@synthesize selectedIcon;

- (NSString *)selectedIcon {
    
    return @ReportSIcon;
}
@end
