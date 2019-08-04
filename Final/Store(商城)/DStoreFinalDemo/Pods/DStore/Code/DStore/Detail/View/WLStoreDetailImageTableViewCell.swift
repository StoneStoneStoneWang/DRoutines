//
//  WLContentImageTableViewCell.swift
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

public class WLStoreDetailImageTableViewCell: WLBaseTableViewCell {
    
    var icon: String = "" {
        
        willSet {
            
            let processor: ImageProcessor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 0)
            
            iconImageView.kf.indicatorType = .activity
            
            var icon: String = ""
            
            if newValue.contains("Image:") {
                
                let icontemp = newValue.components(separatedBy: ":")
                
                icon = icontemp[1] + ":" + icontemp[2] + "?x-oss-process=image/resize,w_500,h_500"

            } else {
                
                icon = newValue + "?x-oss-process=image/resize,w_500,h_500"
            }
            
            self.iconImageView.kf.setImage(with: URL(string: icon), placeholder: UIImage.colorHexTransformToImage(colorHex: "#eeeeee"), options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.3)),
                .fromMemoryCacheOrRefresh
                ])
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImageView.snp.remakeConstraints { (make) in
            
            make.left.top.equalTo(15)
            
            make.bottom.right.equalTo(-15)
        }
    }
    
    public override func commitInit() {
        super.commitInit()
        
        iconImageView.layer.masksToBounds = true
    }
}
