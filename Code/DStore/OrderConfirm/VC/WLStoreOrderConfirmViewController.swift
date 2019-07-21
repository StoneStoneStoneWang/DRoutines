//
//  WLStoreOrderConfirmViewController.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import UIKit
import WLToolsKit
import WLThirdUtil.WLHudUtil


class WLStoreOrderConfirmViewController: WLStoreOrderConfirmBaseViewController {
    
    override func configOwnSubViews() {
        super.configOwnSubViews()
        
        tableView.register(WLStoreAddressTableViewCell.self, forCellReuseIdentifier: "address")
        
        tableView.register(WLStoreCommodityTableViewCell.self, forCellReuseIdentifier: "commodity")
        
        tableView.register(WLStoreContactUsTableViewCell.self, forCellReuseIdentifier: "contactUs")
        
        tableView.register(WLStoreIntroduceTableViewCell.self, forCellReuseIdentifier: "introduce")
        
        tableView.register(WLStoreSpaceTableViewCell.self, forCellReuseIdentifier: "space")
    }
    
    override func configCell(_ tv: UITableView, ip: IndexPath, item: WLStoreOrderConfirmBean) -> UITableViewCell {
        
        if item.type == .address {
            
            let cell = tv.dequeueReusableCell(withIdentifier: "address") as! WLStoreAddressTableViewCell
            
            cell.type = item
            
            return cell
        } else if item.type == .commodity {
            
            let cell = tv.dequeueReusableCell(withIdentifier: "commodity") as! WLStoreCommodityTableViewCell
            
            cell.type = item
            
            return cell
        } else if item.type == .contactUs {
            
            let cell = tv.dequeueReusableCell(withIdentifier: "contactUs") as! WLStoreContactUsTableViewCell
            
            cell.type = item
            
            return cell
        } else if item.type == .introduce {
            
            let cell = tv.dequeueReusableCell(withIdentifier: "introduce") as! WLStoreIntroduceTableViewCell
            
            cell.type = item
            
            return cell
        } else {
            
            let cell = tv.dequeueReusableCell(withIdentifier: "space") as! WLStoreSpaceTableViewCell
            
            cell.type = item
            
            return cell
        }
    }
    override func onStoreOrderConfirmClick(_ OrderConfirmBean: WLStoreOrderConfirmBean, ip: IndexPath) {
        
        switch OrderConfirmBean.type {
        case .address:
            
            let address = WLAddressBaseViewController.createAddress(.select, config: WLAddressConfigImpl())
            
            navigationController?.pushViewController(address, animated: true)
            
            address
                .rx
                .complete
                .subscribe(onNext: { [unowned self] (address) in
                    
                    var value = self.viewModel.input.tableData.value
                    
                    value[1].address = address
                    
                    self.viewModel.input.tableData.accept(value)
                })
                .disposed(by: disposed)
            
        case .contactUs:
            
            var phone: WLKeyValueBean!
            
            for item in OrderConfirmBean.commodity.contentMap {
                
                if item.type == "txt" {
                    
                    if item.value.contains("Phone") {
                        
                        phone = item
                        
                        break
                    }
                }
            }
            
            let temp = phone.value.components(separatedBy: ":")
            
            if !temp.last!.isEmpty  {
                
                WLOpenUrl.openUrl(urlString: "telprompt://\(temp.last!)")
            } else {
                
                WLHudUtil.showInfo("请确认使用的是iPhone，且安装有手机卡")
            }
        default: break
            
        }
    }
}
