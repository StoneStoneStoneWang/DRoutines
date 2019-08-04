//
//  WLStoreDetailImplViewController.m
//  DStoreFinalDemo
//
//  Created by three stone 王 on 2019/8/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLStoreDetailImplViewController.h"
#import "WLStoreConfigImpl.h"
@import DStore;

@interface WLStoreDetailImplViewController ()

@property (nonatomic ,strong) NSDictionary *storeJson;

@end

@implementation WLStoreDetailImplViewController

+ (instancetype)createStoreDetailImplWithStoreJson:(NSDictionary *)storeJson {
    
    return [[self alloc] initWithStoreJson:storeJson];
}
- (instancetype)initWithStoreJson:(NSDictionary *)storeJson {
    
    if (self = [super init]) {
        
        self.storeJson = storeJson;
    }
    return self;
}
- (void)s_addOwnSubViewController {
    
    WLStoreDetailBaseViewController *impl = [WLStoreDetailBaseViewController createStoreDetailWithStyle:WLStoreDetailStyleOne andConfig:[WLStoreConfigImpl createStoreConfigImpl] andStoreJson:self.storeJson];
    
    [self.view addSubview:impl.view];
    
    [self addChildViewController:impl];
    
    impl.view.frame = self.view.bounds;
}

- (void)s_configNaviItem {
    
    self.title = @"商品详情";
}

@end
