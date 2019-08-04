//
//  WLFocusViewController+Create.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
extension WLFocusBaseViewController {
    
    @objc (createFocusWithStyle:andConfig:)
    public static func createFocusList(_ style: WLFocusListStyle ,config: WLFocusListConfig) -> WLFocusBaseViewController {
        
        switch style {
        case .one: return WLFocusViewController(config)
            
        }
    }
}
