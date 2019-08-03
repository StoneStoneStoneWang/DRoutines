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

+ (WLCircleImplViewController *)createCircleImplWithTag:(NSString *)tag andStyle:(WLCircleStyle )style andLoginStyle:(WLLoginStyle )loginStyle andIsMy:(BOOL )isMy ;

- (void)onPublishSucc:(UIViewController * _Nonnull)from pubBean:(NSDictionary<NSString *,id> * _Nonnull)pubBean;

@end

NS_ASSUME_NONNULL_END
