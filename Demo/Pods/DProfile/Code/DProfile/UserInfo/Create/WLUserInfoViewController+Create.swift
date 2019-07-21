//
//  WLUserInfoViewController+Create.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
extension WLUserInfoViewController {
    
    @objc (createUserInfoWithConfig:)
    public static func createUserInfo(_ config: WLUserInfoConfig) -> WLUserInfoViewController {
        
        return WLUserInfoViewController(config)
    }
}
