//
//  WLAddressConfig.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

@objc (WLAddressConfig)
public protocol WLAddressConfig {
    
    var editIcon: String { get }
    
    var deleteIcon: String { get }
    
    var selectIcon: String { get }
    
    var deSelectIcon: String { get }
    
    var itemColor: String { get }
}
