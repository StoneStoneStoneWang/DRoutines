//
//  WLSettingViewController+Create.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DLogin

extension WLSettingViewController {
    
    @objc (createLoginWithLoginStyle:andLoginConfig:)
    public static func createSetting(_ loginStyle: WLLoginStyle,loginConfig: WLLoginConfig) -> WLSettingViewController {
        
        return WLSettingViewController(loginStyle, loginConfig: loginConfig)
    }
}
