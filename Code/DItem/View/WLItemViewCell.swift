//
//  WLItemViewCell.swift
//  HOwner-iOS
//
//  Created by three stone 王 on 2019/6/13.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit
import SnapKit
import Kingfisher

open class WLItemViewCell: UICollectionViewCell {
    
    final let imageView: UIImageView = UIImageView().then {
        
        $0.contentMode = UIView.ContentMode.scaleAspectFill
        
        $0.layer.masksToBounds = true
    }
    
    final let titleLabel: UILabel = UILabel().then {
        
        $0.font = UIFont.systemFont(ofSize: 13)
        
        $0.textAlignment = .center
        
        $0.textColor = WLHEXCOLOR(hexColor: "#333333")
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        commitInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open func commitInit() {
        
        contentView.addSubview(imageView)
        
        contentView.addSubview(titleLabel)
    }
    
    var type: WLItemType = .service {
        
        willSet {
            
            titleLabel.text = newValue.rawValue
        
            imageView.image = UIImage(named: newValue.icon)
        }
    }
}

extension WLItemViewCell {
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.right.bottom.equalToSuperview()
            
            make.height.equalTo(20)
        }
        
        imageView.snp.makeConstraints { (make) in
            
            make.left.top.equalTo(5)
            
            make.right.equalTo(-5)
            
            make.bottom.equalTo(titleLabel.snp.top).offset(-5)
        }
    }
}

