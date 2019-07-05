//
//  WLWelComeBaseViewController+Create.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

extension WLWelComeBaseViewController {
    
    @objc (createWelcomeWithStyle:andConfig:andDelegate:)
    public static func createWelcome(_ style: WLWelcomeStyle ,config: WLWelComeConfig ,delegate: WLWelComeBaseDelegate) -> WLWelComeBaseViewController {
        
        switch style {
        case .one: return WLWelCome1ViewController(style ,config: config,delegate: delegate)
            
        case .two: return WLWelCome2ViewController(style ,config: config,delegate: delegate)
            
        }
    }
}
