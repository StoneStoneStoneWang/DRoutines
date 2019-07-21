//
//  WLOrderTableViewCell.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import UIKit
import WLToolsKit
import SnapKit
import Kingfisher

class WLOrderTableViewCell: WLOrderBaseTableViewCell {
    
    @objc (priceLabel)
    open var priceLabel: UILabel = UILabel().then {
        
        $0.tag = 2009
        
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        
        $0.textAlignment = .left
        
        $0.textColor = WLHEXCOLOR(hexColor: "#ff0000")
    }
    @objc (typeLabel)
    open var typeLabel: UILabel = UILabel().then {
        
        $0.tag = 2030
        
        $0.font = UIFont.boldSystemFont(ofSize: 17)
        
        $0.textAlignment = .left
        
        $0.textColor = WLHEXCOLOR(hexColor: "#333333")
    }
    
    override var type: WLCommodityBean! {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            let processor: ImageProcessor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 0)
            
            iconImageView.kf.indicatorType = .activity
            
            var media: WLKeyValueBean!
            
            for item in newValue.contentMap {
                
                if item.type == "txt" {
                    
                    if item.value.contains("Image:") {
                        
                        media = item
                        
                        break
                    }
                }
            }
            
            let icontemp = media.value.components(separatedBy: ":")
            
            let icon: String = icontemp[1] + ":" + icontemp[2] + "?x-oss-process=image/resize,w_500,h_500"
            
            iconImageView.kf.setImage(with: URL(string: icon), placeholder: UIImage(named: ""), options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.3)),
                .fromMemoryCacheOrRefresh
                ])
            
            var title: WLKeyValueBean!
            
            for item in newValue.contentMap {
                
                if item.type == "title" {
                    
                    title = item
                    
                    break
                }
            }
            
            titleLabel.text = title.value
            
            var price: WLKeyValueBean!
            
            for item in newValue.contentMap {
                
                if item.type == "txt" {
                    
                    if item.value.contains("Price") {
                        
                        price = item
                        
                        break
                    }
                }
            }
            
            let temp = price.value.components(separatedBy: ":")
            
            priceLabel.text = "¥ " + temp.last!
            
            typeLabel.text = "未发货"
        }
    }
    
    override func commitInit() {
        super.commitInit()
        
        contentView.addSubview(priceLabel)
        
        iconImageView.contentMode = .scaleAspectFill
        
        iconImageView.layer.masksToBounds = true
        
        contentView.addSubview(typeLabel)
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
        
        typeLabel.snp.makeConstraints { (make) in
            
            make.right.equalTo(-12)
            
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
    }
    
}
