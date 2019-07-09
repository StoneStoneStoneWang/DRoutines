//
//  WLReportImplViewController.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/13.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLReportImplViewController.h"
#import "WLReportImpl.h"
@interface WLReportImplViewController()

@property (nonatomic ,copy) NSString *uid;

@property (nonatomic ,copy) NSString *encoded;

@property (nonatomic ,assign) WLReportStyle style;

@end

@implementation WLReportImplViewController

+ (WLReportImplViewController *)createReportWithEncoded:(NSString *)encoded andUid:(NSString *)uid andStyle:(WLReportStyle )style {
    
    return [[self alloc] initWithStyle: style andUid:uid andEncoded:encoded];
}

- (instancetype)initWithStyle:(WLReportStyle )style andUid:(NSString *)uid andEncoded:(NSString *)encoded {
    
    if (self = [super init]) {
        
        self.style = style;
        
        self.uid = uid;
        
        self.uid = encoded;
    }
    return self;
}

- (void)s_addOwnSubViewController {
    
    WLReportBaseViewController *impl = [WLReportBaseViewController createReportWithStyle:WLReportStyleOne andConfig:[WLReportImpl createReportImpl] andUid:self.uid andEncoded:self.encoded];

    [self.view addSubview:impl.view];

    [self addChildViewController:impl];

    impl.view.frame = self.view.bounds;
    
    self.title = @"举报";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:impl.completeItem];
}

@end
