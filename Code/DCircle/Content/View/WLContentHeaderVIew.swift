//
//  WLContentHeaderVIew.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLToolsKit
import SnapKit
import Kingfisher
import WLBaseTableView
import DPrepare

@objc (WLContentHeaderVIew)
public final class WLContentHeaderVIew: WLBaseTableViewCell {
    
    public final var subtitleLabel: UILabel = UILabel().then {
        
        $0.tag = 2003
        
        $0.font = UIFont.systemFont(ofSize: 15)
        
        $0.textAlignment = .right
        
        $0.textColor = WLHEXCOLOR(hexColor: "#666666")
    }
    
    public var type: (WLUserBean,String)! {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            titleLabel.text = newValue.0.nickname
            
            subtitleLabel.text = newValue.1
            
            let processor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 30)
            
            iconImageView.kf.indicatorType = .activity
            
            let icon = newValue.0.headImg + "?x-oss-process=image/resize,w_200,h_200"
            
            iconImageView.kf.setImage(with: URL(string: icon), placeholder: UIImage(named: ""), options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.3)),
                .fromMemoryCacheOrRefresh
                ])
            
        }
    }
    
    override public func commitInit() {
        super.commitInit()
        
        iconImageView.layer.masksToBounds = true
        
        iconImageView.isUserInteractionEnabled = true
        
        iconImageView.contentMode = .center
        
        iconImageView.layer.cornerRadius = 15
        
        iconImageView.layer.borderWidth = 1
        
        contentView.addSubview(subtitleLabel)
        
    }
}

extension WLContentHeaderVIew {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        iconImageView.snp.makeConstraints { (make) in
            
            make.left.equalTo(15)
            
            make.centerY.equalToSuperview()
            
            make.width.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(iconImageView.snp.right).offset(15)
            
            make.bottom.equalTo(iconImageView.snp.centerY)
        }
        
        subtitleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(iconImageView.snp.right).offset(15)
            
            make.top.equalTo(iconImageView.snp.centerY)
        }
    }
}

