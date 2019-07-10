//
//  WLTotalTableViewCell.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

open class WLCommentTotalTableViewCell: WLCommentTableViewCell {
    
    override var type: (WLCommentBean, WLCommentConfig)? {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            titleLabel.text = newValue.0.content
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.centerY.equalToSuperview()
            
            make.left.equalTo(15)
        }
    }
}
