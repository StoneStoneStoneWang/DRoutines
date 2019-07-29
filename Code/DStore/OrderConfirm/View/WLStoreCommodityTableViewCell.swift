//
//  WLStoreCommodityTableViewCell.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import SnapKit
import WLToolsKit
import Kingfisher

class WLStoreCommodityTableViewCell: WLStoreOrderConfirmBaseTableViewCell {
    
    @objc (priceLabel)
    open var priceLabel: UILabel = UILabel().then {
        
        $0.tag = 2009
        
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        
        $0.textAlignment = .left
        
        $0.textColor = WLHEXCOLOR(hexColor: "#ff0000")
    }
    
    override var type: WLStoreOrderConfirmBean! {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            let processor: ImageProcessor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 0)
            
            iconImageView.kf.indicatorType = .activity
            
            var media: WLKeyValueBean!
            
            var icon: String = ""
            
            
            for item in newValue.commodity.contentMap {
                
                if item.type == "image" {
                    
                    media = item
                    
                    break
                }
            }
            
            if media == nil {
                
                for item in newValue.commodity.contentMap {
                    
                    if item.type == "txt" {
                        
                        if item.value.contains("Image:") {
                            
                            media = item
                            
                            break
                        }
                    }
                }
                
                let icontemp = media.value.components(separatedBy: ":")
                
                icon = icontemp[1] + ":" + icontemp[2] + "?x-oss-process=image/resize,w_500,h_500"
            } else {
                
                icon = media.value + "?x-oss-process=image/resize,w_500,h_500"
            }
            
            iconImageView.kf.setImage(with: URL(string: icon), placeholder: UIImage(named: ""), options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.3)),
                .fromMemoryCacheOrRefresh
                ])
            
            var title: WLKeyValueBean!
            
            for item in newValue.commodity.contentMap {
                
                if item.type == "title" {
                    
                    title = item
                    
                    break
                }
            }
            
            titleLabel.text = title.value
            
            var price: WLKeyValueBean!
            
            for item in newValue.commodity.contentMap {
                
                if item.type == "txt" {
                    
                    if item.value.contains("Price") {
                        
                        price = item
                        
                        break
                    }
                }
            }
            
            
            if let price = price {
                
                let temp = price.value.components(separatedBy: ":")
                
                priceLabel.text = "¥ " + temp.last!
            }
            
        }
    }
    
    override func commitInit() {
        super.commitInit()
        
        contentView.addSubview(priceLabel)
        
        iconImageView.contentMode = .scaleAspectFill
        
        iconImageView.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImageView.snp.makeConstraints { (make) in
            
            make.left.top.equalTo(10)
            
            make.width.height.equalTo(bounds.height - 20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(iconImageView.snp.right).offset(10)
            
            make.top.equalTo(iconImageView.snp.top)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(iconImageView.snp.right).offset(10)
            
            make.bottom.equalTo(iconImageView.snp.bottom)
        }
    }
}
