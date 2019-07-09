//
//  WLPublishConfig.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/6.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
@objc (WLPublishConfig)
public protocol WLPublishConfig {
    
    var itemColor: String { get }
    
    var textIcon: String { get }
    
    var imageIcon: String { get }
    
    var videoIcon: String { get }
    
    var broadIcon: String { get }
    
    var backIcon: String { get }
}
