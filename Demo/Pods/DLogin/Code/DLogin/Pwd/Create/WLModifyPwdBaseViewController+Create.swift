//
//  WLModifyPwdBaseViewController+Create.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

extension WLModifyPwdBaseViewController {
    
    @objc (createPasswordWithStyle:andConfig:)
    public static func createPassword(_ style: WLLoginStyle ,config: WLLoginConfig) -> WLModifyPwdBaseViewController {
        
        switch style {
            
        case .one: return WLModifyPwd1ViewController(style ,config: config)
            
        case .two: return WLModifyPwd2ViewController(style ,config:  config)
            
        case .three: return WLModifyPwd3ViewController(style ,config:  config)
            
        case .four: return WLModifyPwd4ViewController(style ,config:  config)
            
        case .five: return WLModifyPwd5ViewController(style ,config: config)
            
        case .six: return WLModifyPwd6ViewController(style ,config: config)
            
        case .seven: return WLModifyPwd7ViewController(style ,config: config)
        }
    }
}
