//
//  WLProtocolViewController+Create.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

extension WLProtocolBaseViewController {
    
    @objc (createProtocolWithStyle:)
    public static func createProtocol(_ style: WLLoginStyle) -> WLProtocolBaseViewController {
        
        switch style {
        case .seven: return WLProtocol7ViewController()
            
        default: return WLProtocolViewController()
            
        }
    }
}
