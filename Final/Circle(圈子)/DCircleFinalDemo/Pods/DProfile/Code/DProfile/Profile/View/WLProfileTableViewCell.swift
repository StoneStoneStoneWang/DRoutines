//
//  WLProfileTableViewCell.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseTableView
import WLToolsKit
import SnapKit

@objc (WLProfileTableViewCell)
public final class WLProfileTableViewCell: WLBaseTableViewCell {
    
    public var subtitleLabel: UILabel = UILabel().then {
        
        $0.tag = 2004
        
        $0.font = UIFont.systemFont(ofSize: 15)
        
        $0.textAlignment = .right
        
        $0.textColor = WLHEXCOLOR(hexColor: "#666666")
    }
    
    var type: WLProfileType = .userInfo {
        
        willSet {
            
            iconImageView.image = UIImage(named: newValue.icon)
            
            titleLabel.text = newValue.title
            
            accessoryType = newValue == .space ? .none : .disclosureIndicator
            
            backgroundColor = newValue == .space ? .clear : .white
            
            selectionStyle = newValue == .space ? .none : .default
            
            subtitleLabel.text = newValue.subTitle
        }
    }
    
    public override func commitInit() {
        super.commitInit()
        
        contentView.addSubview(subtitleLabel)
    }
}
extension WLProfileTableViewCell {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImageView.snp.makeConstraints { (make) in
            
            make.left.equalTo(15)
            
            make.centerY.equalToSuperview()
            
            make.width.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(iconImageView.snp.right).offset(15)
            
            make.centerY.equalToSuperview()
        }
        subtitleLabel.snp.makeConstraints { (make) in
            
            make.right.equalTo(-15)
            
            make.centerY.equalToSuperview()
        }
    }
}
