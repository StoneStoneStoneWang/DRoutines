//
//  WLLoginConfig.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit

public let wl_login_margin: CGFloat = 15
@objc (WLLoginConfig)
public protocol WLLoginConfig {
    /* logo */
    var logo: String { get }
    /* 全局颜色 */
    /* 风格4 代表的是按钮或者文字的主颜色 */
    var itemColor: String { get }
    /* 手机号icon */
    var phoneIcon: String { get }
    /* 验证码icon */
    var vcodeIcon: String { get }
    /* 密码 */
    var passwordIcon: String { get }
    /* 密码 眼睛*/
    var passwordItemNIcon: String { get }
    /* 密码 眼睛*/
    var passwordItemSIcon: String { get }
    /* 返回按钮icon */
    var backIcon: String { get }
    // 当风格是3的时侯 请传入一个icon
    var goIcon: String { get }
}
