//
//  WLBannerImageView.swift
//  HOwner-iOS
//
//  Created by three stone 王 on 2019/6/13.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit
import SnapKit

open class WLBannerImageView: UICollectionViewCell {
    
    final var imageView: UIImageView = UIImageView().then {
        
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
        
        imageView.isUserInteractionEnabled = false
    }
    
    var banner: String! {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            imageView.image = UIImage(named: newValue)
        }
    }
}

extension WLBannerImageView {
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.snp.makeConstraints { (make) in
            
            make.left.top.equalTo(10)
            
            make.right.bottom.equalTo(-10)
        }
    }
}

