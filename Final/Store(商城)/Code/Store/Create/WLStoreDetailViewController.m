////
////  WLStoreDetailViewController.m
////  青松文化
////
////  Created by three stone 王 on 2019/7/19.
////  Copyright © 2019 three stone 王. All rights reserved.
////
//
//#import "WLStoreDetailViewController.h"
//#import "WLLoginImpl.h"
//#import "WLProjectConfig.h"
//@interface WLStoreDetailViewController ()
//
//@property (nonatomic ,strong) NSMutableDictionary *storeJson;
//@end
//
//@implementation WLStoreDetailViewController
//
//- (NSMutableDictionary *)storeJson {
//
//    if (!_storeJson) {
//
//        _storeJson = [NSMutableDictionary dictionary];
//    }
//    return _storeJson;
//}
//+ (instancetype)createStoreDetailWithStoreJson:(NSDictionary<NSString *,id> *)storeJson {
//
//    return [[self alloc] initWithStoreJson:storeJson];
//}
//- (instancetype)initWithStoreJson:(NSDictionary<NSString *,id> *)storeJson {
//
//    if (self = [super init]) {
//
//        [self.storeJson addEntriesFromDictionary:storeJson];
//    }
//    return self;
//}
//- (void)s_addOwnSubViewController {
//
//    WLStoreDetailBaseViewController *impl = [WLStoreDetailBaseViewController createStoreDetail:WLStoreDetailStyleOne config:[WLStoreConfigImpl new] addressConfig:[WLAddressConfigImpl new] loginStyle:WLLoginStyle_Global loginConfig:[WLLoginImpl createLoginImpl] storeJson:self.storeJson];
//
//    [self.view addSubview:impl.view];
//
//    [self addChildViewController:impl];
//
//    impl.view.frame = self.view.bounds;
//
//    self.title = @"商品详情";
//
//#if TARGET_OS_IPHONE  //模拟器
//
//#if DEBUG
////    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:impl.moreItem];
//#else
//
//#endif
//
//#endif
//
//
//}
//
//@end
