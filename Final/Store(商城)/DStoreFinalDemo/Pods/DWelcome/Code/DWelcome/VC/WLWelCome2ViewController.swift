//
//  WLWelCome2ViewController.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import SnapKit
import WLToolsKit

@objc (WLWelCome2ViewController)
public final class WLWelCome2ViewController: WLWelComeBaseViewController {
    
    override public func configOwnSubViews() {
        super.configOwnSubViews()
        
        skipItem.snp.makeConstraints { (make) in
            
            make.right.equalTo(-15)
            
            make.width.equalTo(80)
            
            make.top.equalTo(50)
            
            make.height.equalTo(30)
            
        }
        
        if let config = config {
            
            skipItem.layer.borderColor = WLHEXCOLOR(hexColor: config.itemColor).cgColor
            
            skipItem.setTitleColor(WLHEXCOLOR(hexColor: config.itemColor), for: .normal)
            
            skipItem.setTitleColor(WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)50"), for: .highlighted)
        }
        
        skipItem.layer.cornerRadius = 5
        
        skipItem.layer.masksToBounds = true
        
        skipItem.layer.borderWidth = 1
        
        skipItem.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
    }
}

