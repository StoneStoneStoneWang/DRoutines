//
//  WLOrderConfirmImplViewController.m
//  DStoreFinalDemo
//
//  Created by three stone 王 on 2019/8/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLOrderConfirmImplViewController.h"
#import "WLStoreConfigImpl.h"
#import "WLAddressConfigImpl.h"
@import DStore;

@interface WLOrderConfirmImplViewController ()

@property (nonatomic ,strong) NSDictionary *storeJson;

@end

@implementation WLOrderConfirmImplViewController

+ (instancetype)createOrderConfirmImplWithStoreJson:(NSDictionary *)storeJson {
    
    return [[self alloc] initWithStoreJson:storeJson];
}
- (instancetype)initWithStoreJson:(NSDictionary *)storeJson {
    
    if (self = [super init]) {
        
        self.storeJson = storeJson;
    }
    return self;
}
- (void)s_addOwnSubViewController {
    
    WLStoreOrderConfirmBaseViewController *impl = [WLStoreOrderConfirmBaseViewController createStoreOrder:[WLStoreConfigImpl createStoreConfigImpl] addressConfig:[WLAddressConfigImpl createAddress] storeJson:self.storeJson];
    
    [self.view addSubview:impl.view];
    
    [self addChildViewController:impl];
    
    impl.view.frame = self.view.bounds;
}

- (void)s_configNaviItem {
    
    self.title = @"确认订单";
}

@end
