//
//  WLItemTypeBean.m
//  奥迪车友会
//
//  Created by three stone 王 on 2019/3/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLItemTypeBean.h"

@implementation WLItemTypeBean

+ (instancetype)itemBeanWithType:(WLItemType)type andTitle:(NSString *)title andIcon:(NSString *)icon {
    
    return [[self alloc] initWithType:type andTitle:title andIcon:icon];
}
- (instancetype)initWithType:(WLItemType)type andTitle:(NSString *)title andIcon:(NSString *)icon {
    
    if (self = [super init]) {
        
        self.type = type;
        
        self.title = title;
        
        self.icon = icon;
    }
    return self;
}

@end
