//
//  WLSettingType.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import DPrepare

public enum WLSettingType {
    
    case pwd // 未登录
    
    case password // 已登录
    
    case logout
    
    case clear
    
    case push
    
    case space
    
    case black
}

extension WLSettingType {
    
    static var types: [WLSettingType] {
        
        if WLAccountCache.default.isLogin() {
            
            return [.space,.password,.black,.space,.clear,.push,.space,.logout]
        } else {
            
            return [.space,.pwd,.space,.clear,.push]
        }
    }
    
    var title: String {
        
        switch self {
            
        case .pwd: return "忘记密码"
            
        case .password: return "修改密码"
            
        case .logout: return "退出登录"
            
        case .clear: return "清理缓存"
            
        case .push: return "推送设置"
            
        case .black: return "黑名单"
            
        default: return ""
            
        }
    }
    
    var cellHeight: CGFloat {
        
        switch self {
        case .space: return 10
            
        default: return 55
        }
    }
}
