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
        
        WLMainBean *m1 = [WLMainBean mainBeanWithType:WLMainTypeHome andTitle:@"溢米商城" andTag:@"" andNormalIcon:@"首页未" andSelectedIcon:@"首页选中"];
        
        WLMainBean *m2 = [WLMainBean mainBeanWithType:WLMainTypeCart andTitle:@"购物车" andTag:@"购物车" andNormalIcon:@"购物车未" andSelectedIcon:@"购物车选中"];
        
        WLMainBean *m3 = [WLMainBean mainBeanWithType:WLMainTypeProfile andTitle:@"个人中心" andTag:@"" andNormalIcon:@"个人中心未" andSelectedIcon:@"个人中心选中"];
        
        WLMainBean *m4 = [WLMainBean mainBeanWithType:WLMainTypeStore andTitle:@"商城" andTag:@"" andNormalIcon:@"商城未" andSelectedIcon:@"商城选中"];
        
        _tabs = @[m1,m4,m2,m3];
    }
    
    return _tabs;
}

- (NSMutableArray *)catas {
    if (!_catas) {
        
        _catas = [@[@{@"title": @"鱼食",@"isSelected":@(true),@"tag":@"鱼食"},
                   @{@"title": @"观赏鱼",@"isSelected":@(false),@"tag":@"观赏鱼"},
                   @{@"title": @"热带鱼",@"isSelected":@(false),@"tag":@"热带鱼"},
                   @{@"title": @"鱼具(养)",@"isSelected":@(false),@"tag":@"鱼具(养)"},
                   @{@"title": @"渔具(钓)",@"isSelected":@(false),@"tag":@"渔具(钓)"}] mutableCopy];
    }
    return _catas;
}

@end

