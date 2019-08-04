//
//  WLBuyViewController.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import UIKit

class WLBuyViewController: WLBuyBaseViewController {
    
    override func configOwnSubViews() {
        super.configOwnSubViews()
        
        tableView.register(WLBuyCommodityTableViewCell.self, forCellReuseIdentifier: "commodity")
        
        tableView.register(WLBuySpaceTableViewCell.self, forCellReuseIdentifier: "space")
    }
    
    override func configCell(_ tv: UITableView, ip: IndexPath, item: WLBuyBean) -> UITableViewCell {
        
        if item.type == .commodity {
            
            let cell = tv.dequeueReusableCell(withIdentifier: "commodity") as! WLBuyCommodityTableViewCell
            
            cell.type = item
            
            return cell
            
        }  else {
            
            let cell = tv.dequeueReusableCell(withIdentifier: "space") as! WLBuySpaceTableViewCell
            
            cell.type = item
            
            return cell
        }
    }
}
