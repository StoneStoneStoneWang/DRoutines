//
//  WLStoreDetailImplViewController.h
//  DStoreFinalDemo
//
//  Created by three stone 王 on 2019/8/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface WLStoreDetailImplViewController : SBaseViewController

+ (instancetype)createStoreDetailImplWithStoreJson: (NSDictionary *)storeJson;

@end

NS_ASSUME_NONNULL_END
