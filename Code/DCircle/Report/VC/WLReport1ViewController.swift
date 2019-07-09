//
//  WLReport1ViewController.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit
import WLBaseViewController

public final class WLReport1ViewController: WLReportBaseViewController {
    
    
    override public func configNaviItem() {
        super.configNaviItem()
        
        title = "举报"
        
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
}
