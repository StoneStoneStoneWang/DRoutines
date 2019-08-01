//
//  WLBlackImplViewController.m
//  DCircleFinalDemo
//
//  Created by three stone 王 on 2019/8/1.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLBlackImplViewController.h"
#import "WLBlackImpl.h"
@import DPerson;
@interface WLBlackImplViewController ()

@end

@implementation WLBlackImplViewController

+ (instancetype)createBlack {
    
    return [self new];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    WLBlackListBaseViewController *impl = [WLBlackListBaseViewController createBlackListWithStyle:WLBlackListStyleOne andConfig:[WLBlackImpl createBlackImpl]];
    
    [self.view addSubview:impl.view];
    
    [self addChildViewController:impl];
    
    impl.view.frame = self.view.bounds;
}
- (void)s_configNaviItem {
    
    self.title = @"黑名单";
}

@end
