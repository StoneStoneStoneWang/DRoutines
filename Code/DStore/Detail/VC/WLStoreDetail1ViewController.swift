//
//  WLStoreDetail1ViewController.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit

public final class WLStoreDetail1ViewController: WLStoreDetailBaseViewController {
    
    public override func configOwnSubViews() {
        super.configOwnSubViews()
        
        tableView.mj_header.isHidden = true
        
        tableView.mj_footer.isHidden = true
        
    }
}
