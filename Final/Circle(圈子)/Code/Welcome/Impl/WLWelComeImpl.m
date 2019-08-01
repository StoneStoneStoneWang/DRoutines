//
//  WLWelComeImpl.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/4/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLWelComeImpl.h"

@implementation WLWelComeImpl

+ (instancetype)createWelcomeImpl {
    
    return [self new];
}
@synthesize itemColor;

@synthesize welcomeImgs;

- (NSString *)itemColor {
    
    return @WL_P_Color;
}
- (NSArray<NSString *> *)welcomeImgs {
    
    return @[@"画板1",@"画板2"];
}

@end
