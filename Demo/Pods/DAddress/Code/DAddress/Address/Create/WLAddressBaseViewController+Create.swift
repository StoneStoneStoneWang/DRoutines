//
//  WLAddressBaseViewController+Create.swift
//  DAddressDemo
//
//  Created by three stone 王 on 2019/7/17.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

extension WLAddressBaseViewController {
    @objc
    public static func createAddress(_ style: WLAddressStyle,config: WLAddressConfig) -> WLAddressBaseViewController {
        
        switch style {
        case .list: return WLAddressListViewController(config)
            
        case .select: return WLAddressSelectViewController(config)
            
        }
    }
}
