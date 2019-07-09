//
//  WLCircle2ViewController.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit

public final class WLCircle2ViewController: WLCircleBaseViewController {
    
    public override func configOwnSubViews() {
        super.configOwnSubViews()
        
        tableView.register(WLCircle2TableViewCell.self, forCellReuseIdentifier: "cell2")
    }
    
    public override func caculateHeight(_ ip: IndexPath, item: WLCircleBean) -> CGFloat {
        
        if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
            
            if version > "1.1.0" {
                
                return 100 + 40
            }
        }
        
        return 100
    }
    public override func configCell(_ tv: UITableView, ip: IndexPath, item: WLCircleBean) -> UITableViewCell {
        
        let cell = tv.dequeueReusableCell(withIdentifier: "cell2") as! WLCircle2TableViewCell
        
        cell.type = (item,config)
        
        cell.mDelegate = self
        
        return cell
    }
}
