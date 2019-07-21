//
//  WLAddressListViewController.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLToolsKit

class WLAddressListViewController: WLAddressBaseViewController {
    
    override func configOwnSubViews() {
        super.configOwnSubViews()
        
        tableView.register(WLAddressListTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    override func configCell(_ tv: UITableView,ip: IndexPath,item: WLAddressBean) -> UITableViewCell {
        
        let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! WLAddressListTableViewCell
        
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
    
    override func configViewModel() {
        super.configViewModel()
        
        tableView
            .rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: { [unowned self] (ip) in
                
                let edit = WLAddressEditBaseViewController.createAddressEdit(self.config, isEdit: true, addressBean: self.dataSource[ip])
                
                self.navigationController?.pushViewController(edit, animated: true)
                
                edit
                    .rx
                    .complete
                    .subscribe(onNext: { [unowned self] (address) in
                        
                        var value = self.viewModel.output.tableData.value
                        
                        value.remove(at: ip.section)
                        
                        value.insert(address, at: 0)
                        
                        self.viewModel.output.tableData.accept(value)
                    })
                    .disposed(by: edit.disposed)
                
            })
            .disposed(by: disposed)
        
    }
}
