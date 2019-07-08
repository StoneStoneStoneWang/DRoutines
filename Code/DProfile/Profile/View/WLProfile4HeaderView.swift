//
//  WLProfile4HeaderView.swift
//  SProfileDemo
//
//  Created by 张丽 on 2019/6/16.
//  Copyright © 2019 zhangli. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Kingfisher
import WLToolsKit
import WLBaseTableView
import SnapKit

@objc (WLProfile4HeaderView)
public final class WLProfile4HeaderView: WLProfileHeaderView {
        
    public override var style: WLProfileStyle! {
        
        willSet {
            
            nameLabel.textAlignment = .center
            
            setNeedsDisplay()
        }
    }
}

extension WLProfile4HeaderView {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        topLine.snp.makeConstraints { (make) in
            
            make.left.top.right.equalToSuperview()
            
            make.height.equalTo(1)
        }
        
        iconImageView.snp.remakeConstraints { (make) in
            
            make.centerX.equalToSuperview()
            
            make.centerY.equalToSuperview().offset(-15)
            
            make.width.equalTo(100)
            
            make.height.equalTo(100)
        }
        
        nameLabel.snp.remakeConstraints { (make) in
            
            make.top.equalTo(iconImageView.snp.bottom).offset(15)
            
            make.centerX.equalTo(iconImageView.snp.centerX)
        }
        
        // 重新赋值iconImageView的切圆
        iconImageView.layer.cornerRadius = iconImageView.frame.size.width * 0.5
        iconImageView.layer.borderWidth = 1
        
        // 重新赋值name字号
        nameLabel.font =  UIFont.systemFont(ofSize: 17)
    }
    
}
