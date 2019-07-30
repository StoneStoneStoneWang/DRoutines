//
//  WLAddressSelectViewController.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLToolsKit
import DNotification

class WLAddressSelectViewController: WLAddressBaseViewController {
    
    override func configOwnSubViews() {
        super.configOwnSubViews()
        
        tableView.register(WLAddressSelectTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func configCell(_ tv: UITableView,ip: IndexPath,item: WLAddressBean) -> UITableViewCell {
        
        let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! WLAddressSelectTableViewCell
        
        cell.addressBean = item
        
        return cell
    }
    
    override func caculateHeight(_ ip: IndexPath,item: WLAddressBean) -> CGFloat {
        
        var height: CGFloat = 50
        
        let subText = item.plclne + item.cityne + item.regionne + item.addr
        
        height += subText.caculateHeight(CGSize(width: WL_SCREEN_WIDTH - 12 - 25, height: 999), fontSize: 13)
        
        height += 15
        
        return height
    }
    
    override func onAddressClick(_ address: WLAddressBean) {
        
        DNotificationConfigration.postNotification(withName: NSNotification.Name(rawValue: DNotificationAddressSelect), andValue: address.toJSON(), andFrom: self)
    }
}
