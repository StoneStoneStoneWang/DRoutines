//
//  WLWelcomeViewController.h
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/4/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

@import UIKit;
@import DWelcome;
#import "SBaseViewController.h"
#import "WLWelComeImpl.h"
NS_ASSUME_NONNULL_BEGIN

@interface WLWelcomeImplViewController : SBaseViewController

+ (WLWelcomeImplViewController *)createWelcomeWithDelegate:(id <WLWelComeBaseDelegate>) delegate;

@end

NS_ASSUME_NONNULL_END
