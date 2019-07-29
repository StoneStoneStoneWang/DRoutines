//
//  WLStoreContactUsTableViewCell.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import SnapKit
import WLToolsKit

class WLStoreContactUsTableViewCell: WLStoreOrderConfirmBaseTableViewCell {
    
    @objc (priceLabel)
    open var phoneLabel: UILabel = UILabel().then {
        
        $0.tag = 2009
        
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        
        $0.textAlignment = .right
        
        $0.textColor = WLHEXCOLOR(hexColor: "#ff0000")
    }
    
    override var type: WLStoreOrderConfirmBean! {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            titleLabel.text = "联系我们"
            
            var phone: WLKeyValueBean!
            
            for item in newValue.commodity.contentMap {
                
                if item.type == "txt" {
                    
                    if item.value.contains("Phone") {
                        
                        phone = item
                        
                        break
                    }
                }
            }
            if let phone = phone {
                
                let temp = phone.value.components(separatedBy: ":")
                
                phoneLabel.text = temp.last!
            }
            
        }
    }
    
    override func commitInit() {
        super.commitInit()
        
        contentView.addSubview(phoneLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        phoneLabel.snp.makeConstraints { (make) in
            
            make.centerY.equalToSuperview()
            
            make.right.equalTo(-10)
        }
        titleLabel.snp.makeConstraints { (make) in
            
            make.centerY.equalToSuperview()
            
            make.left.equalTo(10)
        }
    }
}

