//
//  WLRootManager+RootManager.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLRootManager+RootManager.h"
#import "WLMainViewController+Circle.h"
#import "WLNaviImpl.h"
#import "WLWelcomeImplViewController.h"
#import "WLMainBean.h"

@import WLBaseViewController;
@import DPrepare;
//#import <WLThirdUtil/WLJShareUtil.h>
//#import "JSHAREService.h"
//#import <AdSupport/AdSupport.h>
#import <WXApi.h>
@import DSign;
@import DRoutinesKit;
#import <DRoutinesKit/DConfigure.h>
@implementation WLRootManager (RootManager) 

- (void)makeRoot:(UIResponder<UIApplicationDelegate> *)appdelegate {
    
    if (appdelegate) {
        
        [DConfigure initWithAppKey:@SAppKey domain:@"https://zhih.ecsoi.com/" smsSign:@"Project" smsLogin:@"SMS_160576175" smsPwd:@"SMS_160571563"];
        
        [WLNaviController wl_setNaviConfigWithConfig:[WLNaviImpl createNaviImpl]];
        
        appdelegate.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstLogin"]) {
            
            appdelegate.window.rootViewController = [WLWelcomeImplViewController createWelcomeWithDelegate:self];
            
        } else {
            
            [[WLAccountCache shared] wl_queryAccount];
//
//            WLProfileImplViewController *profile = [WLProfileImplViewController createProfileWithLoginStyle:WLLoginStyle_Global andCDelegate:self];
//
//            LGSideMenuController *sideMenuController = [LGSideMenuController sideMenuControllerWithRootViewController:[WLMainViewController createCircleWithTabs: WLMainBean.tags] leftViewController:profile rightViewController:nil];
            
            appdelegate.window.rootViewController = [WLMainViewController createCircleWithTabs: WLMainBean.tags];
            
        }
        
        [appdelegate.window makeKeyAndVisible];
        
        [WXApi registerApp:@SWXKey];
        
    }
}

- (void)onskipTap:(UIViewController *)vc {
    
    WLMainViewController *main = [WLMainViewController createCircleWithTabs:WLMainBean.tags];
    
//    WLProfileImplViewController *profile = [WLProfileImplViewController createProfileWithLoginStyle:WLLoginStyle_Global andCDelegate:self];
    
//    LGSideMenuController *sideMenuController = [LGSideMenuController sideMenuControllerWithRootViewController:[WLMainViewController createCircleWithTabs: WLMainBean.tags] leftViewController:profile rightViewController:nil];
//
    main.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [vc presentViewController:main animated:true completion:nil];
}
//- (void)onCircleTap:(UIViewController * _Nonnull)vc {
//
//    LGSideMenuController *side = (LGSideMenuController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//
//    UITabBarController *tab = (UITabBarController *)side.rootViewController;
//
//    UINavigationController *navi = (UINavigationController *)tab.selectedViewController;
//
//    WLCircleImplViewController *circle1 = [WLCircleImplViewController createCircleImplWithTag:@"" andStyle:WLCircleStyle_Global andLoginStyle:WLLoginStyle_Global andDelegate:navi.topViewController andIsMy:true];
//
//    [side hideLeftViewAnimated];
//
//    [navi pushViewController:circle1 animated:true];
//}

@end