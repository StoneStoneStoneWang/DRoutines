//
//  WLProfileSpringViewController.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/24.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLToolsKit

@objc (WLProfileSpringViewController)
public final class WLProfile3ViewController: WLProfileBaseViewController {
    
    public override func configOwnSubViews() {
        
        super.configOwnSubViews()
        
        profileHeader.bounds = CGRect(x: 0, y: 0, width: WL_SCREEN_WIDTH, height: WL_SCREEN_WIDTH / 2)
        
        tableView.tableHeaderView = profileHeader
        
    }
    
}
