//
//  WLProfileImplViewController.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/4/28.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLProfileImplViewController.h"
#import "WLUserInfoImpl.h"
#import "WLBlackImpl.h"
#import "WLLoginImpl.h"
#import "WLAboutImpl.h"
#import "WLFocusImpl.h"
#import "WLProfileImpl.h"
@import DSetting;
#define HScreenH [UIScreen mainScreen].bounds.size.height
#define HScreenW [UIScreen mainScreen].bounds.size.width
#define IS_IPHONE_X ((HScreenH >= 812)?YES:NO)
#define Navigation_Bar_Height (IS_IPHONE_X ? 88.0f : 64.0f)
#define Tab_height (IS_IPHONE_X ? 73 : 49)

@interface WLProfileImplViewController () <WLProfileViewControllerDelegate>

@property (nonatomic ,assign) WLLoginStyle loginStyle;

@property (nonatomic ,weak) id<WLProfileViewControllerMyPubDelegate> cDelegate;
@end

@implementation WLProfileImplViewController

+ (WLProfileImplViewController *)createProfileWithLoginStyle:(WLLoginStyle)loginStyle andCDelegate:(id<WLProfileViewControllerMyPubDelegate>) cDelegate{
    
    return [[WLProfileImplViewController alloc] initWithLoginStyle:loginStyle andCDelegate:cDelegate];
}
- (instancetype)initWithLoginStyle:(WLLoginStyle )loginStyle andCDelegate:(id<WLProfileViewControllerMyPubDelegate>) cDelegate{
    
    if (self = [super init]) {
        
        self.loginStyle = loginStyle;
        
        self.cDelegate = cDelegate;
    }
    return self;
}
- (void)s_addOwnSubViewController {
    
    WLProfileBaseViewController *impl = [WLProfileBaseViewController createProfileWithProfileStyle:WLProfileStyle_Global andProfileConfig:[WLProfileImpl createProfileImpl] andUserInfoConfig:[WLUserInfoImpl createUserInfoImpl] andBlackStyle:WLBlackListStyleOne andBlackConfig:[WLBlackImpl createBlackImpl] andLoginStyle:self.loginStyle andLoginConfig:[WLLoginImpl createLoginImpl] andAboutConfig:[WLAboutImpl createAboutImpl] andFocusStyle:WLFocusListStyleOne andFocusConfig:[WLFocusImpl createFocusImpl] andDelegate:nil andCDelegate:self.cDelegate];
    
    [self.view addSubview:impl.view];
    
    [self addChildViewController:impl];
    
    impl.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    
    self.title = @"我的";
    
    NSString *version = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    if ([version compare:@"1.1.0"] == NSOrderedDescending) {
        
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
    }
}

//- (void)onAboutTap:(UIViewController * _Nonnull)vc {
//    
//    WLAboutViewController *about = [WLAboutViewController createAboutWithConfig:[WLAboutImpl createAboutImpl]];
//    
//    [self.sideMenuController hideLeftViewAnimated];
//    
//    UITabBarController *tab = (UITabBarController *)self.sideMenuController.rootViewController;
//    
//    [(UINavigationController *)tab.selectedViewController pushViewController:about animated:true];
//    
//}
//
//- (void)onFocusTap:(UIViewController * _Nonnull)vc {
//    
//    WLFocusBaseViewController *focus = [WLFocusBaseViewController createFocusWithStyle:WLFocusListStyleOne andConfig:[WLFocusImpl createFocusImpl]];
//    
//    [self.sideMenuController hideLeftViewAnimated];
//    
//    UITabBarController *tab = (UITabBarController *)self.sideMenuController.rootViewController;
//    
//    [(UINavigationController *)tab.selectedViewController pushViewController:focus animated:true];
//}
//
//- (void)onPravicyTap:(UIViewController * _Nonnull)vc {
//    
//    WLProtocolBaseViewController *proto = [WLProtocolBaseViewController createProtocolWithStyle:WLLoginStyle_Global];
//    
//    [self.sideMenuController hideLeftViewAnimated];
//    
//    UITabBarController *tab = (UITabBarController *)self.sideMenuController.rootViewController;
//    
//    [(UINavigationController *)tab.selectedViewController pushViewController:proto animated:true];
//}
//
//- (void)onSettingTap:(UIViewController * _Nonnull)vc {
//    
//    WLSettingViewController *setting = [WLSettingViewController createLoginWithBlackStyle:WLBlackListStyleOne andBlackConfig:[WLBlackImpl createBlackImpl] andLoginStyle:WLLoginStyle_Global andLoginConfig:[WLLoginImpl createLoginImpl]];
//    
//    [self.sideMenuController hideLeftViewAnimated];
//    
//    UITabBarController *tab = (UITabBarController *)self.sideMenuController.rootViewController;
//    
//    [(UINavigationController *)tab.selectedViewController pushViewController:setting animated:true];
//}
//
//- (void)onUserInfoTap:(UIViewController * _Nonnull)vc {
//    
//    WLUserInfoViewController *userInfo = [WLUserInfoViewController createUserInfoWithConfig:[WLUserInfoImpl createUserInfoImpl]];
//    
//    [self.sideMenuController hideLeftViewAnimated];
//    
//    UITabBarController *tab = (UITabBarController *)self.sideMenuController.rootViewController;
//    
//    [(UINavigationController *)tab.selectedViewController pushViewController:userInfo animated:true];
//}


@end
