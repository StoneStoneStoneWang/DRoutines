//
//  WLFocusImpl.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/4/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLFocusImpl.h"

@implementation WLFocusImpl

+ (instancetype)createFocusImpl {
    
    return [self new];
}
@synthesize defaultIcon;

- (NSString *)defaultIcon {
    
    return @DefaultIcon;
}

@synthesize itemColor;

- (NSString *)itemColor {
    
    return @WL_P_Color;
}

@end
