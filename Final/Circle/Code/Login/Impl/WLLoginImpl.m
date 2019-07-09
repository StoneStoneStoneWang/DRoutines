//
//  WLLoginImpl.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/4/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLLoginImpl.h"

@implementation WLLoginImpl

+ (instancetype)createLoginImpl {
    
    return [self new];
}

@synthesize backIcon;

- (NSString *)backIcon {
    
    return @BackIcon;
}

@synthesize goIcon;

- (NSString *)goIcon {
    
    return @GoIcon;
}

@synthesize logo;

- (NSString *)logo {
    
    return @Logo;
}

@synthesize passwordIcon;

- (NSString *)passwordIcon {
    
    return @PWDIcon;
}
@synthesize passwordItemNIcon;

- (NSString *)passwordItemNIcon {
    
    return @PasswordItemNIcon;
}
- (NSString *)passwordItemSIcon {
    
    return @PasswordItemSIcon;
}

@synthesize passwordItemSIcon;

- (NSString *)phoneIcon {
    
    return @PhoneIcon;
}

@synthesize phoneIcon;
- (NSString *)vcodeIcon {
    
    return @VCodeIcon;
}
@synthesize vcodeIcon;

- (NSString *)itemColor {
    
    return @WL_P_Color ;
}

@synthesize itemColor;

@end
