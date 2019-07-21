//
//  WLTextEditViewController.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/17.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit
import WLBaseViewController

@objc (WLTextEditViewController)
public final class WLTextEditViewController: WLTextEditBaseViewController {
    
    override public func configNaviItem() {
        super.configNaviItem()
        
        if let nconfig = WLNaviConfig.shared.config {
            
            if nconfig.NaviBackground_HEXColor != "#ffffff" {
                
                completeItem.setTitleColor(WLHEXCOLOR(hexColor: "#ffffff"), for: .normal)
                
                completeItem.setTitleColor(WLHEXCOLOR(hexColor: "#ffffff"), for: .highlighted)
                
                completeItem.setTitleColor(WLHEXCOLOR_ALPHA(hexColor: "#ffffff" + "60"), for: .disabled)
                
            } else {
                
                completeItem.setTitleColor(WLHEXCOLOR(hexColor: "#333333"), for: .normal)
                
                completeItem.setTitleColor(WLHEXCOLOR(hexColor: "#333333"), for: .highlighted)
                
                completeItem.setTitleColor(WLHEXCOLOR_ALPHA(hexColor: "#333333" + "60"), for: .disabled)
            }
        }
    }
    
    override public func addOwnSubViews() {
        
        view.addSubview(texttv)
    }
    override public func configOwnSubViews() {
        
        texttv.frame = CGRect(x: 0, y: WL_TOP_LAYOUT_GUARD + 10, width: view.bounds.width, height: view.bounds.height / 2)
    }
    
}

