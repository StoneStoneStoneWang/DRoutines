//
//  WLStoreBaseViewController+Create.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DLogin

extension WLStoreBaseViewController {
    
    public static func createStore(_ tag: String,style: WLStoreStyle,config: WLStoreConfig ,loginStyle: WLLoginStyle,loginConfig: WLLoginConfig,delegate: WLStoreDelegate!) -> WLStoreBaseViewController {
        
        return WLStoreViewController(tag, config: config, loginStyle: loginStyle, loginConfig: loginConfig, delegate: delegate)
    }
}
