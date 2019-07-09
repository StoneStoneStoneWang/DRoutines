//
//  WLCircle3ViewController.swift
//  WLCircleKitDemo
//
//  Created by three stone 王 on 2019/5/14.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit

public final class WLCircle3ViewController: WLCircleBaseViewController {
    
    public override func configOwnSubViews() {
        super.configOwnSubViews()
        
        tableView.register(WLCircle3TableViewCell.self, forCellReuseIdentifier: "cell3")
    }
    
    public override func caculateHeight(_ ip: IndexPath, item: WLCircleBean) -> CGFloat {
        
        if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
            
            if version > "1.1.0" {
                
                return 120 + 40
            }
        }
        
        return 120
    }
    public override func configCell(_ tv: UITableView, ip: IndexPath, item: WLCircleBean) -> UITableViewCell {
        
        let cell = tv.dequeueReusableCell(withIdentifier: "cell3") as! WLCircle3TableViewCell
        
        cell.type = (item,config)
        
        cell.mDelegate = self
        
        return cell
    }
}
