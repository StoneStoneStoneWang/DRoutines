//
//  ViewController.swift
//  DAddressDemo
//
//  Created by three stone 王 on 2019/7/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import UIKit
import DPrepare
import WLToolsKit
import DLogin

class WLAddressConfigImpl: WLAddressConfig {
    var editIcon: String { return "" }
    
    var deleteIcon: String { return "" }
    
    var selectIcon: String { return "" }
    
    var deSelectIcon: String { return "" }
    
    var itemColor: String { return "#333333" }
}

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

class ViewController: WLF1DisposeViewController {
    
    @IBAction func asdds(_ sender: Any) {
        
        let login = checkLogin(.one, config: WLLoginConfigImpl())
        
        if login {
            
            let vc = WLAddressBaseViewController.createAddress(.list, config: WLAddressConfigImpl())
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .purple
    }
}

