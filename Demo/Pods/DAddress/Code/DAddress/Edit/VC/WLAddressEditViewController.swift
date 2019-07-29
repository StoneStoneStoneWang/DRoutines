//
//  WLAddressEditViewController.swift
//  DAddressDemo
//
//  Created by three stone 王 on 2019/7/17.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit

class WLAddressEditViewController: WLAddressEditBaseViewController {
    
    override func configOwnSubViews() {
        super.configOwnSubViews()
        
        tableView.register(WLAddressEditTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func configCell(_ tv: UITableView, ip: IndexPath, item: WLAddressEditBean) -> UITableViewCell {
        
        let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! WLAddressEditTableViewCell
        
        cell.type = item
        
        return cell
    }
}
