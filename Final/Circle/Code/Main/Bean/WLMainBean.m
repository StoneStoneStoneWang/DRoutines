//
//  WLMainBean.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/13.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLMainBean.h"

static NSArray *result;

@implementation WLMainBean
+ (void)setTags:(NSMutableArray *)tags {
    result = tags;
}
+ (instancetype)mainBeanWithType:(WLMainType )type andTitle:(NSString *)title andTag:(NSString *)tag andNormalIcon:(NSString *)normalIcon andSelectedIcon:(NSString *)selectedIcon {
    
    return [[self alloc] initWithType:type andTitle:title andTag:tag andNormalIcon:normalIcon andSelectedIcon:selectedIcon];
}

- (instancetype)initWithType:(WLMainType )type andTitle:(NSString *)title andTag:(NSString *)tag andNormalIcon:(NSString *)normalIcon andSelectedIcon:(NSString *)selectedIcon {
    
    if (self = [super init]) {
        
        self.type = type;
        
        self.title = title;
        
        self.tag = tag;
        
        self.normalIcon = normalIcon;
        
        self.selectedIcon = selectedIcon;
    }
    return self;
}

// 圈子类型的
+ (NSMutableArray *)tags {
    
    if (!result) {
        
#pragma mark - TODO
        WLMainBean *m1 = [WLMainBean mainBeanWithType:WLMainTypeHome andTitle:@"首页" andTag:@"" andNormalIcon:@"首页灰" andSelectedIcon:@"首页蓝"];

        WLMainBean *m2 = [WLMainBean mainBeanWithType:WLMainTypeList andTitle:@"图文" andTag:@"图文" andNormalIcon:@"图文" andSelectedIcon:@"龙猫圈蓝"];

        WLMainBean *m3 = [WLMainBean mainBeanWithType:WLMainTypeList andTitle:@"视频" andTag:@"视频" andNormalIcon:@"图文" andSelectedIcon:@"龙猫圈蓝"];
//        WLMainBean *m3 = [WLMainBean mainBeanWithType:WLMainTypeProfile andTitle:@"我的" andTag:@"" andNormalIcon:@"我的灰" andSelectedIcon:@"我的蓝"];

        result = [@[m1,m2,m3] mutableCopy];
    }
    
    return [result mutableCopy];
}

@end

