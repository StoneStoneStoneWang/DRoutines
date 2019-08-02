//
//  WLCircleDetailImplViewController.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/13.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLCircleDetailImplViewController.h"
#import "WLCircleDetailImpl.h"
#import "WLLoginImpl.h"

@interface WLCircleDetailImplViewController()

@property (nonatomic ,assign) WLCircleDetailStyle style;

@property (nonatomic ,copy) NSString *encoded;

@property (nonatomic ,copy) NSString *uid;

@property (nonatomic ,assign) WLContentStyle contentStyle;

@property (nonatomic ,assign) WLCommentStyle commentStyle;

@property (nonatomic ,assign) WLLoginStyle loginStyle;

@property (nonatomic ,strong) NSDictionary *circleJson;

@property (nonatomic ,strong) WLCircleDetailBaseViewController *impl;
@end

@implementation WLCircleDetailImplViewController

+ (WLCircleDetailImplViewController *)createCircleDetailImplWithStyle:(WLCircleDetailStyle )style andContentStyle:(WLContentStyle )contentStyle andCommentStyle:(WLCommentStyle )commentStyle andLoginStyle:(WLLoginStyle )loginStyle andUid:(NSString *)uid andEncoded:(NSString *)encoded andCircleJson:(nonnull NSDictionary *)circleJson {
    
    return [[self alloc] initWithStyle:style andContentStyle:contentStyle andCommentStyle:commentStyle andLoginStyle:loginStyle andUid:uid andEncoded:encoded andCircleJson:circleJson];
}

- (instancetype)initWithStyle:(WLCircleDetailStyle )style andContentStyle:(WLContentStyle )contentStyle andCommentStyle:(WLCommentStyle )commentStyle andLoginStyle:(WLLoginStyle )loginStyle andUid:(NSString *)uid andEncoded:(NSString *)encoded andCircleJson:(nonnull NSDictionary *)circleJson {
    
    if (self = [super init]) {
        
        self.style = style;
        
        self.commentStyle = commentStyle;
        
        self.contentStyle = contentStyle;
        
        self.uid = uid;
        
        self.encoded = encoded;
        
        self.loginStyle = loginStyle;
        
        self.circleJson = circleJson;
    }
    return self;
}
- (void)s_addOwnSubViewController {
    
    WLCircleDetailBaseViewController *impl = [WLCircleDetailBaseViewController createCircleDetailWithStyle:self.style andContentStyle:self.contentStyle andContentConfig:[WLCircleDetailImpl createCircleDetailImpl] andCommentStyle:self.commentStyle andCommentConfig:[WLCircleDetailImpl createCircleDetailImpl] andLoginStyle:self.loginStyle andLoginConfig:[WLLoginImpl createLoginImpl] andUid:self.uid andEncoded:self.encoded andCircleJson:self.circleJson];
    
    self.impl = impl;
    
    [self.view addSubview:impl.view];
    
    [self addChildViewController:impl];
    
    impl.view.frame = self.view.bounds;
    
    self.title = @"详情";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.impl.moreItem];
}

@end
