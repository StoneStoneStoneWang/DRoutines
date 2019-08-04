//
//  WLBlackListBaseTableViewCell.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseTableView

@objc (WLBlackListBaseTableViewCell)
open class WLBlackListBaseTableViewCell: WLBaseTableViewCell {
    
    open var type: (WLBlackListBean ,WLBlackListConfig)!{
        
        willSet {
            
            guard let _ = newValue else { return }
        }
    }
}
