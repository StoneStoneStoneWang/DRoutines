//
//  WLLoginBaseViewController+Create.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
extension WLLoginBaseViewController {
    
    @objc (createLoginWithStyle:andConfig:)
    public static func createLogin(_ style: WLLoginStyle ,config: WLLoginConfig) -> WLLoginBaseViewController {
        
        switch style {
        case .one: return WLLogin1ViewController(style, config: config)
            
        case .two: return WLLogin2ViewController(style, config: config)
            
        case .three: return WLLogin3ViewController(style, config: config)
            
        case .four: return WLLogin4ViewController(style, config: config)
        //
        case .five: return WLLogin5ViewController(style, config: config)
            
        case .six: return WLLogin6ViewController(style, config: config)
            
        case .seven: return WLLogin7ViewController(style, config: config)
            
        default: return WLLogin2ViewController(style, config: config)
        }
    }
}
