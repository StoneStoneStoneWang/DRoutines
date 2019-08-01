//
//  WLUserInfoImplViewController.m
//  DCircleFinalDemo
//
//  Created by three stone 王 on 2019/8/1.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLUserInfoImplViewController.h"
#import "WLUserInfoImpl.h"
@interface WLUserInfoImplViewController ()

@end

@implementation WLUserInfoImplViewController

+ (instancetype)createUserInfo {
    
    return [self new];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    WLUserInfoViewController *impl = [WLUserInfoViewController createUserInfoWithConfig:[WLUserInfoImpl createUserInfoImpl]];
    
    [self.view addSubview:impl.view];
    
    [self addChildViewController:impl];
    
    impl.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    
    self.title = @"我的资料";
}

@end
