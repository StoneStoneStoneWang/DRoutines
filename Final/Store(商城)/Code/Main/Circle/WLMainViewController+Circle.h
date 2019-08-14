//
//  WLMainViewController+Circle.h
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLMainViewController.h"
//#import "WLCircleDetailImplViewController.h"
//#import "WLCircleImplViewController.h"
//#import "WLProfileImplViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface WLMainViewController (Circle)<UITabBarControllerDelegate>

+ (WLMainViewController *)createCircleTab;

@end

NS_ASSUME_NONNULL_END
