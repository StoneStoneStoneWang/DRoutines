//
//  WLAboutImpl.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/4/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLAboutImpl.h"

@implementation WLAboutImpl

+ (instancetype)createAboutImpl {
    
    return [self new];
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
