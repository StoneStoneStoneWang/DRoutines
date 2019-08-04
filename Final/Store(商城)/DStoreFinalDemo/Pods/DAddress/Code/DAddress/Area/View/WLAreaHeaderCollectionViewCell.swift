//
//  WLAreaHeaderCollectionViewCell.swift
//  DAddressDemo
//
//  Created by three stone 王 on 2019/7/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLToolsKit
import SnapKit

class WLAreaHeaderCollectionViewCell: UICollectionViewCell {
    
    var type: (WLAreaHeaderBean,WLAddressConfig)? {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            if newValue.0.areaBean == nil {
                
                titleLabel.textColor = WLHEXCOLOR(hexColor: newValue.1.itemColor)
                
                titleLabel.text = "请选择"
            } else {
                
                titleLabel.textColor = WLHEXCOLOR(hexColor: "#666666")
                
                titleLabel.text = newValue.0.areaBean.name
            }
        }
    }
    
    open var titleLabel: UILabel = UILabel().then {
        
        $0.tag = 2002
        
        $0.font = UIFont.systemFont(ofSize: 13)
        
        $0.textAlignment = .center
        
        $0.textColor = WLHEXCOLOR(hexColor: "#666666")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commitInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commitInit() {
        
        contentView.addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.top.right.bottom.equalToSuperview()
        }
    }
}
