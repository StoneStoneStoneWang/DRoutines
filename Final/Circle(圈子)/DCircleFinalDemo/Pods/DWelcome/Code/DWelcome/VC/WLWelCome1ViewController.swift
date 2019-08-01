//
//  WLWelComeViewController.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import UIKit
import SnapKit
import WLToolsKit

@objc (WLWelCome1ViewController)
public final class WLWelCome1ViewController: WLWelComeBaseViewController {
    
    override public func configOwnSubViews() {
        super.configOwnSubViews()
        
        skipItem.snp.makeConstraints { (make) in
            
            make.width.equalTo(120)
            
            make.center.equalTo(pageControl.snp.center)
            
            make.height.equalTo(30)
        }
        
        skipItem.layer.cornerRadius = 5
        
        skipItem.layer.masksToBounds = true
        
        if let config = config {
            
            skipItem.layer.borderColor = WLHEXCOLOR(hexColor: config.itemColor).cgColor
            
            skipItem.setTitleColor(WLHEXCOLOR(hexColor: config.itemColor), for: .normal)
            
            skipItem.setTitleColor(WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)50"), for: .highlighted)
        }
        
        skipItem.layer.borderWidth = 1
        
        skipItem.setTitle("立即体验", for: .normal)
        
        skipItem.setTitle("立即体验", for: .highlighted)
        
        skipItem.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        
    }
    
}

