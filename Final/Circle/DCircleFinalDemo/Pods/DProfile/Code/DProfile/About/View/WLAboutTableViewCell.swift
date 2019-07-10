//
//  WLAboutTableViewCell.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseTableView
import WLToolsKit
import SnapKit
@objc (WLAboutTableViewCell)
public final class WLAboutTableViewCell: WLBaseTableViewCell {
    
    public var subtitleLabel: UILabel = UILabel().then {
        
        $0.tag = 2002
        
        $0.font = UIFont.systemFont(ofSize: 15)
        
        $0.textAlignment = .right
        
        $0.textColor = WLHEXCOLOR(hexColor: "#666666")
    }
    
    var type: WLAboutType = .version {
        
        willSet {
            
            titleLabel.text = newValue.title
            
            accessoryType = .disclosureIndicator
            
            backgroundColor = .white
            
            accessoryType = newValue == .space ? .none : .disclosureIndicator
            
            backgroundColor = newValue == .space ? .clear : .white
            
            selectionStyle = newValue == .space ? .none : .default
            
            subtitleLabel.text = newValue.subtitle
        }
    }
    
    override public func commitInit() {
        super.commitInit()
        
        contentView.addSubview(subtitleLabel)
    }
    
    
}
extension WLAboutTableViewCell {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(15)
            
            make.centerY.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { (make) in
            
            make.right.equalTo(-15)
            
            make.centerY.equalToSuperview()
        }
    }
}
