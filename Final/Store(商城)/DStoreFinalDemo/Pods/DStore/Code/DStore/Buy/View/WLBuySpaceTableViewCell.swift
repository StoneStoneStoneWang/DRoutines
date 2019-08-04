//
//  WLBuySpaceTableViewCell.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import UIKit
import SnapKit
import WLToolsKit
class WLBuySpaceTableViewCell: WLBuyTableViewCell {
    
    override var type: WLBuyBean! {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            //            titleLabel.text = newValue.
            //
            //            if newValue.0.isSelected {
            //
            //                accessoryType = .disclosureIndicator
            //            } else {
            //
            //                accessoryType = .none
            //            }
            
            lineType = .none
        }
    }
    
    override func commitInit() {
        super.commitInit()
        
        backgroundColor = .clear
    }
}

