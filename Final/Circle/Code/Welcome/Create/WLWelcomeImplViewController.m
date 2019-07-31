//
//  WLWelcomeViewController.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/4/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLWelcomeImplViewController.h"

@interface WLWelcomeImplViewController ()

@end

@implementation WLWelcomeImplViewController

+ (WLWelcomeImplViewController *)createWelcome {
    
    return [[WLWelcomeImplViewController alloc] init];
}

- (void)s_addOwnSubViewController {
    
    WLWelComeBaseViewController *impl = [WLWelComeBaseViewController createWelcomeWithStyle:WLWelcomeStyleTwo andConfig:[WLWelComeImpl createWelcomeImpl]];
    
    [self.view addSubview:impl.view];
    
    [self addChildViewController:impl];
    
    impl.view.frame = self.view.bounds;
}


@end
