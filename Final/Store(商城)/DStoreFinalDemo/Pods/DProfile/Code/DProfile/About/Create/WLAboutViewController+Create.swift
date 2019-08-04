//
//  WLAboutViewController+Create.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

extension WLAboutViewController {
    
    @objc (createAboutWithConfig:)
    public static func createAbout(_ config: WLAboutConfig) -> WLAboutViewController {
        
        return WLAboutViewController(config)
    }
}
