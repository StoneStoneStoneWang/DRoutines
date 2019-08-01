//
//  WLProfile4ViewController.swift
//  SProfileDemo
//
//  Created by 张丽 on 2019/6/16.
//  Copyright © 2019 zhangli. All rights reserved.
//

import Foundation
import WLToolsKit

@objc (WLProfile4ViewController)
public final class WLProfile4ViewController: WLProfileBaseViewController {
    
    override public func configOwnSubViews() {
        super.configOwnSubViews()
        
        profileHeader.frame = CGRect(x: 0, y: 0, width: WL_SCREEN_WIDTH, height: WL_SCREEN_WIDTH / 3 * 2)
        
        tableView.tableHeaderView = profileHeader
    }
}
