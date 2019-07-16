//
//  WLMapTableViewCell.swift
//  WLMapkitDemo
//
//  Created by three stone 王 on 2019/5/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseTableView
import WLComponentView
import SnapKit

final class WLMapTableViewCell: WLBaseTableViewCell{
    
    final let tf: WLBaseTextField = WLBaseTextField(frame: .zero)
    
    override func commitInit() {
        super.commitInit()
        
        contentView.addSubview(tf)
        
        titleLabel.textAlignment = .center
        
        tf.set_textChanged { (arg) in
            
            self.bean.value = arg.text ?? ""
        }
        
        tf.delegate = self
    }
    
    var bean: WLMapPublishBean! {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            titleLabel.text = newValue.type
            
            tf.text = newValue.value
            
            tf.placeholder = newValue.place
            
            tf.set_editType(.default)
            
            tf.set_maxLength(999)
            
            if newValue.type.contains("时间") {
                
                tf.isUserInteractionEnabled = false
                
                accessoryType = .disclosureIndicator
                
            } else if newValue.type.contains("手机") {
                
                tf.set_editType(.phone)
                
                tf.set_maxLength(11)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.top.bottom.equalToSuperview()
            
            make.width.equalTo(80)
        }
        
        tf.snp.makeConstraints { (make) in
            
            make.left.equalTo(titleLabel.snp.right)
            
            make.top.right.bottom.equalToSuperview()
        }
    }
}

extension WLMapTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
}
