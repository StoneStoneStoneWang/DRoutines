//
//  ViewController.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import UIKit
import DLogin

class WLLoginConfigImpl: WLLoginConfig {
    var logo: String { return "" }
    
    var itemColor: String { return "#333333" }
    
    var phoneIcon: String { return "" }
    
    var vcodeIcon: String { return "" }
    
    var passwordIcon: String { return "" }
    
    var passwordItemNIcon: String { return "" }
    
    var passwordItemSIcon: String { return "" }
    
    var backIcon: String { return "" }
    
    var goIcon: String { return "" }
}

class WLStoreConfigImpl: WLStoreConfig {
    var backIcon: String { return "" }
    
    
    var itemColor: String { return "#ff0000"}
}

class WLAddressConfigImpl: WLAddressConfig {
    var editIcon: String { return "" }
    
    var deleteIcon: String { return "" }
    
    var selectIcon: String { return "" }
    
    var deSelectIcon: String { return "" }
    
    var itemColor: String { return "#333333" }
}
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickcccc(_ sender: UIButton) {
        
        let aaaa = AAAAA()
//
        self.navigationController?.pushViewController(aaaa, animated: true)
        
//        let order = WLCartBaseViewController.createOrder("购物车", config: WLStoreConfigImpl(), addressConfig: WLAddressConfigImpl())
////            WLOrderBaseViewController.createOrder("订单")
//
//        self.navigationController?.pushViewController(order, animated: true)
    }
}
//,
//["title": "订单","isSelected": false,"tag": "订单"]
class AAAAA: UIViewController {
    
    var store: WLStoreCatagoryBaseViewController!
    
    var headers: [[String: Any]] = [["title": "纸","isSelected": true,"tag": "纸1"],
                                    ["title": "墨","isSelected": false,"tag": "墨1"],
                                    ["title": "笔","isSelected": false,"tag": "笔1"],
                                    ["title": "砚","isSelected": false,"tag": "砚1"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store = WLStoreCatagoryBaseViewController.createStore(WLStoreConfigImpl(),
                                                              headers: headers,
                                                              delegate: self)
        
        view.addSubview(store.view)
        
        addChild(store)
        
        store.view.frame = view.bounds
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: store.moreItem)
        
        store.moreItem.addTarget(self, action: #selector(onMoreItemClick), for: .touchUpInside)
    }
    @objc func onMoreItemClick() {
        
        let json = headers[store.currentIdx]
        
        let publish = WLPublishTableBaseViewController.createPublish(json["tag"] as! String, style: .image)
        
        self.navigationController?.pushViewController(publish, animated: true)
    }
}

extension AAAAA: WLStoreDelegate {
    func onCommodityClick(_ vc: UIViewController, storeJson: [String : Any]) {
        
        let login = checkLogin(.one, config: WLLoginConfigImpl())
        
        if login {
            
            let detal = WLStoreDetailBaseViewController.createStoreDetail(.one, config: WLStoreConfigImpl(), addressConfig: WLAddressConfigImpl(), storeJson: storeJson   )
            
            self.navigationController?.pushViewController(detal, animated: true)
        }
    }
}
