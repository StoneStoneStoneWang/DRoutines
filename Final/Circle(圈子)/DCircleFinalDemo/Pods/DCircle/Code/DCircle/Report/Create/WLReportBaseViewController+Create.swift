//
//  WLReportBaseViewController+Create.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

extension WLReportBaseViewController {
    
    @objc (createReportWithStyle:andConfig:andUid:andEncoded:)
    public static func createReport(_ style: WLReportStyle ,config: WLReportConfig ,uid: String,encoded: String) -> WLReportBaseViewController {
        
        switch style {
        case .one: return WLReport1ViewController(style, config: config ,uid: uid, encoded: encoded)
            
        default: return WLReport1ViewController(style, config: config,uid: uid, encoded: encoded)
            
        }
    }
}
