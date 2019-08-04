//
//  WLAddressSelectTableViewCell.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLToolsKit
import SnapKit

class WLAddressSelectTableViewCell: WLAddressBaseTableViewCell {
    
    override var addressBean: WLAddressBean! {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            titleLabel.text = newValue.name
            
            phoneLabel.text = newValue.phone
            
            subTitleLabel.text = newValue.plclne + newValue.cityne + newValue.regionne + newValue.addr
            
            accessoryType = .disclosureIndicator
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(12)
            
            make.height.equalTo(50)
            
            make.width.equalTo(80)
            
            make.top.equalToSuperview()
        }
        
        phoneLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(titleLabel.snp.right).offset(12)
            
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(titleLabel.snp.left)
            
            make.top.equalTo(titleLabel.snp.bottom)
            
            make.right.equalTo(-12)
        }
    }
}
