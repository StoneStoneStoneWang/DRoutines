//
//  WLAboutConfig.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
@objc (WLAboutConfig)
public protocol WLAboutConfig {
    /* logo */
    var logo: String { get }
    /* 全局颜色 */
    /* 风格4 代表的是按钮或者文字的主颜色 */
    var itemColor: String { get }
}
