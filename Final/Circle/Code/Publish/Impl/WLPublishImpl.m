//
//  WLPublishImpl.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLPublishImpl.h"

@implementation WLPublishImpl

+ (instancetype)createPublishImpl {
    
    return [self new];
}
@synthesize backIcon;
- (NSString *)backIcon {
    
    return @"返回";
}
@synthesize broadIcon;

- (NSString *)broadIcon {
    
    return @"播放";
}
@synthesize imageIcon;

- (NSString *)imageIcon {
    
    return @"";
}
@synthesize itemColor;

- (NSString *)itemColor {
    
    return @WL_P_Color;
}
@synthesize videoIcon;

- (NSString *)videoIcon {
    
    return @"";
}

@synthesize textIcon;

- (NSString *)textIcon {
    
    return @"";
}
@end
