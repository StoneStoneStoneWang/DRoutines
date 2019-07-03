//
//  WLAccountBean.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ObjectMapper

public struct WLAccountBean: Mappable {
    
    public var token: String = ""
    
    public var phone: String = ""
    
    public var encoded: String = ""
    
    public var headImg: String = ""
    
    public var nickname: String = ""
    
    public var sex: Int = Int.max
    
    public var signature: String = ""
    
    public var birthday: String = ""
    
    public init?(map: Map) {
        
        
    }
    
    public mutating func mapping(map: Map) {
        
        nickname <- map["nickname"]
        
        headImg  <- map["headImg"]
        
        sex <- map["sex"]
        
        encoded  <- map["encoded"]
        
        signature  <- map["signature"]
        
        phone <- map["phone"]
        
        birthday <- map["birthday"]
        
        token  <- map["token"]
    }
    
    public init() { }
}
@objc(WLGenderType)
public enum WLGenderType: Int ,Codable {
    
    case unknown = 0
    
    case male = 1
    
    case female = 2
    
    init(temp: Int) {
        
        switch temp {
        case 1: self = .male
            
        case 2: self = .female
            
        default: self = .unknown
            
        }
    }
}
extension WLGenderType {
    
   public var gender: String {
        
        switch self {
        case .unknown: return "未设置"
        case .male: return "男"
        case .female: return "女"
        }
    }
}
