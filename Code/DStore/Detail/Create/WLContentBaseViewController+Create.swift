//
//  WLStoreBaseViewController+Create.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

extension WLStoreDetailBaseViewController {
    
    @objc (createPublishWithStyle:andConfig:andCircleJson:)
    public static func createStore(_ style: WLStoreStyle ,config: WLStoreConfig,circleJson: [String: Any]) -> WLStoreDetailBaseViewController {
        
        switch style {
            
        case .one: return WLStore1ViewController(style ,config: config,circleJson: circleJson)
            
        default: return WLStore1ViewController( style ,config: config,circleJson: circleJson)
            
        }
    }
}
