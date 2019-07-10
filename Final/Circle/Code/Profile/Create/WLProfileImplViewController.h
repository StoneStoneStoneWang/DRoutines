//
//  WLProfileImplViewController.h
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/4/28.
//  Copyright © 2019 three stone 王. All rights reserved.
//

@import UIKit;
#import "SBaseViewController.h"
@import DProfile;
@import DLogin;
NS_ASSUME_NONNULL_BEGIN

@interface WLProfileImplViewController : SBaseViewController

+ (WLProfileImplViewController *)createProfileWithLoginStyle:(WLLoginStyle)loginStyle andCDelegate:(id<WLProfileViewControllerMyPubDelegate>) cDelegate;

@end

NS_ASSUME_NONNULL_END
