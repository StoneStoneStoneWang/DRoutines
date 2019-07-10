//
//  WLCircle5ViewController.swift
//  WLCircleKitDemo
//
//  Created by three stone 王 on 2019/5/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLToolsKit

public final class WLCircle5ViewController: WLCircleBaseViewController {
    
    public override func configOwnSubViews() {
        super.configOwnSubViews()
        
        tableView.register(WLCircle5TableViewCell.self, forCellReuseIdentifier: "cell5")
    }
    
    public override func caculateHeight(_ ip: IndexPath, item: WLCircleBean) -> CGFloat {
        
        let h = item.contentMap.first!.value.caculateHeight(CGSize(width: view.bounds.width - 15 - 80, height: 999), fontSize: 15)
        
        let iw = view.bounds.width - 30
        
        let ih = iw * 7 / 16
        
        return h + ih + 10 + 20 + 15 + 10
    }
    
    public override func configCell(_ tv: UITableView, ip: IndexPath, item: WLCircleBean) -> UITableViewCell {
        
        let cell = tv.dequeueReusableCell(withIdentifier: "cell5") as! WLCircle5TableViewCell
        
        cell.type = (item,config)
        
        cell.mDelegate = self
        
        return cell
    }
}
