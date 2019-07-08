//
//  WLSwiftLoginBaseViewController+Create.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

extension WLSwiftLoginBaseViewController {
    
    @objc (createSwiftLoginWithStyle:andConfig:)
    public static func createSwiftLogin(_ style: WLLoginStyle ,config: WLLoginConfig) -> WLSwiftLoginBaseViewController {
        
        switch style {
        case .one: return WLSwiftLogin1ViewController(style, config: config)
            
        case .two: return WLSwiftLogin2ViewController(style, config: config)
            
        case .three: return WLSwiftLogin3ViewController(style, config: config)
            
        case .four: return WLSwiftLogin4ViewController(style, config: config)
            
        case .five: return WLSwiftLogin5ViewController(style, config: config)
            
        case .six: return WLSwiftLogin6ViewController(style, config: config)
            
        case .seven: return WLSwiftLogin7ViewController(style, config: config)
        }
    }
}
