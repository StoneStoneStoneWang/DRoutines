//
//  SBaseViewController.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/4/28.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "SBaseViewController.h"
@import WLToolsKit;
@interface SBaseViewController ()

@end

@implementation SBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self s_configNaviItem];
    
    [self s_configOwnProperties];
    
    [self s_addOwnSubViews];
    
    [self s_configOwnSubViews];
    
    [self s_configLoading];
    
    [self s_configViewModel];
    
    [self s_prepareData];
    
    [self s_configAuto];
    
    [self s_addOwnSubViewController];
}


- (void)s_configNaviItem { }
- (void)s_addOwnSubViews { }

- (void)s_configOwnSubViews {}

- (void)s_configLoading {}

- (void)s_configViewModel {}

- (void)s_prepareData {}

- (void)s_configAuto { }

- (void)s_addOwnSubViewController {}

- (void)s_configOwnProperties {
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1"];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

@end
