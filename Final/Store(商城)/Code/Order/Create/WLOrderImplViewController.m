//
//  WLOrderImplViewController.m
//  DStoreFinalDemo
//
//  Created by three stone 王 on 2019/8/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLOrderImplViewController.h"
@import DStore;
@interface WLOrderImplViewController ()

@end

@implementation WLOrderImplViewController

+ (instancetype)createOrderImpl {
    
    return [self new];
}
- (void)s_addOwnSubViewController {
    
    WLOrderBaseViewController *impl = [WLOrderBaseViewController createOrder:@"订单"];
    
    [self.view addSubview:impl.view];
    
    [self addChildViewController:impl];
    
    impl.view.frame = self.view.bounds;
}

- (void)s_configNaviItem {
    
    self.title = @"我的订单";
}
@end
