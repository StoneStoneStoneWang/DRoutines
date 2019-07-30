//
//  WLStoreCatagoryViewController+Create.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

extension WLStoreCatagoryBaseViewController {
    
    public static func createStore(_ style: WLStoreStyle,config: WLStoreConfig ,headers: [[String: Any]] ) -> WLStoreCatagoryBaseViewController {
        
        return WLStoreCatagoryViewController(config, headers: headers)
    }
}
