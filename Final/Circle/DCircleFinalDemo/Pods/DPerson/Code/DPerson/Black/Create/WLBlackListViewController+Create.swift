//
//  WLBlackListViewController+Create.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

extension WLBlackListBaseViewController {
    
    @objc (createBlackListWithStyle:andConfig:)
    public static func createBlackList(_ style: WLBlackListStyle ,config: WLBlackListConfig) -> WLBlackListBaseViewController {
        
        switch style {
        case .one: return WLBlackList1ViewController(style, config: config)
            
        }
    }
}
