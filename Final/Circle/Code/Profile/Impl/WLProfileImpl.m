//
//  WLProfileImpl.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/4/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLProfileImpl.h"

@implementation WLProfileImpl

+ (instancetype)createProfileImpl {
    
    return [self new];
}

@synthesize aboutIcon;
// 关于我们图片
- (NSString *)aboutIcon {
    
    return @AboutIcon;
}

@synthesize contactUsIcon;

- (NSString *)contactUsIcon {
    
    return @ContactUsIcon;
}
@synthesize focusIcon;

- (NSString *)focusIcon {
    
    return @FocusIcon;
}

@synthesize defaultIcon;

- (NSString *)defaultIcon {
    
    return @DefaultIcon;
}

@synthesize itemColor;

- (NSString *)itemColor {
    
    return @WL_P_Color;
}
@synthesize phoneNum;

- (NSString *)phoneNum {
    
    return @WLPhoneNumber;
}
@synthesize logo;

- (NSString *)logo {
    
    return @Logo;
}

@synthesize pravicyIcon;

- (NSString *)pravicyIcon {
    
    return @PravicyIcon;
}
@synthesize userInfoIcon;

- (NSString *)userInfoIcon {
    
    return @UserInfoIcon;
}
@synthesize settingIcon;

- (NSString *)settingIcon {
    
    return @SettingIcon;
}

@synthesize circleIcon;

- (NSString *)circleIcon {
    
    return @CircleIcon;
}
@synthesize ciecleName;

- (NSString *)ciecleName {
    
    return @CircleTitle;
}
@end


