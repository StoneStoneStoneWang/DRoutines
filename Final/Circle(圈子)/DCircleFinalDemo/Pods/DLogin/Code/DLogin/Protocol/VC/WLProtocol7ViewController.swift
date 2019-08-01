//
//  WLProtocol7ViewController.swift
//  SRegDemo
//
//  Created by three stone 王 on 2019/6/11.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewController
import WLToolsKit

@objc (WLProtocol7ViewController)
class WLProtocol7ViewController: WLProtocolBaseViewController {
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let config = WLNaviConfig.shared.config {
            
            navigationController?.navigationBar.wl_setBackgroundColor(WLHEXCOLOR(hexColor: config.NaviBackground_HEXColor))
            
            navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: config.Title_FontSize),
                NSAttributedString.Key.foregroundColor: WLHEXCOLOR(hexColor: config.Title_HEXColor)
            ]
        }
    }
}
