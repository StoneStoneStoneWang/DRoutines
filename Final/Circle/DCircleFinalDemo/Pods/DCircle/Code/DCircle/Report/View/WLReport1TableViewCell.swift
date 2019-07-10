//
//  WLReport1TableViewCell.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

open class WLReport1TableViewCell: WLReportTableViewCell {
    
    var accItem: UIButton = UIButton(type: .custom)
    
    override var type: (WLReportBean, WLReportConfig)? {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            titleLabel.text = newValue.0.title
            
            accItem.setImage(UIImage(named: newValue.1.normalIcon), for: .normal)
            
            accItem.setImage(UIImage(named: newValue.1.selectedIcon), for: .selected)
            
            accItem.isSelected = newValue.0.isSelected
            
            accItem.sizeToFit()
            
            accessoryView = accItem
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(15)
            
            make.centerY.equalToSuperview()
        }
    }
}
