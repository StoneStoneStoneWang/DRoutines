//
//  WLUserInfoType.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit

public final class WLUserInfoBean {
    
    var type: WLUserInfoType = .header
    
    var img: UIImage!
    
    var subtitle: String = ""
    
    static var types: [WLUserInfoBean] {
        
        let space = WLUserInfoBean()
        
        space.type = .space
        
        let header = WLUserInfoBean()
        
        header.type = .header
        
        let name = WLUserInfoBean()
        
        name.type = .name
        
        let phone = WLUserInfoBean()
        
        phone.type = .phone
        
        let sex = WLUserInfoBean()
        
        sex.type = .sex
        
        let birth = WLUserInfoBean()
        
        birth.type = .birth
        
        let signature = WLUserInfoBean()
        
        signature.type = .signature
        
        return [space ,header ,name ,phone ,space ,sex ,birth ,signature]
    }
}
@objc (WLUserInfoType)
public enum WLUserInfoType: Int {
    
    case header
    
    case name
    
    case phone
    
    case sex
    
    case signature
    
    case birth
    
    case space
}


extension WLUserInfoType {
    
    static var types: [WLUserInfoType] {
        
        return [.space ,.header ,.name ,.phone ,.space ,.sex ,.birth ,.signature]
    }
    
    var title: String {
        
        switch self {
            
        case .header: return "头像"
            
        case .name: return "昵称"
            
        case .phone: return "手机号"
            
        case .sex: return "性别"
            
        case .signature: return "个性签名"
            
        case .birth: return "生日"
            
        case .space: return ""
            
        }
    }
    
    var cellHeight: CGFloat {
        switch self {
        case .space: return 10
            
        case .header: return 80
            
        default: return 55
            
        }
    }
    
    var updateKey: String {
        
        switch self {
        case .name: return "users.nickname"
            
        case .birth: return "users.birthday"
            
        case .signature: return "users.signature"
            
        case .sex: return "users.sex"
            
        case .header: return "users.headImg"
        default: return ""
            
        }
    }
}
