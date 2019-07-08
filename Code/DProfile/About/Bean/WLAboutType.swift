//
//  WLAboutType.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLToolsKit

@objc (WLAboutType)
public enum WLAboutType: Int {
    
    case version
    
    case email
    
    case wechat
    
    case space
}

extension WLAboutType {
    
    static var types: [WLAboutType] {
        
        return [.space,.version,.email,.wechat]
    }
    
    var cellHeight: CGFloat {
        switch self {
        case .space: return 10
            
        default: return 55
            
        }
    }
    
    var title: String {
        
        switch self {
            
        case .version: return "版本号"
            
        case .email: return "官方邮箱"
            
        case .wechat: return "客服微信"
            
        case .space: return ""
        }
    }
    
    var subtitle: String {
        
        switch self {
            
        case .version: return "当前版本: \(Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String)"
            
        case .email:
            
            guard let info = Bundle.main.infoDictionary else { return "" }
            
            return (info["CFBundleDisplayName"] as? String ?? "").transformToPinYin() + "@163.com"
            
        case .wechat:
            
            guard let info = Bundle.main.infoDictionary else { return "" }
            
            return info["CFBundleDisplayName"] as? String ?? ""
            
        case .space: return ""
        }
    }
}
