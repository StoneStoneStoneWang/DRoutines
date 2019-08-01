//
//  WLCircleImplViewController.h
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/13.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>
@import DCircle;
@import DProfile;
@import DLogin;

#import "SBaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface WLCircleImplViewController : SBaseViewController

+ (WLCircleImplViewController *)createCircleImplWithTag:(NSString *)tag andStyle:(WLCircleStyle )style andLoginStyle:(WLLoginStyle )loginStyle andDelegate:(id <WLCircleDelegate>) circleDelegate andIsMy:(BOOL )isMy ;

@end

NS_ASSUME_NONNULL_END
