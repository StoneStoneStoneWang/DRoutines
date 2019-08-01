//
//  WLFocusImplViewController.m
//  DCircleFinalDemo
//
//  Created by three stone 王 on 2019/8/1.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLFocusImplViewController.h"
#import "WLFocusImpl.h"
@import DPerson;
@interface WLFocusImplViewController ()

@end

@implementation WLFocusImplViewController

+ (instancetype)createFocus {
    
    return [self new];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    WLFocusBaseViewController *impl = [WLFocusBaseViewController createFocusWithStyle:WLFocusListStyleOne andConfig:[WLFocusImpl createFocusImpl]];
    
    [self.view addSubview:impl.view];
    
    [self addChildViewController:impl];
    
    impl.view.frame = self.view.bounds;
    
}

- (void)s_configNaviItem {
    
    self.title = @"我的关注";
}
@end
