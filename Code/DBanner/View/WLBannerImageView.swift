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
import Kingfisher
open class WLBannerImageView: UICollectionViewCell {
    
    var iconImageView: UIImageView = UIImageView().then {
        
        $0.layer.masksToBounds = true
        
        $0.image = UIImage(named: "Logo")
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        commitInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open func commitInit() {
        
        contentView.addSubview(iconImageView)
        
        iconImageView.isUserInteractionEnabled = false
        
        iconImageView.contentMode = .redraw
    }
    
    var banner: WLBannerBean! {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            var image: WLBannerKeyValueBean!
            
            for item in newValue.contentMap {
                
                if item.type == "image" {
                    
                    image = item
                    
                    break
                }
            }
            
            if let image = image {
                
                let processor: ImageProcessor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 0)
                
                iconImageView.kf.indicatorType = .activity
                
                let icon: String = image.value + "?x-oss-process=image/resize,w_1600,h_800"
                
                self.iconImageView.kf.setImage(with: URL(string: icon), placeholder: UIImage(named: "Logo"), options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.3)),
                    .fromMemoryCacheOrRefresh
                    ])
            }

        }
    }
}

extension WLBannerImageView {
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImageView.snp.makeConstraints { (make) in
            
            make.left.top.right.bottom.equalTo(0)
        }
    }
}

