//
//  WLStoreViewControllerImpl.m
//  青松文化
//
//  Created by three stone 王 on 2019/7/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLStoreViewControllerImpl.h"
@import WLBaseViewController;
#import "WLStoreConfigImpl.h"
#import "WLLoginImpl.h"
#import "UIViewController+Login.h"
#import "WLRootManager.h"
@import DStore;
@interface WLStoreViewControllerImpl ()

@property (nonatomic ,strong) WLStoreCatagoryBaseViewController *impl;

@end

@implementation WLStoreViewControllerImpl

+ (instancetype)createStore {
    
    return [self new];
}
- (void)s_addOwnSubViewController {
    
    WLStoreCatagoryBaseViewController *impl = [WLStoreCatagoryBaseViewController createStore:WLStoreStyleOne config:[WLStoreConfigImpl createStoreConfigImpl] headers:[WLRootManager shared].catas];
    
    self.impl = impl;
    
    [self.view addSubview:impl.view];
    
    [self addChildViewController:impl];
    
    impl.view.frame = self.view.bounds;
    
    self.title = @"商城";
}

@end
