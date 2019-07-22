//
//  AppDelegate.swift
//  DProfileDemo
//
//  Created by three stone 王 on 2019/7/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import UIKit
import WLBaseViewController
import DPrepare
import DLogin
import DPerson
import DRoutinesKit
import DSign
import WLToolsKit

class WLNaviCOnfigImpl: WLNaviControllerConfig {
    var Back_Image: String { return ""}
    
    var Title_FontSize: CGFloat { return 20 }
    
    var Title_HEXColor: String { return "#ffffff"}
    
    var Background_HEXColor: String { return "#f1f1f1" }
    
    var NaviBackground_HEXColor: String { return "#333333"}
    
}

class WLAboutConfigIml : WLAboutConfig {
    /* logo */
    var logo: String { return "LOGO" }
    /* 全局颜色 */
    /* 风格4 代表的是按钮或者文字的主颜色 */
    var itemColor: String { return "#333333" }
}

class WLUserInfoConfigIml: WLUserInfoConfig {
    /* logo */
    var logo: String { return "LOGO" }
    /* 全局颜色 */
    /* 风格4 代表的是按钮或者文字的主颜色 */
    var itemColor: String { return "#f1f1f1" }
    /* 返回按钮icon */
    var backIcon: String { return "" }
    
    var defaultIcon: String { return "" }
}

class WLProfileConfigIml: WLProfileConfig {
    var addressIcon: String { return "" }
    
    var logo: String { return "LOGO" }
    
    var itemColor: String { return "#333333" }
    
    var defaultIcon: String { return "默认头像" }
    
    var userInfoIcon: String { return "我的资料" }
    
    var aboutIcon: String { return "关于我们" }
    
    var settingIcon: String { return "设置" }
    
    var contactUsIcon: String { return "联系我们" }
    
    var pravicyIcon: String { return "隐私政策" }
    
    var focusIcon: String { return "我的关注" }
    
    var circleIcon: String { return "我的发布" }
    
    var phoneNum: String { return "" }
    
    var ciecleName: String { return "我的发布" }
    
}

class WLBlackListConfigIml: WLBlackListConfig {
    var itemColor: String { return "" }
    
    var defaultIcon: String { return "" }
}

class WLLoginConfigIml: WLLoginConfig {
    var logo: String { return "" }
    
    var itemColor: String { return "#333333" }
    
    var phoneIcon: String { return "" }
    
    var vcodeIcon: String { return "" }
    
    var passwordIcon: String { return "" }
    
    var passwordItemNIcon: String { return "" }
    
    var passwordItemSIcon: String { return "" }
    
    var backIcon: String { return "" }
    
    var goIcon: String { return "" }
    
}

class WLFocusListConfigIml: WLFocusListConfig {
    var itemColor: String { return "" }
    
    var defaultIcon: String { return "" }
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        WLNaviController.wl_setNaviConfig(WLNaviCOnfigImpl())
        
        DConfigure.initWithAppKey("344188da2aeb42a5a3cdd2285aef175a", domain: "https://zhih.ecsoi.com/", smsSign: "InJulyApp", smsLogin: "SMS_170330626", smsPwd: "SMS_170330625",pType: .store)
        
        window?.rootViewController  =  WLNaviController(rootViewController: WLProfileBaseViewController.createProfile(.four, profileConfig: WLProfileConfigIml(), userInfoConfig: WLUserInfoConfigIml(), blackStyle: .one, blackConfig: WLBlackListConfigIml(), loginStyle: .two, loginConfig: WLLoginConfigIml(), aboutConfig: WLAboutConfigIml(), focusStyle: .one, focusConfig: WLFocusListConfigIml(), delegate: nil))
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

