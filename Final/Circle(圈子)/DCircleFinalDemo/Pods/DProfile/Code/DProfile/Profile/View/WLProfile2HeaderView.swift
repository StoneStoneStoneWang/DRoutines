//
//  WLProfule2HeaderView.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/24.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Kingfisher
import WLToolsKit
import WLBaseTableView
import SnapKit

@objc (WLProfile2HeaderView)
public final class WLProfile2HeaderView: WLProfileHeaderView {
    
    public override var style: WLProfileStyle! {
        
        willSet {
            
            nameLabel.textAlignment = .center
            
            setNeedsDisplay()
        }
    }
}

extension WLProfile2HeaderView {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        topLine.snp.makeConstraints { (make) in
            
            make.left.top.right.equalToSuperview()
            
            make.height.equalTo(1)
        }
        
        iconImageView.snp.remakeConstraints { (make) in
            
            make.centerX.centerY.equalToSuperview()
            
            make.width.equalTo(70)
            
            make.height.equalTo(70)
        }
        
        nameLabel.snp.remakeConstraints { (make) in
            
            make.top.equalTo(iconImageView.snp.bottom).offset(15)
            
            make.centerX.equalTo(iconImageView.snp.centerX)
        }
        
        
    }
    
}
