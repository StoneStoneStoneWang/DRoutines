//
//  WLAreaCatagoryViewController.swift
//  DAddressDemo
//
//  Created by three stone 王 on 2019/7/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit

class WLAreaCatagoryViewController: WLBaseAreaCatagoryViewController {
    
    override open func configOwnSubViews() {
        super.configOwnSubViews()
        
        tableView.register(WLAreaCatagoryTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func configCell(_ tv: UITableView, ip: IndexPath, item: WLAreaBean) -> UITableViewCell {
        
        let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! WLAreaCatagoryTableViewCell
        
        cell.type = (item,config) as? (WLAreaBean, WLAddressConfig)
        
        return cell
    }
    
    override func onAreaClick(_ area: WLAreaBean, ip: IndexPath) {
        
        var idx: Int = 0
        
        for item in viewModel.output.tableData.value {
            
            if item.isSelected { break }
            
            idx += 1
        }
        
        for item in viewModel.output.tableData.value {
            
            item.isSelected = false
        }
        
        let oldValue = selectArea.value
        
        if !oldValue.name.isEmpty {
            
            tableView.reloadRows(at: [IndexPath(item: 0, section: idx)], with: .fade)
        }
        
        area.isSelected = true
        
        self.selectArea.accept(area)
        
        tableView.reloadRows(at: [ip], with: .fade)
    }
    
    override func caculateHeight(_ ip: IndexPath, item: WLAreaBean) -> CGFloat {
        
        return 44
    }
}
