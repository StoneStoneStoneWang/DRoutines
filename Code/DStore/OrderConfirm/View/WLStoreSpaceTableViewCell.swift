//
//  WLStoreSpaceTableViewCell.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import SnapKit
import WLToolsKit

class WLStoreSpaceTableViewCell: WLStoreOrderConfirmBaseTableViewCell {
    
    override var type: WLStoreOrderConfirmBean! {
        
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
        }
    }
    
    override func commitInit() {
        super.commitInit()
        
        backgroundColor = .clear
    }
}

