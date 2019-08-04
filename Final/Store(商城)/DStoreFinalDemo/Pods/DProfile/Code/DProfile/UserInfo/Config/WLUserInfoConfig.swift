//
//  WLUserInfoConfig.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
@objc (WLUserInfoConfig)
public protocol WLUserInfoConfig {
    /* logo */
    var logo: String { get }
    /* 全局颜色 */
    /* 风格4 代表的是按钮或者文字的主颜色 */
    var itemColor: String { get }
    /* 返回按钮icon */
    var backIcon: String { get }
    
    var defaultIcon: String { get }
}
