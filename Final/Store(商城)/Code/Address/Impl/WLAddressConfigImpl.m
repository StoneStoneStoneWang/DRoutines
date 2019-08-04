//
//  WLAddressConfigImpl.m
//  DStoreFinalDemo
//
//  Created by three stone 王 on 2019/8/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLAddressConfigImpl.h"
#import "WLProjectConfig.h"

@implementation WLAddressConfigImpl

+ (instancetype)createAddress {
    
    return [self new];
}

@synthesize deleteIcon;
- (NSString *)deleteIcon {
    
    return @"";
}
@synthesize deSelectIcon;

- (NSString *)deSelectIcon {
    
    return @ReportNIcon;
}
@synthesize editIcon;

- (NSString *)editIcon {
    
    return @"";
}
@synthesize itemColor;

- (NSString *)itemColor {
    
    return @WL_P_Color;
}
@synthesize selectIcon;

- (NSString *)selectIcon {
    
    return @ReportSIcon;
}

@end
