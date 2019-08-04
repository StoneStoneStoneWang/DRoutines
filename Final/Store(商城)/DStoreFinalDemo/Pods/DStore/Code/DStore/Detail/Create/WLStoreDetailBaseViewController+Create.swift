//
//  WLStoreBaseViewController+Create.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

extension WLStoreDetailBaseViewController {
    
    @objc (createStoreDetailWithStyle:andConfig:andStoreJson:)
    public static func createStoreDetail(_ style: WLStoreDetailStyle ,config: WLStoreConfig,storeJson: [String: Any]) -> WLStoreDetailBaseViewController {
        
        switch style {
            
        case .one: return WLStoreDetail1ViewController(style ,config: config,storeJson: storeJson)
            
        default: return WLStoreDetail1ViewController( style ,config: config,storeJson: storeJson)
            
        }
    }
}
