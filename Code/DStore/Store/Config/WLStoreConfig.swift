//
//  WLStoreConfig.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
@objc (WLStoreConfig)
public protocol WLStoreConfig {
    
    var itemColor: String { get }
    
    var backIcon: String { get }
}