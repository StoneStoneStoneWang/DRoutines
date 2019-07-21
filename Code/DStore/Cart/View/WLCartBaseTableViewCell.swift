//
//  WLCartBaseTableViewCell.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseTableView

@objc (WLCartBaseTableViewCell)
open class WLCartBaseTableViewCell: WLBaseTableViewCell {
    
    open var type: WLCommodityBean!{
        
        willSet {
            
            guard let _ = newValue else { return }
        }
    }
}