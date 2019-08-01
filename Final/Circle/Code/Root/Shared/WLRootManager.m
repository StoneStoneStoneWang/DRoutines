//
//  WLRootManager.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/13.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLRootManager.h"
#import "WLMainBean.h"
@interface WLRootManager() 

@end

static WLRootManager *manager = nil;
@implementation WLRootManager
+ (instancetype)shared {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [self new];
    });
    return manager;
}

- (NSArray *)tabs {
    if (!_tabs) {
        
        //        WLMainBean *m1 = [WLMainBean mainBeanWithType:WLMainTypeHome andTitle:@"首页" andTag:@"" andNormalIcon:@"首页未" andSelectedIcon:@"首页选中"];
        //
        //        WLMainBean *m2 = [WLMainBean mainBeanWithType:WLMainTypeList andTitle:@"陶瓷" andTag:@"陶瓷" andNormalIcon:@"陶瓷未" andSelectedIcon:@"陶瓷选中"];
        
        WLMainBean *m3 = [WLMainBean mainBeanWithType:WLMainTypeProfile andTitle:@"个人中心" andTag:@"" andNormalIcon:@"个人中心未" andSelectedIcon:@"个人中心选中"];
        
        _tabs = @[m3];
    }
    
    return _tabs;
}


@end

