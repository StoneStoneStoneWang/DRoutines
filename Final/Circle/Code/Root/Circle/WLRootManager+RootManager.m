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
#import "WLSwiftLoginImpleViewController.h"
#import "WLFindPwdImplViewController.h"
#import "WLProtocolImplViewController.h"
#import "WLLoginImpl.h"
@import WLBaseViewController;
@import DPrepare;
#import <WXApi.h>
@import DSign;
@import DRoutinesKit;
@import DNotification;
@import DLogin;
#import <DRoutinesKit/DConfigure.h>
@implementation WLRootManager (RootManager) 

- (void)makeRoot:(UIResponder<UIApplicationDelegate> *)appdelegate {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onskipTap:) name:DNotificationWelcomeSkip object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoRegTap:) name:DNotificationGotoReg object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoFindPwdTap:) name:DNotificationGotoFindPwd object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoProtocolTap:) name:DNotificationGotoProtocol object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onBackLoginTap:) name:DNotificationBackLogin object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLoginSuccTap:) name:DNotificationLoginSucc object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLoginSuccTap:) name:DNotificationRegSucc object:nil ];
    
    if (appdelegate) {
        
        [DConfigure initWithAppKey:@SAppKey domain:@"https://zhih.ecsoi.com/" smsSign:@"Project" smsLogin:@"SMS_160576175" smsPwd:@"SMS_160571563" pType:(DConfigureTypeCircle)];
        
        [WLNaviController wl_setNaviConfigWithConfig:[WLNaviImpl createNaviImpl]];
        
        appdelegate.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        //        [[WLAccountCache shared] clearAccount];
        
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstLogin"]) {
            
            appdelegate.window.rootViewController = [WLWelcomeImplViewController createWelcome];
            
        } else {
            
            [[WLAccountCache shared] wl_queryAccount];
            
            appdelegate.window.rootViewController = [[WLNaviController alloc] initWithRootViewController:[WLLoginBaseViewController createLoginWithStyle:WLLoginStyle_Global andConfig:[WLLoginImpl createLoginImpl]]];
            
        }
        
        [appdelegate.window makeKeyAndVisible];
        
        [WXApi registerApp:@SWXKey];
        
        
    }
}
#pragma mark -- DNotificationWelcomeSkip
- (void)onskipTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        WLMainViewController *main = [WLMainViewController createCircleTab];
        
        main.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        
        [from presentViewController:main animated:true completion:nil];
        
    }
}
#pragma mark -- DNotificationGotoReg
- (void)onGotoRegTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        WLSwiftLoginImpleViewController *swiftLogin = [WLSwiftLoginImpleViewController createSwiftLogin];
        
        [from.navigationController pushViewController:swiftLogin animated:true];
    }
}

- (void)onBackLoginTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        [from.navigationController popViewControllerAnimated:true];
        
    }
}

- (void)onGotoFindPwdTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        WLFindPwdImplViewController *findPwd = [WLFindPwdImplViewController createFindPwd];
        
        [from.navigationController pushViewController:findPwd animated:true];
    }
}

- (void)onGotoProtocolTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        WLProtocolImplViewController *pro = [WLProtocolImplViewController createProtocol];
        
        [from.navigationController pushViewController:pro animated:true];
        
    }
}

- (void)onLoginSuccTap:(NSNotification *)noti {
    
    [UIApplication sharedApplication].delegate.window.rootViewController = [WLMainViewController createCircleTab];
    
}

@end
