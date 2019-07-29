//
//  WLAreaCatagoryBaseTableViewCell.swift
//  DAddressDemo
//
//  Created by three stone 王 on 2019/7/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseTableView
import SnapKit

open class WLAreaCatagoryBaseTableViewCell: WLBaseTableViewCell {
    
    open var type: (WLAreaBean,WLAddressConfig)?
    
    open override func commitInit() {
        super.commitInit()
        
        titleLabel.font = UIFont.systemFont(ofSize: 13)
    }
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(12)
            
            make.right.top.bottom.equalToSuperview()
        }
    }
}
