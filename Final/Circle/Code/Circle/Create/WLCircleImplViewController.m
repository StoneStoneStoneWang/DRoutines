//
//  WLCircleImplViewController.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/13.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLCircleImplViewController.h"
#import "WLCircleImpl.h"
#import "WLLoginImpl.h"
#import "WLPublishImplViewController.h"
@import WLToolsKit;
@import WLBaseViewController;
@import MJRefresh;
#define HScreenH [UIScreen mainScreen].bounds.size.height
#define HScreenW [UIScreen mainScreen].bounds.size.width
#define IS_IPHONE_X ((HScreenH >= 812)?YES:NO)
#define Navigation_Bar_Height (IS_IPHONE_X ? 88.0f : 64.0f)
#define Tab_height (IS_IPHONE_X ? 73 : 49)
#import "UIViewController+Login.h"
@interface WLCircleImplViewController() <WLPublishDelegate>

@property (nonatomic ,copy) NSString *tag;

@property (nonatomic ,assign) WLCircleStyle style;

@property (nonatomic ,assign) WLLoginStyle loginStyle;

@property (nonatomic ,weak) id <WLCircleDelegate> circleDelegate;

@property (nonatomic ,strong) WLCircleBaseViewController *impl;

@property (nonatomic ,assign) BOOL isMy;
@end

@implementation WLCircleImplViewController

+ (WLCircleImplViewController *)createCircleImplWithTag:(NSString *)tag andStyle:(WLCircleStyle )style andLoginStyle:(WLLoginStyle )loginStyle andDelegate:(id <WLCircleDelegate>) circleDelegate andIsMy:(BOOL )isMy{
    
    return [[self alloc] initWithTag:tag andStyle: style andLoginStyle: loginStyle andDelegate: circleDelegate andIsMy:isMy];
}

- (instancetype)initWithTag:(NSString *)tag andStyle:(WLCircleStyle )style andLoginStyle:(WLLoginStyle )loginStyle andDelegate:(id <WLCircleDelegate>) circleDelegate andIsMy:(BOOL )isMy{
    
    if (self = [super init]) {
        
        self.tag = tag;
        
        self.loginStyle = loginStyle;
        
        self.style = style;
        
        self.circleDelegate = circleDelegate;
        
        self.isMy = isMy;
    }
    return self;
}

- (void)s_addOwnSubViewController {
    
    WLCircleBaseViewController *impl = [WLCircleBaseViewController createCircleWithTag:self.tag andIsMy:self.isMy andStyle:WLCircleStyle_Global andConfig:[WLCircleImpl createCircleImpl] andLoginStyle:self.loginStyle andLoginConfig:[WLLoginImpl createLoginImpl] andDelegate:self.circleDelegate];
    
    [self.view addSubview:impl.view];
    
    [self addChildViewController:impl];
    
    impl.view.frame = self.view.bounds;
    
    self.impl = impl;
    
    if (!self.isMy) {
        
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithName:@"发布" nameColor:[UIColor colorWithHexString:@"#ffffff"] highName:@"发布" highColor:[UIColor colorWithHexString:@"#ffffff"] size:CGSizeZero target:self action:@selector(onPublishItemClick)];
        
        self.title = @"我的发布";
    }
    
    UITableView *tableView;
    
    for (UITableView *view in impl.view.subviews) {
        
        if ([view isKindOfClass:[UITableView class ]]) {
            
            ((UITableView *)view).clipsToBounds = false;
            
            tableView = (UITableView *)view;
            
            break;
        }
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HScreenW, Tab_height)];
    
    tableView.tableFooterView = view;
    
    NSString *version = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    if ([version compare:@"1.1.0"] == NSOrderedDescending) {
        
        self.title = self.tag;
    }
}

- (void)onPublishItemClick {
    
    BOOL isLogin = [self checkLoginAndIsGoLoginImpl];
    
    if (isLogin) {
        
        if ([self.tag wl_isEmpty]) {
            
            WLPublishImplViewController *publish = [WLPublishImplViewController createPublishWithStyle: WLPublishStyleMix andTag:self.tag andDelegate:self];
            
            [self.navigationController pushViewController:publish animated:true];
            
        } else {
            
            WLPublishImplViewController *publish = [WLPublishImplViewController createPublishWithStyle: WLPublishStyleMix andTag:self.tag andDelegate:self];
            
            [self.navigationController pushViewController:publish animated:true];
        }
    }
}

- (void)onPublishSucc:(UIViewController * _Nonnull)from pubBean:(NSDictionary<NSString *,id> * _Nonnull)pubBean {
    
    [self.navigationController popViewControllerAnimated:true];
    
    [self.impl insertCircle: pubBean];
}

@end

