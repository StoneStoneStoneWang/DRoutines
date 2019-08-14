//
//  WLBannerBean.swift
//  DBannerDemo
//
//  Created by three stone 王 on 2019/8/2.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources
import WLToolsKit
import DPrepare

public struct WLBannerKeyValueBean: Mappable ,IdentifiableType & Equatable {
    public var identity: String = NSUUID().uuidString
    
    public typealias Identity = String
    
    public init?(map: Map) {
        
        
    }
    
    public mutating func mapping(map: Map) {
        
        type <- map["type"]
        
        value <- map["value"]
    }
    
    public init() {
        
    }
    
    var type:String = ""
    
    var value: String = ""
}


public class WLBannerBean: Mappable , IdentifiableType & Equatable{
    public static func == (lhs: WLBannerBean, rhs: WLBannerBean) -> Bool {
        
        return lhs.encoded == rhs.encoded
    }
    
    public var identity: String = ""
    
    public typealias Identity = String
    
    required public init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        
        identity <- map["encoded"]
        
        intime <- map["intime"]
        
        content  <- map["content"]
        
        isLaud  <- map["isLaud"]
        
        countLaud  <- map["countLaud"]
        
        tag  <- map["tag"]
        
        users  <- map["users"]
        
        countComment  <- map["countComment"]
        
        projectId  <- map["projectId"]
        
        encoded  <- map["encoded"]
    }
    
    var projectId: String = ""
    
    var encoded: String = ""
    
    var intime: Int = Int.max
    
    var content: String = ""
    
    var isLaud: Bool = false
    
    var countLaud: Int = Int.max
    
    var tag: String = ""
    
    var users: WLUserBean!
    
    var countComment: Int = Int.max
    
    var contentMap: [WLBannerKeyValueBean] {
        
        let res = WLJsonCast.cast(argu: content) as! [[String: String]]
        
        return res.map({ WLBannerKeyValueBean(JSON: $0)! })
    }
}
