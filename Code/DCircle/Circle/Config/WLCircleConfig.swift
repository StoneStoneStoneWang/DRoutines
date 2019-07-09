//
//  WLCircleConfig.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/7.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

@objc (WLCircleConfig)
public protocol WLCircleConfig {
    
    var itemColor: String { get }
    
    var defaultIcon: String { get }
    
    var watchIcon: String { get }
    
    var commentIcon: String { get }
    
    var funNIcon: String { get }
    
    var funSIcon: String { get }
    
    var moreIcon: String { get }

}
