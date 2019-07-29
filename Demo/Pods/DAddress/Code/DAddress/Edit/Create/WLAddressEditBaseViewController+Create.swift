//
//  WLAddressEditBaseViewController+Create.swift
//  DAddressDemo
//
//  Created by three stone 王 on 2019/7/17.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

extension WLAddressEditBaseViewController {
    
    public static func createAddressEdit(_ config: WLAddressConfig,isEdit: Bool ,addressBean: WLAddressBean) -> WLAddressEditBaseViewController {
        
        return WLAddressEditViewController(config,isEdit: isEdit,addressBean: addressBean)
    }
    @objc
     public static func createAddressEdit(_ config: WLAddressConfig,isEdit: Bool ,addressJson: [String: Any]) -> WLAddressEditBaseViewController {
        
        return WLAddressEditViewController(config,isEdit: isEdit,addressBean: WLAddressBean(JSON: addressJson)!)
    }
}
