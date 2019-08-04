//
//  WLWelComeConfig.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

@objc (WLWelComeConfig)
public protocol WLWelComeConfig {
    
    var welcomeImgs: [String] { get }
    
    var itemColor: String { get }
}
