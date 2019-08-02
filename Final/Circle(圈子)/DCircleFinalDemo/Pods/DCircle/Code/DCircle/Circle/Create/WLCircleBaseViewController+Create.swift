//
//  WLCircleBaseViewController+Create.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/7.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DLogin

extension WLCircleBaseViewController {
    
    @objc (createCircleWithTag:andIsMy:andStyle:andConfig:andLoginStyle:andLoginConfig:)
    public static func createCircle(_ tag: String,isMy: Bool, style: WLCircleStyle ,config: WLCircleConfig,loginStyle: WLLoginStyle,loginConfig: WLLoginConfig) -> WLCircleBaseViewController {
        
        switch style {
        case .one: return WLCircle1ViewController(tag,isMy: isMy, style: style, config: config ,loginStyle: loginStyle,loginConfig: loginConfig)
            
        case .two: return WLCircle2ViewController(tag,isMy: isMy, style: style, config: config,loginStyle: loginStyle,loginConfig: loginConfig)
            
        case .three: return WLCircle3ViewController(tag,isMy: isMy, style: style, config: config ,loginStyle: loginStyle,loginConfig: loginConfig)
            
        case .four: return WLCircle4ViewController(tag,isMy: isMy, style: style, config: config,loginStyle: loginStyle,loginConfig: loginConfig)
            
        case .five: return WLCircle5ViewController(tag,isMy: isMy, style: style, config: config,loginStyle: loginStyle,loginConfig: loginConfig)
                        
        case .seven: return WLCircle7ViewController(tag,isMy: isMy, style: style, config: config,loginStyle: loginStyle,loginConfig: loginConfig)
            
        default: return WLCircle4ViewController(tag,isMy: isMy,style: style, config: config,loginStyle: loginStyle,loginConfig: loginConfig)
            
        }
    }
}
