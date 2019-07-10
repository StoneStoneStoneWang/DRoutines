//
//  WLHudUtil.m
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/4/3.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLHudUtil.h"
#import "SVProgressHUD.h"
@implementation WLHudUtil

+ (void)configHud {
    
    [SVProgressHUD setDefaultStyle:(SVProgressHUDStyleDark)];
    
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    
    [SVProgressHUD setDefaultAnimationType:(SVProgressHUDAnimationTypeFlat)];
    
    [SVProgressHUD setDefaultMaskType:(SVProgressHUDMaskTypeClear)];
}
+ (void)showActivity {
    
    [SVProgressHUD show];
}
+ (void)showInfo:(NSString *)msg {
    
    [SVProgressHUD showInfoWithStatus:msg];
}
+ (void)showWithStatus:(NSString *)msg {
    
    [SVProgressHUD showWithStatus:msg];
    
}
+ (void)pop {
    
    [SVProgressHUD popActivity];
}
@end
