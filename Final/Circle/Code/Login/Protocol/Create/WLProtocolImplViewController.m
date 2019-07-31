//
//  WLProtocolImplViewController.m
//  DCircleFinalDemo
//
//  Created by three stone 王 on 2019/7/31.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLProtocolImplViewController.h"
#import "WLLoginImpl.h"
@import DLogin;
@interface WLProtocolImplViewController ()

@end

@implementation WLProtocolImplViewController

+ (instancetype)createProtocol {
    
    return [[self alloc] init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    WLProtocolBaseViewController *impl = [WLProtocolBaseViewController createProtocolWithStyle:WLLoginStyle_Global];
    
    [self.view addSubview:impl.view];
    
    [self addChildViewController:impl];
    
    impl.view.frame = self.view.bounds;
}

- (void)s_configNaviItem {
    
    self.title = @"隐私与协议";
}
@end
