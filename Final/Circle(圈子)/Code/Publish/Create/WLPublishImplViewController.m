//
//  WLPublishImplViewController.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLPublishImplViewController.h"

@interface WLPublishImplViewController ()

@property (nonatomic ,weak ,readwrite) id<WLPublishDelegate> publishDelegate;

@property (nonatomic ,copy) NSString *tag;

@property (nonatomic ,assign) WLPublishStyle style;
@end

@implementation WLPublishImplViewController

+ (WLPublishImplViewController *)createPublishWithStyle:(WLPublishStyle )style andTag:(NSString *)tag andDelegate:(id<WLPublishDelegate>)delegate {
    
    return [[self alloc] initWithStyle:style andTag:tag andDelegate:delegate];
}

- (instancetype)initWithStyle:(WLPublishStyle )style andTag:(NSString *)tag andDelegate:(id<WLPublishDelegate>)delegate {
    
    if (self = [super init]) {
        
        self.publishDelegate = delegate;
        
        self.style = style;
        
        self.tag = tag;
    }
    return self;
}
- (void)s_configNaviItem {
    
    self.title = @"发布内容";
}
- (void)s_addOwnSubViewController {
    
    WLPublishTableBaseViewController *impl = [WLPublishTableBaseViewController createPublishWithTag:self.tag andStyle:self.style andConfig:[WLPublishImpl createPublishImpl] andDelegate:self.publishDelegate];
    
    [self.view addSubview:impl.view];
    
    [self addChildViewController:impl];
    
    impl.view.frame = self.view.bounds;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:impl.completeItem];
    
}

@end
