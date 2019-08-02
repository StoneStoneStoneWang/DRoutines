//
//  WLCircleDetailImplViewController.h
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/13.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBaseViewController.h"
@import DCircle;
@import DProfile;
@import DLogin;
NS_ASSUME_NONNULL_BEGIN

@interface WLCircleDetailImplViewController : SBaseViewController

+ (WLCircleDetailImplViewController *)createCircleDetailImplWithStyle:(WLCircleDetailStyle )style andContentStyle:(WLContentStyle )contentStyle andCommentStyle:(WLCommentStyle )commentStyle andLoginStyle:(WLLoginStyle )loginStyle andUid:(NSString *)uid andEncoded:(NSString *)encoded andCircleJson:(NSDictionary *)circleJson;

@end

NS_ASSUME_NONNULL_END
