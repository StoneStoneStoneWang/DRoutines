//
//  WLComment1ViewController.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit

public final class WLComment1ViewController: WLCommentBaseViewController {
    
    
    public override func configOwnSubViews() {
        super.configOwnSubViews()
        
        tableView.mj_header.isHidden = true
        
        let f = UIView(frame: CGRect(x: 0, y: 1, width: view.bounds.width, height: 55))
        
        tableView.tableFooterView = f
    }
}
