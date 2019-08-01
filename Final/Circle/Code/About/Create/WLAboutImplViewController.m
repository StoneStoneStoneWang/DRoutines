//
//  WLAboutImplViewController.m
//  DCircleFinalDemo
//
//  Created by three stone 王 on 2019/8/1.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLAboutImplViewController.h"
#import "WLAboutImpl.h"
@interface WLAboutImplViewController ()

@end

@implementation WLAboutImplViewController

+ (instancetype)createAbout {
    
    return [self new];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    WLAboutViewController *impl = [WLAboutViewController createAboutWithConfig:[WLAboutImpl createAboutImpl]];
    
    [self.view addSubview:impl.view];
    
    [self addChildViewController:impl];
    
    impl.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    
    self.title = @"关于我们";
}

@end
