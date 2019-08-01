//
//  WLProfileViewController.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxDataSources
import WLToolsKit

@objc (WLProfileViewController)
public final class WLProfileViewController: WLProfileBaseViewController {
    
    override public func configOwnSubViews() {
        super.configOwnSubViews()
        
        profileHeader.frame = CGRect(x: 0, y: 0, width: WL_SCREEN_WIDTH, height: WL_SCREEN_WIDTH / 3)
        
        tableView.tableHeaderView = profileHeader
        
    }
}
