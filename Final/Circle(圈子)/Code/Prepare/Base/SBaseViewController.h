//
//  SBaseViewController.h
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/4/28.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mixed.h"
NS_ASSUME_NONNULL_BEGIN

@interface SBaseViewController : UIViewController

- (void)s_configNaviItem;

- (void)s_configOwnProperties;

- (void)s_addOwnSubViews;

- (void)s_configOwnSubViews;

- (void)s_configLoading;

- (void)s_configViewModel;

- (void)s_prepareData;

- (void)s_configAuto;

- (void)s_addOwnSubViewController;
@end

NS_ASSUME_NONNULL_END
