//
//  WLStoreConfigImpl.m
//  DStoreFinalDemo
//
//  Created by three stone 王 on 2019/8/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLStoreConfigImpl.h"
#import "WLProjectConfig.h"
@implementation WLStoreConfigImpl

@synthesize backIcon;

+ (instancetype)createStoreConfigImpl {
    
    return [self new];
}
- (NSString *)backIcon {
    
    return @BackIcon;
}
@synthesize itemColor;
- (NSString *)itemColor {
    
    return @WL_P_Color;
}
@end
