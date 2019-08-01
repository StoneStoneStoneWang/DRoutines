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
#import "WLSettingImplViewController.h"
#import "WLBlackImplViewController.h"
#import "WLModifyPwdImplViewController.h"
#import "WLUserInfoImplViewController.h"
#import "WLAboutImplViewController.h"
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSettingTap:) name:DNotificationSetting object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoBlackTap:) name:DNotificationGotoBlack object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onFindPwdSucc:) name:DNotificationFindPwdSucc object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onModifyPwdSucc:) name:DNotificationModifyPwdSucc object:nil ];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoUserInfoTap:) name:DNotificationUserInfo object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoMyCircleTap:) name:DNotificationMyCircle object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoMyOrderTap:) name:DNotificationMyOrder object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoMyAddressTap:) name:DNotificationMyAddress object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoAboutTap:) name:DNotificationAboutUs object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onGotoProtocolTap:) name:DNotificationPrivacy object:nil ];
    
    if (appdelegate) {
        
        [DConfigure initWithAppKey:@SAppKey domain:@"https://zhih.ecsoi.com/" smsSign:@"Project" smsLogin:@"SMS_160576175" smsPwd:@"SMS_160571563" pType:(DConfigureTypeCircle)];
        
        [WLNaviController wl_setNaviConfigWithConfig:[WLNaviImpl createNaviImpl]];
        
        appdelegate.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstLogin"]) {
            
            appdelegate.window.rootViewController = [WLWelcomeImplViewController createWelcome];
            
        } else {
            
            [[WLAccountCache shared] wl_queryAccount];
            
            appdelegate.window.rootViewController = [WLMainViewController createCircleTab];
            
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
- (void)onGotoModifyPwdTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        WLModifyPwdImplViewController *modifyPwd = [WLModifyPwdImplViewController createModifyPwd];
        
        [from.navigationController pushViewController:modifyPwd animated:true];
    }
}

- (void)onFindPwdSucc:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        [from.navigationController popViewControllerAnimated:true];
    }
}

- (void)onModifyPwdSucc:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        [from.navigationController popViewControllerAnimated:true];
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
- (void)onSettingTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        WLSettingImplViewController *setting = [WLSettingImplViewController createSetting];
        
        [from.navigationController pushViewController:setting animated:true];
        
    }
}
- (void)onGotoBlackTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        WLBlackImplViewController *black = [WLBlackImplViewController createBlack];
        
        [from.navigationController pushViewController:black animated:true];
        
    }
}

- (void)onGotoUserInfoTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        WLUserInfoImplViewController *userinfo = [WLUserInfoImplViewController createUserInfo];

        [from.navigationController pushViewController:userinfo animated:true];
        
    }
}

- (void)onGotoMyCircleTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
//        WLBlackImplViewController *black = [WLBlackImplViewController createBlack];
//
//        [from.navigationController pushViewController:black animated:true];
        
    }
}

- (void)onGotoMyAddressTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
//        WLBlackImplViewController *black = [WLBlackImplViewController createBlack];
//
//        [from.navigationController pushViewController:black animated:true];
        
    }
}

- (void)onGotoMyOrderTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
//        WLBlackImplViewController *black = [WLBlackImplViewController createBlack];
//
//        [from.navigationController pushViewController:black animated:true];
        
    }
}

- (void)onGotoAboutTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        WLAboutImplViewController *about = [WLAboutImplViewController createAbout];

        [from.navigationController pushViewController:about animated:true];
        
    }
}

- (void)onLoginSuccTap:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    
    if (userInfo && userInfo[@"from"]) {
        
        UIViewController *from = userInfo[@"from"];
        
        [from dismissViewControllerAnimated:true completion:nil];
        
    }

}

@end
