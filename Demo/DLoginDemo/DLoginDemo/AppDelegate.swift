//
//  AppDelegate.swift
//  DLoginDemo
//
//  Created by three stone 王 on 2019/7/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import UIKit
import WLBaseViewController
import DSign
import DRoutinesKit
import DNotification

class WLLoginConfigImpl: WLLoginConfig {
    var logo: String { return "" }
    
    var itemColor: String { return "#BB5BD4" }
    
    var phoneIcon: String { return "" }
    
    var vcodeIcon: String { return "" }
    
    var passwordIcon: String { return "" }
    
    var passwordItemNIcon: String { return "" }
    
    var passwordItemSIcon: String { return "" }
    
    var backIcon: String { return "" }
    
    var goIcon: String { return "" }
}

class WLNaviCOnfigImpl: WLNaviControllerConfig {
    var Back_Image: String { return ""}
    
    var Title_FontSize: CGFloat { return 20 }
    
    var Title_HEXColor: String { return "#ffffff" }
    
    var Background_HEXColor: String { return "#f1f1f1" }
    
    var NaviBackground_HEXColor: String { return "#BB5BD4"}
    
}
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        WLNaviController.wl_setNaviConfig(WLNaviCOnfigImpl())

        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = WLNaviController(rootViewController: WLLoginBaseViewController.createLogin(.seven, config: WLLoginConfigImpl()))
        
        window?.makeKeyAndVisible()
        
        DConfigure.initWithAppKey("7c3dc730519b4347a598210900689358", domain: "https://zhih.ecsoi.com/", smsSign: "zhiheApp", smsLogin: "3", smsPwd: "4",pType: .store)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onLoginSucc), name: NSNotification.Name(rawValue: DNotificationLoginSucc), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onGotoProtocol), name: NSNotification.Name(rawValue: DNotificationGotoProtocol), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onGotoFindPwd), name: NSNotification.Name(rawValue: DNotificationGotoFindPwd), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onGotoReg), name: NSNotification.Name(rawValue: DNotificationGotoReg), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(backLogin), name: NSNotification.Name(rawValue: DNotificationBackLogin), object: nil)
        
        return true
    }
    
    @objc func onLoginSucc(_ noti: Notification) {
        
        if let userInfo = noti.userInfo {
            
            if let from = userInfo["from"] as? UIViewController {
                
                
            }
        }
    }
    
    @objc func onGotoReg(_ noti: Notification) {
        
        if let userInfo = noti.userInfo {
            
            if let from = userInfo["from"] as? UIViewController {
                
                let reg = WLSwiftLoginBaseViewController.createSwiftLogin(.seven, config: WLLoginConfigImpl())
                
                from.navigationController?.pushViewController(reg, animated: true)
                
            }
        }
        
    }
    @objc func backLogin(_ noti: Notification) {
        
        if let userInfo = noti.userInfo {
            
            if let from = userInfo["from"] as? UIViewController {
                
                
                from.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    @objc func onGotoProtocol(_ noti: Notification) {
        
        if let userInfo = noti.userInfo {
            
            if let from = userInfo["from"] as? UIViewController {
                
                let pro = WLProtocolBaseViewController.createProtocol(.seven)
                
                from.navigationController?.pushViewController(pro, animated: true)
            }
        }
    }
    
    @objc func onGotoFindPwd(_ noti: Notification) {
        
        if let userInfo = noti.userInfo {
            
            if let from = userInfo["from"] as? UIViewController {
                
                let pwd = WLPasswordBaseViewController.createPassword(.seven, config: WLLoginConfigImpl())
                
                from.navigationController?.pushViewController(pwd, animated: true)
            }
        }
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

