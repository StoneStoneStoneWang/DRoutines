//
//  WLAddressBaseTableViewCell.swift
//  DAddressDemo
//
//  Created by three stone 王 on 2019/7/17.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseTableView
import WLToolsKit

open class WLAddressBaseTableViewCell: WLBaseTableViewCell {
    open var phoneLabel: UILabel = UILabel().then {
        
        $0.tag = 2009
        
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        
        $0.textAlignment = .left
        
        $0.textColor = WLHEXCOLOR(hexColor: "#333333")
    }
    
    open var subTitleLabel: UILabel = UILabel().then {
        
        $0.tag = 2010
        
        $0.font = UIFont.boldSystemFont(ofSize: 13)
        
        $0.textAlignment = .left
        
        $0.textColor = WLHEXCOLOR(hexColor: "#666666")
    }
    open var addressBean: WLAddressBean!
    
    override open func commitInit() {
        super.commitInit()
        
        contentView.addSubview(phoneLabel)
        
        contentView.addSubview(subTitleLabel)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
    }
}
