//
//  WLPageCollectionViewCell.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import UIKit
import WLToolsKit
import SnapKit

open class WLPageCollectionViewCell: UICollectionViewCell {
    
    final let imageView: UIImageView = UIImageView().then {
        
        $0.contentMode = UIView.ContentMode.scaleAspectFill
        
        $0.layer.masksToBounds = true
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
    }
    
    var icon: String = "" {
        willSet {
            
            guard !newValue.isEmpty else { return }
            
            imageView.image = UIImage(named: newValue)
        }
    }
}

extension WLPageCollectionViewCell {
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.snp.makeConstraints { (make) in
            
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}
