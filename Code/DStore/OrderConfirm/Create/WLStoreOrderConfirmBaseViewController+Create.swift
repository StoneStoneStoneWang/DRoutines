//
//  WLStoreOrderConfirmBaseViewController+Create.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DAddress
import ObjectMapper

extension WLStoreOrderConfirmBaseViewController {
    @objc
    public static func createStoreOrder(_ config: WLStoreConfig ,addressConfig: WLAddressConfig ,storeJson: [String: Any]) -> WLStoreOrderConfirmBaseViewController {
        
        return WLStoreOrderConfirmViewController(config, addressConfig: addressConfig, commodity: WLCommodityBean(JSON: storeJson)!)
    }
    
    public static func createStoreOrder(_ config: WLStoreConfig ,addressConfig: WLAddressConfig ,commodity: WLCommodityBean) -> WLStoreOrderConfirmBaseViewController {
        
        return WLStoreOrderConfirmViewController(config, addressConfig: addressConfig, commodity: commodity)
    }
}
