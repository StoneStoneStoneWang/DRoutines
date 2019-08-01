//
//  WLPublishImpleViewController.h
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SBaseViewController.h"
#import "WLPublishImpl.h"
NS_ASSUME_NONNULL_BEGIN

@interface WLPublishImplViewController : SBaseViewController

+ (WLPublishImplViewController *)createPublishWithStyle:(WLPublishStyle )style andTag:(NSString *)tag andDelegate:(id<WLPublishDelegate>)delegate;

@property (nonatomic ,weak ,readonly) id<WLPublishDelegate> publishDelegate;

@end

NS_ASSUME_NONNULL_END
