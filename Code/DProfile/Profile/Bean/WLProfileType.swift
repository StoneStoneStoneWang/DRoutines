//
//  WLProfileType.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import DRoutinesKit

@objc (WLProfileType)
public enum WLProfileType : Int{
    
    case about
    
    case userInfo
    
    case setting
    
    case contactUS
    
    case pravicy
    
    case focus
    
    case space
    
    case myCircle
    
    case order
    
    case address
}

extension WLProfileType {
    
    static var types: [WLProfileType] {
        
        if DConfigure.fetchPType() == .store {
            
            return [.space,userInfo,.order,.address,.space,.contactUS,.pravicy,.about,.space,.setting]
        } else {
            
            if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
                
                if version > "1.1.0" {
                    
                    return [.space,userInfo,.myCircle,.focus,.space,.contactUS,.pravicy,.about,.space,.setting]
                }
            }
            
            return [.space,userInfo,.space,.contactUS,.pravicy,.about,.space,.setting]
        }
    }
    
    var cellHeight: CGFloat {
        
        switch self {
        case .space: return 10
            
        default: return 55
        }
    }
    
    var icon: String {
        
        switch self {
            
        case .about: return WLProfileConfigManager.default.config.aboutIcon
            
        case .setting: return WLProfileConfigManager.default.config.settingIcon
            
        case .contactUS: return WLProfileConfigManager.default.config.contactUsIcon
            
        case .userInfo: return WLProfileConfigManager.default.config.userInfoIcon
            
        case .pravicy: return WLProfileConfigManager.default.config.pravicyIcon
            
        case .focus: return WLProfileConfigManager.default.config.focusIcon
            
        case .myCircle: return WLProfileConfigManager.default.config.circleIcon
            
        case .address: return WLProfileConfigManager.default.config.addressIcon
            
        case .order: return WLProfileConfigManager.default.config.orderIcon
            
        case .space: return ""
            
        }
    }
    
    var title: String {
        
        switch self {
            
        case .about: return "关于我们"
            
        case .contactUS: return "联系我们"
            
        case .userInfo: return "用户资料"
            
        case .setting: return "设置"
            
        case .pravicy: return "隐私政策"
            
        case .focus: return "我的关注"
            
        case .myCircle: return "我的发布"
            
        case .address: return "我的地址"
            
        case .order: return "我的订单"
            
        default: return ""
            
        }
    }
    
    var subTitle: String {
        
        switch self {
        case .contactUS: return WLProfileConfigManager.default.config.phoneNum
            
        default: return ""
            
        }
    }
}
