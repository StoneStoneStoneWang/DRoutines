//
//  WLWelcomeViewController.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/4/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLWelcomeImplViewController.h"

@interface WLWelcomeImplViewController ()

@property (nonatomic ,weak) id <WLWelComeBaseDelegate> welcomeDelegate;
@end

@implementation WLWelcomeImplViewController

+ (WLWelcomeImplViewController *)createWelcomeWithDelegate:(id<WLWelComeBaseDelegate>)delegate {
    
    return [[WLWelcomeImplViewController alloc] initWithWelcomeDelegate:delegate];
}

- (instancetype)initWithWelcomeDelegate:(id<WLWelComeBaseDelegate>)delegate {
    
    if (self = [super init]) {
        
        self.welcomeDelegate = delegate;
    }
    return self;
}

- (void)s_addOwnSubViewController {
    
    WLWelComeBaseViewController *impl = [WLWelComeBaseViewController createWelcomeWithStyle:WLWelcomeStyleTwo andConfig:[WLWelComeImpl createWelcomeImpl] andDelegate:self.welcomeDelegate];
    
    [self.view addSubview:impl.view];
    
    [self addChildViewController:impl];
    
    impl.view.frame = self.view.bounds;
}


@end
