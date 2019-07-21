//
//  WLAreaBaseViewController+Create.swift
//  DAddressDemo
//
//  Created by three stone 王 on 2019/7/17.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

extension WLAreaBaseViewController {
    
    @objc public static func createArea(_ config: WLAddressConfig,addressEditBean: WLAddressEditBean) -> WLAreaBaseViewController {
        
        return WLAreaViewController(config ,addressEditBean: addressEditBean)
    }
}
