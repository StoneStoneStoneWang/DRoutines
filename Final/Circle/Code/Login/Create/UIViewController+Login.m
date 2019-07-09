//
//  UIViewController+Login.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/4/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "UIViewController+Login.h"

@implementation UIViewController (Login)

- (BOOL)checkLoginImpl {
    
    return [self checkLoginAndIsGoLoginWithStyle:WLLoginStyle_Global andConfig:[WLLoginImpl createLoginImpl]];
}

- (BOOL)checkLoginAndIsGoLoginImpl {
    
    return [self checkLoginWithStyle:WLLoginStyle_Global andConfig:[WLLoginImpl createLoginImpl]];
}

@end
