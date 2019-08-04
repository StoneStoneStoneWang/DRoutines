//
//  WLBuyBaseViewController+Create.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

extension WLBuyBaseViewController {
    
    public static func createBuy(_ config: WLStoreConfig ,commodity: WLCommodityBean) -> WLBuyBaseViewController {
        
        return WLBuyViewController(config, commodity: commodity)
    }
}
