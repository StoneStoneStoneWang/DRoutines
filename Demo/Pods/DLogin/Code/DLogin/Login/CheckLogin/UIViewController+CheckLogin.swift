//
//  UIViewController+CheckLogin.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLBaseViewController
import DPrepare

extension UIViewController {
    @objc (checkLoginAndIsGoLoginWithStyle: andConfig:)
    public func checkLoginAndIsGoLogin(_ style: WLLoginStyle ,config: WLLoginConfig) -> Bool {
        
        if WLAccountCache.default.isLogin() {
            
            return true
        }
        let alert = UIAlertController(title: "您的还未登录", message: "点击确定前往登录", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (a) in
            
            
        }
        
        let confirm = UIAlertAction(title: "确定", style: .default) { [weak self] (a) in
            
            guard let `self` = self else { return }
            
            let login = WLLoginBaseViewController.createLogin(style, config: config)
            
            let navi = WLNaviController(rootViewController: login)
            
            self.present(navi, animated: true, completion: nil)
        }
        
        alert.addAction(cancel)
        
        alert.addAction(confirm)
        
        present(alert, animated: true, completion: nil)
        
        return false
    }
    @objc (checkLoginWithStyle: andConfig:)
    public func checkLogin(_ style: WLLoginStyle ,config: WLLoginConfig) -> Bool {
        
        if WLAccountCache.default.isLogin() {
            
            return true
        }
        
        let login = WLLoginBaseViewController.createLogin(style, config: config)
        
        let navi = WLNaviController(rootViewController: login)
        
        self.present(navi, animated: true, completion: nil)
        
        return false
    }
}
