//
//  WLHomeViewController.m
//  奥迪车友会
//
//  Created by three stone 王 on 2019/3/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLHomeViewController.h"
#import "WLHomeScrollView.h"
#import "WLProjectConfig.h"
#import <WLThirdUtil/WLHudUtil.h>
#import <WXApi.h>
#define HScreenH [UIScreen mainScreen].bounds.size.height
#define HScreenW [UIScreen mainScreen].bounds.size.width
#define IS_IPHONE_X ((HScreenH >= 812)?YES:NO)
#define Navigation_Bar_Height (IS_IPHONE_X ? 88.0f : 64.0f)
@import WLBaseViewController;
@import DStore;
@interface WLHomeViewController ()
{
    
    WLHomeScrollView *_scrollView;
    
    NSTimer *_timer;
}

@property (nonatomic ,strong) NSMutableArray *items;

@end

@implementation WLHomeViewController

+ (instancetype)createHome {
    
    return [self new];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView = [WLHomeScrollView homeScrollViewWithStoreStyle:WLStoreStyleOne andLoginStyle:WLLoginStyle_Global];
    
    [self.view addSubview:_scrollView];
    
    [_scrollView addChildViewController:self];
    
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _scrollView.frame = self.view.bounds;
    
}

static NSString * const kStatusBarTappedNotification = @"statusBarTappedNotification";

- (void)prepareData {
    
    
}
- (void)onScrollViewScroll:(CGFloat)contentoffsetY {
    
    
}

//- (void)onCircleClick:(UIViewController *)vc circlJson:(NSDictionary<NSString *,id> *)circlJson uid:(NSString *)uid encoded:(NSString *)encoded {
//
//    WLCircleDetailImplViewController *circleDetail = [WLCircleDetailImplViewController createCircleDetailImplWithStyle:WLCircleDetailStyleOne andContentStyle:WLContentStyleOne andCommentStyle:WLCommentStyleOne andLoginStyle:WLLoginStyle_Global andUid:uid andEncoded:encoded andCircleJson:circlJson];
//
//    [vc.navigationController pushViewController:circleDetail animated:true];
//}
//
//- (void)onReportClick:(UIViewController *)vc uid:(NSString *)uid encoded:(NSString *)encoded {
//
//    WLReportImplViewController *report = [WLReportImplViewController createReportWithEncoded:encoded andUid:uid andStyle:WLReportStyleOne];
//
//    [vc.navigationController pushViewController:report animated:true];
//}

//- (void)onShareClick:(UIViewController *)vc webUrl:(NSString *)webUrl title:(NSString *)title desc:(NSString *)desc {
//
//}

@end
