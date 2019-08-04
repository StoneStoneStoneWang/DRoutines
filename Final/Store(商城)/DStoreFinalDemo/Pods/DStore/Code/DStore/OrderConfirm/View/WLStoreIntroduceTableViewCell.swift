//
//  WLStoreIntroduceTableViewCell.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import SnapKit
import WLToolsKit

class WLStoreIntroduceTableViewCell: WLStoreOrderConfirmBaseTableViewCell {
    
    override var type: WLStoreOrderConfirmBean! {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            titleLabel.numberOfLines = 3
            
            titleLabel.font = UIFont.systemFont(ofSize: 13)
            
            titleLabel.text = "用户须知: \n我们目前仅提供线下方式购买,当您点击购买生成订单后我们会,电话联系您，提供上门服务"
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(10)
            
            make.right.equalTo(-10)
            
            make.centerY.equalToSuperview()
        }
    }
}

