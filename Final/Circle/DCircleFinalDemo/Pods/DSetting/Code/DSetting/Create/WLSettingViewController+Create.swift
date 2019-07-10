//
//  WLSettingViewController+Create.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DLogin
import DPerson

extension WLSettingViewController {
    
    @objc (createLoginWithBlackStyle:andBlackConfig:andLoginStyle:andLoginConfig:)
    public static func createSetting(_ blackStyle: WLBlackListStyle ,blackConfig: WLBlackListConfig ,loginStyle: WLLoginStyle,loginConfig: WLLoginConfig) -> WLSettingViewController {
        
        switch blackStyle {
        case .one: return WLSettingViewController(blackStyle, blackConfig: blackConfig, loginStyle: loginStyle, loginConfig: loginConfig)
            
        }
    }
}
