//
//  WLMapConfig.swift
//  WLMapkitDemo
//
//  Created by three stone 王 on 2019/5/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
@objc (WLMapConfig)
public protocol WLMapConfig {
    
    var pubs: [[String: String]] { get }
    
    var itemColor: String { get }
    
    var itemTitle: String { get }
    
    var locaitonIcon: String { get }
    
    var annotationIcon: String { get }
}
