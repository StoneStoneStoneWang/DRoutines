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
    
    var titleCover: UIView = UIView(frame: .zero).then {
        
        $0.backgroundColor = WLHEXCOLOR(hexColor: "#333333")
        
        $0.alpha = 0.5
    }
    
    var titleLabel: UILabel = UILabel(frame: .zero).then {
        
        $0.tag = 2002
        
        $0.font = UIFont.systemFont(ofSize: 15)
        
        $0.textAlignment = .right
        
        $0.textColor = WLHEXCOLOR(hexColor: "#ffffff")
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
        
        contentView.addSubview(titleCover)
        
        contentView.addSubview(titleLabel)
    }
    
    var banner: WLBannerBean! {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            var title: WLBannerKeyValueBean!
            
            for item in newValue.contentMap {
                
                if item.type == "title" {
                    
                    title = item
                    
                    break
                }
            }
            
            titleLabel.text = title.value
            
            var image: WLBannerKeyValueBean!
            
            for item in newValue.contentMap {
                
                if item.type == "image" {
                    
                    image = item
                    
                    break
                }
            }
            
            let processor: ImageProcessor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 3)
            
            if let image = image {
                
                iconImageView.kf.indicatorType = .activity
                
                let icon: String = image.value + "?x-oss-process=image/resize,w_1600,h_800"
                
                self.iconImageView.kf.setImage(with: URL(string: icon), placeholder: UIImage(named: "Logo"), options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.3)),
                    .fromMemoryCacheOrRefresh
                    ])
                
            } else {
                
                for item in newValue.contentMap {
                    
                    if item.type == "txt" {
                        
                        if item.value.contains("Image:") {
                            
                            image = item
                            
                            break
                        }
                    }
                }
                
                iconImageView.kf.indicatorType = .activity
                
                let icontemp = image.value.components(separatedBy: ":")
                
                let icon = icontemp[1] + ":" + icontemp[2] + "?x-oss-process=image/resize,w_500,h_500"
                
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
        
        titleCover.snp.makeConstraints { (make) in
            
            make.left.right.bottom.equalToSuperview()
            
            make.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.bottom.equalToSuperview()
            
            make.height.equalTo(30)
            
            make.right.equalTo(-5)
        }
    }
}

