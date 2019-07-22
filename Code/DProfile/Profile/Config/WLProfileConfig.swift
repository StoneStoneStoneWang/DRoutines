//
//  WLProfileConfig.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
@objc (WLProfileConfig)
public protocol WLProfileConfig {
    /* logo */
    var logo: String { get }
    /* 全局颜色 */
    /* 风格4 代表的是按钮或者文字的主颜色 */
    var itemColor: String { get }
    
    var defaultIcon: String { get }
    
    var userInfoIcon: String { get }
    /* 关于我们icon */
    var aboutIcon: String { get }
    /* 设置icon */
    var settingIcon: String { get }
    /* 联系我们icon */
    var contactUsIcon: String { get }
    /* 隐私政策icon */
    var pravicyIcon: String { get }
    /* 我的关注icon */
    var focusIcon: String { get }
    
    var circleIcon: String { get }
    
    var phoneNum: String { get }
    
    var addressIcon: String { get }
}

