//
//  WLFocusViewController.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit
import SnapKit

@objc (WLFocusViewController)
final class WLFocusViewController: WLFocusBaseViewController {
    
    override public func configOwnSubViews() {
        
        tableView.snp.makeConstraints { (make) in
            
            make.right.left.bottom.equalToSuperview()
            
            make.top.equalTo(WL_TOP_LAYOUT_GUARD)
        }
        
        tableView.separatorStyle = .none
        
        tableView.register(WLFocusList1TableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    public override func emptyViewShow() {
        
        self.tableView.emptyViewShow(WLFocusList1Empty())
    }
}
