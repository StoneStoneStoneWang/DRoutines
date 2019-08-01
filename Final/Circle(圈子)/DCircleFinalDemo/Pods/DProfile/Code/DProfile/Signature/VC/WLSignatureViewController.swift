//
//  WLSignatureViewController.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/17.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit
import WLBaseViewController

@objc (WLSignatureViewController)
public final class WLSignatureViewController: WLSignatureBaseViewController {
    
    override public func configNaviItem() {
        super.configNaviItem()
        
        if let config = config ,let nconfig = WLNaviConfig.shared.config {
            
            if nconfig.NaviBackground_HEXColor != "#ffffff" {
                
                completeItem.setTitleColor(WLHEXCOLOR(hexColor: "#ffffff"), for: .normal)
                
                completeItem.setTitleColor(WLHEXCOLOR(hexColor: "#ffffff"), for: .highlighted)
                
                completeItem.setTitleColor(WLHEXCOLOR_ALPHA(hexColor: "#ffffff" + "60"), for: .disabled)

            } else {
                
                completeItem.setTitleColor(WLHEXCOLOR(hexColor: config.itemColor), for: .normal)
                
                completeItem.setTitleColor(WLHEXCOLOR(hexColor: config.itemColor), for: .highlighted)
                
                completeItem.setTitleColor(WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60"), for: .disabled)
            }
        }
    }
    
    override public func addOwnSubViews() {
        
        view.addSubview(signaturetv)
    }
    override public func configOwnSubViews() {
        
        signaturetv.frame = CGRect(x: 0, y: WL_TOP_LAYOUT_GUARD + 10, width: view.bounds.width, height: 120)
        
        signaturetv.text = signature.value
    }
}

