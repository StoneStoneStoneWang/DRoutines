//
//  WLSettingTableViewCell.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseTableView
import SnapKit
import DPrepare

@objc (WLSettingTableViewCell)
public final class WLSettingTableViewCell: WLBaseTableViewCell {
    
    final let swiItem: UISwitch = UISwitch(frame: .zero).then {
        
        $0.isOn = WLAccountCache.default.isPushOn()
    }
    
    var type: WLSettingType = .pwd {
        
        willSet {
            
            titleLabel.text = newValue.title
            
            accessoryType = newValue == .space ? .none : .disclosureIndicator
            
            backgroundColor = newValue == .space ? .clear : .white
            
            selectionStyle = newValue == .space ? .none : .default
            
            titleLabel.font = UIFont.systemFont(ofSize: 15)
            
            titleLabel.textAlignment = .left
            
            switch newValue {
            case .logout:
                
                titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
                
                titleLabel.textAlignment = .center
                
                accessoryType = .none
                
            case .push:
                
                swiItem.sizeToFit()
                
                accessoryView = swiItem
                
                swiItem.addTarget(self, action: #selector(onSwiValueChanged), for: .valueChanged)
                
                selectionStyle = .none
            default:
                break
            }
        }
    }
    
    override public func commitInit() {
        super.commitInit()
        
    }
    @objc func onSwiValueChanged(_ s: UISwitch) {
        
        WLAccountCache.default.setPushOn(s.isOn)
    }
}

extension WLSettingTableViewCell {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(15)
            
            make.centerY.equalToSuperview()
            
            make.right.equalTo(-15)
        }
    }
}
