//
//  WLProfile2ViewController.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/24.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit

@objc (WLProfile2ViewController)
public final class WLProfile2ViewController: WLProfileBaseViewController {
    
    override public func configOwnSubViews() {
        super.configOwnSubViews()
        
        profileHeader.frame = CGRect(x: 0, y: 0, width: WL_SCREEN_WIDTH, height: WL_SCREEN_WIDTH / 2)
        
        tableView.tableHeaderView = profileHeader
    }
}
