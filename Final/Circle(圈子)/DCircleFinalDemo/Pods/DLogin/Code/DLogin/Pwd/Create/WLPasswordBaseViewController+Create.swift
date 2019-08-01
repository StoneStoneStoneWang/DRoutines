//
//  WLPasswordBaseViewController+Create.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

extension WLPasswordBaseViewController {
    
    @objc (createPasswordWithStyle:andConfig:)
    public static func createPassword(_ style: WLLoginStyle ,config: WLLoginConfig) -> WLPasswordBaseViewController {
        
        switch style {
        case .one: return WLPassword1ViewController(style, config: config)
            
        case .two: return WLPassword2ViewController(style, config: config)
            
        case .three: return WLPassword3ViewController(style, config: config)
            
        case .four: return WLPassword4ViewController(style, config: config)
            
        case .five: return WLPassword5ViewController(style, config: config)
            
        case .six:  return WLPassword6ViewController(style, config: config)
            
        case .seven: return WLPassword7ViewController(style, config: config)
        }
    }
    
}
