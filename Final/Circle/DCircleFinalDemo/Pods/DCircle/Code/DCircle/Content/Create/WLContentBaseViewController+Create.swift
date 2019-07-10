//
//  WLContentBaseViewController+Create.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

extension WLContentBaseViewController {
    
    @objc (createPublishWithStyle:andConfig:andCircleJson:)
    public static func createContent(_ style: WLContentStyle ,config: WLContentConfig,circleJson: [String: Any]) -> WLContentBaseViewController {
        
        switch style {
            
        case .one: return WLContent1ViewController(style ,config: config,circleJson: circleJson)
            
        default: return WLContent1ViewController( style ,config: config,circleJson: circleJson)
            
        }
    }
}
