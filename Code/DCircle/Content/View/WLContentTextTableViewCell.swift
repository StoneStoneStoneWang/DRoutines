//
//  WLContentTextTableViewCell.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseTableView
import SnapKit

public class WLContentTextTableViewCell: WLBaseTableViewCell {
    
    var eText: String = "" {
        
        willSet {
            
            guard !newValue.isEmpty else { return }
            
            titleLabel.text = newValue
        }
    }
    
    public override func commitInit() {
        super.commitInit()
        
        titleLabel.textAlignment = .left
        
        titleLabel.numberOfLines = 0
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(15)
            
            make.right.equalTo(-15)
            
            make.centerY.equalToSuperview()
        }
    }
}

