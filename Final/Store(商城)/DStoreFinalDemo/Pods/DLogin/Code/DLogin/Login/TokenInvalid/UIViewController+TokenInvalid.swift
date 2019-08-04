//
//  UIViewController+TokenInvalid.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLBaseViewController
import WLThirdUtil.WLJPushUtil
import DPrepare

extension UIViewController {
    
    @objc public func tokenInvalidAlertShow(_ style: WLLoginStyle ,config: WLLoginConfig) {
        
        WLAccountCache.default.clearAccount()
        
        WLUserInfoCache.default.userBean = WLUserBean()
        
        WLJPushUtil.shared().jp_deleteAlias({ (_, _, _) in
            
        }, seq: 1)
        
        let alert = UIAlertController(title: "您的账号授权失败", message: "点击确定前往登录", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (a) in
            
            
        }
        
        let confirm = UIAlertAction(title: "确定", style: .default) { (a) in
            
            let login = WLLoginBaseViewController.createLogin(style, config: config)
            
            let navi = WLNaviController(rootViewController: login)
            
            UIApplication.shared.keyWindow?.rootViewController?.present(navi, animated: true, completion: nil)
        }
        
        alert.addAction(cancel)
        
        alert.addAction(confirm)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
