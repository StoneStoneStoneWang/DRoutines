//
//  WLOrderBaseViewController+Create.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DAddress

extension WLCartBaseViewController {
    
    public static func createOrder(_ tag: String,config: WLStoreConfig ,addressConfig: WLAddressConfig) -> WLCartBaseViewController {
        
        return WLCartViewController(tag ,config: config,addressConfig: addressConfig)
    }
}
