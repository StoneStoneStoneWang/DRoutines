//
//  ViewController.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import UIKit
import DLogin
import DAddress
import DNotification
import WLBaseViewController
import WLToolsKit

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

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let aaaa = AAAAA()
        
        addChildVC(childVC: aaaa, title: "商城", fontSize: 12, titleColor: WLHEXCOLOR(hexColor: "#333333"), highColor: WLHEXCOLOR(hexColor: "#333333"), imageName: "", selectedImageName: "")
        
        let cart = WLCartBaseViewController.createOrder("购物车", config: WLStoreConfigImpl(), addressConfig: WLAddressConfigImpl())
        
        addChildVC(childVC: cart, title: "购物车", fontSize: 12, titleColor: WLHEXCOLOR(hexColor: "#333333"), highColor: WLHEXCOLOR(hexColor: "#333333"), imageName: "", selectedImageName: "")
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickcccc(_ sender: UIButton) {
        
        let login = checkLogin(.one, config: WLLoginConfigImpl())
        
        if login {
            
            let aaaa = AAAAA()
            //
            self.navigationController?.pushViewController(aaaa, animated: true)
        }
        
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
    
    var headers: [[String: Any]] = [["title": "上衣","isSelected": true,"tag": "上衣11"],
                                    ["title": "裤子","isSelected": false,"tag": "裤子1"],
                                    ["title": "裙子","isSelected": false,"tag": "裙子1"],
                                    ["title": "鞋子","isSelected": false,"tag": "鞋子1"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store = WLStoreCatagoryBaseViewController.createStore(.one, config: WLStoreConfigImpl(), headers: headers)
        
        
        view.addSubview(store.view)
        
        addChild(store)
        
        store.view.frame = view.bounds
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: store.moreItem)
        
        store.moreItem.addTarget(self, action: #selector(onMoreItemClick), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onStoreClick), name: NSNotification.Name(rawValue: DNotificationStoreClick), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onStoreConfirmClick), name: NSNotification.Name(rawValue: DNotificationStoreOrder), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onStoreCartClick), name: NSNotification.Name(rawValue: DNotificationStoreCart), object: nil)
    }
    @objc func onStoreClick(_ noti: NSNotification) {
        
        if let userInfo = noti.userInfo {
            
            let login = checkLogin(.one, config: WLLoginConfigImpl())
            
            if login {
                
                if let value = userInfo["value"] as? [String : Any],let from = userInfo["from"] as? UIViewController {
                    
                    let storeJson = value
                    
                    let detail = WLStoreDetailBaseViewController.createStoreDetail(.one, config: WLStoreConfigImpl(), addressConfig: WLAddressConfigImpl(), storeJson: storeJson)
                    
                    from.navigationController?.pushViewController(detail, animated: true)
                    
                }
            }
        }
    }
    
    @objc func onStoreCartClick(_ noti: NSNotification) {
        
        if let userInfo = noti.userInfo {
            
            let login = checkLogin(.one, config: WLLoginConfigImpl())
            
            if login {
                
                if let value = userInfo["value"] as? [String : Any],let from = userInfo["from"] as? UIViewController {
                    
                    let detail = WLStoreOrderConfirmBaseViewController.createStoreOrder(WLStoreConfigImpl(), addressConfig: WLAddressConfigImpl(), storeJson: value["storeJson"] as! [String : Any])
                    
                    from.navigationController?.pushViewController(detail, animated: true)
                }
            }
        }
    }
    
    @objc func onStoreConfirmClick(_ noti: NSNotification) {
        
        if let userInfo = noti.userInfo {
            
            let login = checkLogin(.one, config: WLLoginConfigImpl())
            
            if login {
                
                if let value = userInfo["value"] as? [String : Any],let from = userInfo["from"] as? UIViewController {
                    
                    let confirm = WLStoreOrderConfirmBaseViewController.createStoreOrder(WLStoreConfigImpl(), addressConfig:WLAddressConfigImpl(), commodity: WLCommodityBean(JSON: value)!)
                    
                    from.navigationController?.pushViewController(confirm, animated: true)
                }
            }
        }
    }
    
    @objc func onMoreItemClick() {
        
        let json = headers[store.currentIdx]
        
        
        //        let publish = WLPublishTableBaseViewController.createPublish(json["tag"] as! String, style: .image)
        //
        //        self.navigationController?.pushViewController(publish, animated: true)
    }
}

extension AAAAA {
    func onCommodityClick(_ vc: UIViewController, storeJson: [String : Any]) {
        
        let login = checkLogin(.one, config: WLLoginConfigImpl())
        
        if login {
            
            let detal = WLStoreDetailBaseViewController.createStoreDetail(.one, config: WLStoreConfigImpl(), addressConfig: WLAddressConfigImpl(), storeJson: storeJson   )
            
            self.navigationController?.pushViewController(detal, animated: true)
        }
    }
}
