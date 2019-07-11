//
//  WLContentVideoTableViewCell.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseTableView
import SnapKit
import WLToolsKit
import Kingfisher

public class WLContentVideoTableViewCell: WLBaseTableViewCell {
    
    var broadItem: UIButton = UIButton(type: .custom)
    
    var icon: String = "" {
        
        willSet {
            
            var processor: ImageProcessor!
            
            if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
                
                if version > "1.1.0" {
                    
                    processor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 0)
                } else {
                    
                    processor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 5)
                }
            } else {
                
                processor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 5)
            }
            
            iconImageView.kf.indicatorType = .activity
            
            let res: String = newValue + "?x-oss-process=image/resize,w_800,h_600"
            
            self.iconImageView.kf.setImage(with: URL(string: res), placeholder: UIImage.colorHexTransformToImage(colorHex: "#eeeeee"), options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.3)),
                .fromMemoryCacheOrRefresh
                ])
        }
    }
    
    public override func commitInit() {
        super.commitInit()
        
        contentView.addSubview(broadItem)
        
        iconImageView.layer.masksToBounds = true
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImageView.snp.remakeConstraints { (make) in
            
            make.left.top.equalTo(15)
            
            make.bottom.right.equalTo(-15)
        }
        
        broadItem.snp.remakeConstraints { (make) in
            
            make.center.equalTo(iconImageView.snp.center)
        }
    }
}
