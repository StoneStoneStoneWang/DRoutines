//
//  WLFindPwdImplViewController.m
//  DCircleFinalDemo
//
//  Created by three stone 王 on 2019/7/31.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLFindPwdImplViewController.h"
#import "WLLoginImpl.h"
@import DLogin;
@interface WLFindPwdImplViewController ()

@end

@implementation WLFindPwdImplViewController

+ (instancetype)createFindPwd {
    
    return [[self alloc] init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    WLPasswordBaseViewController *impl = [WLPasswordBaseViewController createPasswordWithStyle:WLLoginStyle_Global andConfig:[WLLoginImpl createLoginImpl]];
    
    [self.view addSubview:impl.view];
    
    [self addChildViewController:impl];
    
    impl.view.frame = self.view.bounds;
}
- (void)s_configNaviItem {
    
    self.title = @"忘记密码？";
}

@end
