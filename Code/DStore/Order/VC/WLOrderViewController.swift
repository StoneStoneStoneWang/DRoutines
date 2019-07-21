//
//  WLOrderViewController.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import UIKit

class WLOrderViewController: WLOrderBaseViewController {
    
    override func configOwnSubViews() {
        super.configOwnSubViews()
        
        tableView.register(WLOrderTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    override func configCell(_ tv: UITableView,ip: IndexPath,item: WLCommodityBean) -> UITableViewCell {
        
        let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! WLOrderTableViewCell
        
        cell.type = item
        
        return cell
    }
    override func onOrderClick(_ type: WLCommodityBean, ip: IndexPath) {
        
        
    }
}
