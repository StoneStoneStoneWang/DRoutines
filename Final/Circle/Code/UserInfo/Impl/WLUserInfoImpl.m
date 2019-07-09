//
//  WLUserInfoImpl.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/4/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLUserInfoImpl.h"

@implementation WLUserInfoImpl

+ (instancetype)createUserInfoImpl {
    
    return [self new];
}
@synthesize backIcon;
- (NSString *)backIcon {
    
    return @BackIcon;
}
@synthesize defaultIcon;

- (NSString *)defaultIcon {
    
    return @DefaultIcon;
}

@synthesize itemColor;

- (NSString *)itemColor {
    
    return @WL_P_Color;
}

@synthesize logo;
- (NSString *)logo {
    
    return @Logo;
}
@end
