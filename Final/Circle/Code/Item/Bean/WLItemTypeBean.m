//
//  WLItemTypeBean.m
//  奥迪车友会
//
//  Created by three stone 王 on 2019/3/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLItemTypeBean.h"
static NSArray *result;
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
+ (void)setItemTypes:(NSMutableArray *)itemTypes {
    
    result = itemTypes;
}

#pragma mark - TODO
+ (NSMutableArray *)itemTypes {
    
    if (!result) {
        
        WLItemTypeBean *i1 = [WLItemTypeBean itemBeanWithType:WLItemTypeTip andTitle:@"笔" andIcon:@"笔"];

        WLItemTypeBean *i2 = [WLItemTypeBean itemBeanWithType:WLItemTypeJob1 andTitle:@"墨" andIcon:@"墨"];

        WLItemTypeBean *i3 = [WLItemTypeBean itemBeanWithType:WLItemTypeJob2 andTitle:@"纸" andIcon:@"纸"];

        WLItemTypeBean *i4 = [WLItemTypeBean itemBeanWithType:WLItemTypeJob3 andTitle:@"砚" andIcon:@"砚"];
        
        return [@[i1,i2,i3,i4] mutableCopy];
    }
    
    return [result mutableCopy];
}

@end
