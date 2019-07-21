//
//  WLStoreCatagoryViewController+Create.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DLogin

extension WLStoreCatagoryBaseViewController {
    
    public static func createStore(_ config: WLStoreConfig ,headers: [[String: Any]] ,delegate: WLStoreDelegate) -> WLStoreCatagoryBaseViewController {
        
        return WLStoreCatagoryViewController(config, headers: headers,delegate: delegate)
    }
}
