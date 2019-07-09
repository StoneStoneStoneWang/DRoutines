//
//  WLReportImplViewController.h
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/13.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBaseViewController.h"
@import SCircle;
NS_ASSUME_NONNULL_BEGIN

@interface WLReportImplViewController : SBaseViewController

+ (WLReportImplViewController *)createReportWithEncoded:(NSString *)encoded andUid:(NSString *)uid andStyle:(WLReportStyle )style;

@end

NS_ASSUME_NONNULL_END
