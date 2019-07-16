//
//  WLMapTableView.swift
//  WLMapkitDemo
//
//  Created by three stone 王 on 2019/5/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseTableView

final class WLMapTableView: WLBaseTableView {
    
    override func commitInit() {
        super.commitInit()
        
        bounces = false
    }
}
