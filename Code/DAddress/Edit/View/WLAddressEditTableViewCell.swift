//
//  WLAddressEditTableViewCell.swift
//  DAddressDemo
//
//  Created by three stone 王 on 2019/7/17.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import UIKit
import WLComponentView
import SnapKit

class WLAddressEditTableViewCell: WLAddressEditBaseTableViewCell {
    
    final let tf: WLBaseTextField = WLBaseTextField(frame: .zero)
    
    final let swiItem: UISwitch = UISwitch(frame: .zero)
    
    override var type: WLAddressEditBean! {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            titleLabel.text = newValue.type.title
            
            tf.placeholder = newValue.type.placeholder
            
            tf.isUserInteractionEnabled = true
            
            tf.text = newValue.value
            
            accessoryType = .none
            
            switch newValue.type {
            case .name: fallthrough
            case .detail:
                
                break
            case .phone:
                
                tf.set_editType(.phone)
                
                tf.set_maxLength(11)
                
            case .def:
                
                tf.isUserInteractionEnabled = false
                
                swiItem.sizeToFit()
                
                accessoryView = swiItem
                
                swiItem.addTarget(self, action: #selector(onSwiValueChanged), for: .valueChanged)
                
                selectionStyle = .none
                
                swiItem.isOn = newValue.isDef
                
            case .area:
                
                tf.isUserInteractionEnabled = false
                
                accessoryType = .disclosureIndicator
                
                if newValue.rArea.name.isEmpty {
                    
                    tf.text = newValue.pArea.name + newValue.cArea.name
                } else {
                    
                    tf.text = newValue.pArea.name + newValue.cArea.name + newValue.rArea.name
                }
            default: break
                
            }
            
        }
    }
    override func commitInit() {
        super.commitInit()
        
        titleLabel.textAlignment = .center
        
        addSubview(tf)
        
        tf.set_textChanged { [unowned self] (textfiled) in
            
            self.type.value = textfiled.text ?? ""
        }
    }
    @objc func onSwiValueChanged(_ s: UISwitch) {
        
        type.isDef = s.isOn
    }
}

extension WLAddressEditTableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.top.bottom.equalToSuperview()
            
            make.width.equalTo(80)
        }
        
        tf.snp.makeConstraints { (make) in
            
            make.left.equalTo(titleLabel.snp.right).offset(10)
            
            make.right.top.bottom.equalToSuperview()
        }
    }
}
