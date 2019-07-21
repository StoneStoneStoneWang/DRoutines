//
//  WLPublishTableView.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/6.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseTableView

public final class WLPublishTableView: WLBaseTableView {
    
    public override func commitInit() {
        super.commitInit()
        
        bounces = true
    }
}
