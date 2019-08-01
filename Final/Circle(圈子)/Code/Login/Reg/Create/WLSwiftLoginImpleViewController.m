//
//  WLSwiftLoginImpleViewController.m
//  DCircleFinalDemo
//
//  Created by three stone 王 on 2019/7/31.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLSwiftLoginImpleViewController.h"
#import "WLLoginImpl.h"
@import DLogin;

@implementation WLSwiftLoginImpleViewController

+ (instancetype)createSwiftLogin {
    
    return [[WLSwiftLoginImpleViewController alloc]init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WLSwiftLoginBaseViewController *impl = [WLSwiftLoginBaseViewController createSwiftLoginWithStyle:WLLoginStyle_Global andConfig:[WLLoginImpl createLoginImpl]];
    
    [self.view addSubview:impl.view];
    
    [self addChildViewController:impl];
    
    impl.view.frame = self.view.bounds;
    
}
- (void)s_configNaviItem {
    
    self.title = @"注册/登陆";
}
@end
