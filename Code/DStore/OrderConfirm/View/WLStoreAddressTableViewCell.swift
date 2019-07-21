//
//  WLStoreAddressTableViewCell.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import SnapKit
import WLToolsKit

class WLStoreAddressTableViewCell: WLStoreOrderConfirmBaseTableViewCell {
    
    override var type: WLStoreOrderConfirmBean! {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            phoneLabel.isHidden = false
            
            subTitleLabel.isHidden = false
            
            titleLabel.textAlignment = .left
            
            if let address = newValue.address {
                
                titleLabel.text = address.name
                
                phoneLabel.text = address.phone
                
                subTitleLabel.text = address.plclne + address.cityne + address.regionne + address.addr
                
                accessoryType = .disclosureIndicator
                
            } else {
                
                phoneLabel.isHidden = true
                
                subTitleLabel.isHidden = true
                
                titleLabel.textAlignment = .center
                
                titleLabel.text = "请选择地址"
            }
        }
    }
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
    
    override open func commitInit() {
        super.commitInit()
        
        contentView.addSubview(phoneLabel)
        
        contentView.addSubview(subTitleLabel)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let type = type ,let _ = type.address {
            
            titleLabel.snp.remakeConstraints { (make) in
                
                make.left.equalTo(12)
                
                make.height.equalTo(50)
                
                make.width.equalTo(80)
                
                make.top.equalToSuperview()
            }
            
            phoneLabel.snp.remakeConstraints { (make) in
                
                make.left.equalTo(titleLabel.snp.right).offset(12)
                
                make.centerY.equalTo(titleLabel.snp.centerY)
            }
            
            subTitleLabel.snp.remakeConstraints { (make) in
                
                make.left.equalTo(titleLabel.snp.left)
                
                make.top.equalTo(titleLabel.snp.bottom)
                
                make.right.equalTo(-12)
            }
        } else {
            
            titleLabel.snp.remakeConstraints { (make) in
                
                make.center.equalToSuperview()
            }
        }
        
        
    }
}
