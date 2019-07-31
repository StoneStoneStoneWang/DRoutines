//
//  WLModifyPwdImplViewController.m
//  DCircleFinalDemo
//
//  Created by three stone 王 on 2019/7/31.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLModifyPwdImplViewController.h"
#import "WLLoginImpl.h"
@import DLogin;
@interface WLModifyPwdImplViewController ()

@end

@implementation WLModifyPwdImplViewController

+ (instancetype)createModifyPwd {
    
    return [[self alloc] init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    WLModifyPwdBaseViewController *impl = [WLModifyPwdBaseViewController createPasswordWithStyle:WLLoginStyle_Global andConfig:[WLLoginImpl createLoginImpl]];
    
    [self.view addSubview:impl.view];
    
    [self addChildViewController:impl];
    
    impl.view.frame = self.view.bounds;
}

@end
