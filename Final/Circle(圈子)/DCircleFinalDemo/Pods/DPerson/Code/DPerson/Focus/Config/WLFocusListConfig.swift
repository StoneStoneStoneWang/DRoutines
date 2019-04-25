//
//  WLBlackListConfig.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

@objc (WLFocusListConfig)
public protocol WLFocusListConfig {
    
    var itemColor: String { get }
    
    var defaultIcon: String { get }
}
