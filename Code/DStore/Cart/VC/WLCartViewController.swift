//
//  WLCartViewController.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import UIKit

class WLCartViewController: WLCartBaseViewController {
    
    override func configOwnSubViews() {
        super.configOwnSubViews()
        
        tableView.register(WLCartTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    override func configCell(_ tv: UITableView,ip: IndexPath,item: WLCommodityBean) -> UITableViewCell {
        
        let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! WLCartTableViewCell
        
        cell.type = item
        
        return cell
    }
    override func onCartClick(_ type: WLCommodityBean, ip: IndexPath) {
        
        let orderConfirm = WLStoreOrderConfirmBaseViewController.createStoreOrder(config, addressConfig: addressConfig, commodity: type)
        
        self.navigationController?.pushViewController(orderConfirm, animated: true)
    }
}
