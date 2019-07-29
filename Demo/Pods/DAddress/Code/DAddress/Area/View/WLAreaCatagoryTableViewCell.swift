//
//  WLAreaCatagoryTableViewCell.swift
//  DAddressDemo
//
//  Created by three stone 王 on 2019/7/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
class WLAreaCatagoryTableViewCell: WLAreaCatagoryBaseTableViewCell {
    
    override var type: (WLAreaBean,WLAddressConfig)? {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            titleLabel.text = newValue.0.name
            
            if newValue.0.isSelected {
                
                accessoryType = .disclosureIndicator
            } else {
                
                accessoryType = .none
            }
        }
    }
}
