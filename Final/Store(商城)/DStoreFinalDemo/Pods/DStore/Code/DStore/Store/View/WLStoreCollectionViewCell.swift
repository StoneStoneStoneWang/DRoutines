//
//  WLStoreCollectionViewCell.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import UIKit
import Kingfisher
import WLToolsKit
import SnapKit

class WLStoreCollectionViewCell: UICollectionViewCell {
    
    @objc (iconImageView)
    open var iconImageView: UIImageView = UIImageView().then {
        
        $0.contentMode = .scaleAspectFill
        
        $0.tag = 2001
    }
    @objc (titleLabel)
    open var titleLabel: UILabel = UILabel().then {
        
        $0.tag = 2002
        
        $0.font = UIFont.systemFont(ofSize: 15)
        
        $0.textAlignment = .left
        
        $0.textColor = WLHEXCOLOR(hexColor: "#333333")
    }
    
    @objc (priceLabel)
    open var priceLabel: UILabel = UILabel().then {
        
        $0.tag = 2009
        
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        
        $0.textAlignment = .left
        
        $0.textColor = WLHEXCOLOR(hexColor: "#ff0000")
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
        
        contentView.addSubview(iconImageView)
        
        iconImageView.contentMode = .scaleAspectFill
        
        iconImageView.layer.masksToBounds = true
        
        backgroundColor = .white
        
        contentView.addSubview(priceLabel)
    }
    
    var commodity: WLCommodityBean! {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            let processor: ImageProcessor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 0)
            
            iconImageView.kf.indicatorType = .activity
            
            var media: WLKeyValueBean!
            
            for item in newValue.contentMap {
                
                if item.type == "image" {
                    
                    media = item
                    
                    break
                }
            }
            
            var icon: String = ""
            
            if media == nil {
                
                for item in newValue.contentMap {
                    
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
            
            if let price = price {
                
                let temp = price.value.components(separatedBy: ":")
                
                priceLabel.text = "¥ " + temp.last!
            }
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImageView.snp.makeConstraints { (make) in
            
            make.left.right.top.equalToSuperview()
            
            make.height.equalTo(bounds.width)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(8)
            
            make.top.equalTo(iconImageView.snp.bottom)
            
            make.height.equalTo(30)
            
            make.right.equalTo(-8)
        }
        priceLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(8)
            
            make.top.equalTo(titleLabel.snp.bottom)
            
            make.height.equalTo(30)
            
            make.right.equalTo(-8)
        }
    }
}
