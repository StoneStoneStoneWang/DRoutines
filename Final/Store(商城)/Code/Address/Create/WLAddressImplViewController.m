//
//  WLAddressImplViewController.m
//  DStoreFinalDemo
//
//  Created by three stone 王 on 2019/8/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLAddressImplViewController.h"
#import "WLAddressConfigImpl.h"
@import DAddress;
@interface WLAddressImplViewController ()

@end

@implementation WLAddressImplViewController

+ (instancetype)createAddressImpl {
    
    return [self new];
}
- (void)s_addOwnSubViewController {
    
    WLAddressBaseViewController *impl = [WLAddressBaseViewController createAddress:WLAddressStyleList config:[WLAddressConfigImpl createAddress]];
    
    [self.view addSubview:impl.view];
    
    [self addChildViewController:impl];
    
    impl.view.frame = self.view.bounds;
}

- (void)s_configNaviItem {
    
    self.title = @"我的地址";
}

@end
