//
//  WLStoreBaseViewController+Create.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

extension WLStoreBaseViewController {
    @objc
    public static func createStore(_ tag: String,style: WLStoreStyle,config: WLStoreConfig) -> WLStoreBaseViewController {
        
        return WLStoreViewController(tag, config: config)
    }
}
