//
//  UIViewController+Login.h
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/4/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLLoginImpl.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Login)

- (BOOL)checkLoginImpl;

- (BOOL)checkLoginAndIsGoLoginImpl;

@end

NS_ASSUME_NONNULL_END
