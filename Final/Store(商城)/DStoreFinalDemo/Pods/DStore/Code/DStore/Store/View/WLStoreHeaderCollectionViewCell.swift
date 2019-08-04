//
//  WLStoreHeaderCollectionViewCell.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLToolsKit
import SnapKit

class WLStoreHeaderCollectionViewCell: UICollectionViewCell {
    
    var type: (WLStoreHeaderBean,WLStoreConfig)? {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            titleLabel.text = newValue.0.title
            
            if newValue.0.isSelected {
                
                titleLabel.textColor = WLHEXCOLOR(hexColor: newValue.1.itemColor)
    
            } else {
                
                titleLabel.textColor = WLHEXCOLOR(hexColor: "#666666")

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
