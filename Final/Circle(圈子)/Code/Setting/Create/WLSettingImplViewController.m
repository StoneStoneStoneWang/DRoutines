//
//  WLSettingImplViewController.m
//  DCircleFinalDemo
//
//  Created by three stone 王 on 2019/8/1.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLSettingImplViewController.h"
#import "WLLoginImpl.h"
@import DLogin;
@import DSetting;
@interface WLSettingImplViewController ()

@end

@implementation WLSettingImplViewController

+ (instancetype)createSetting {
    
    return [self new];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    WLSettingViewController *impl = [WLSettingViewController createLoginWithLoginStyle:WLLoginStyle_Global andLoginConfig:[WLLoginImpl createLoginImpl]];
    
    [self.view addSubview:impl.view];
    
    [self addChildViewController:impl];
    
    impl.view.frame = self.view.bounds;
}
- (void)s_configNaviItem {
    
    self.title = @"设置";
}

@end
