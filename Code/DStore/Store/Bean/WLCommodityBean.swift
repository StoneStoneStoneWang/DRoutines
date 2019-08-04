//
//  WLCommodityBean.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources
import WLToolsKit
import DPrepare

public class WLCommodityBean: Mappable , IdentifiableType & Equatable{
    public static func == (lhs: WLCommodityBean, rhs: WLCommodityBean) -> Bool {
        
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
    
    var contentMap: [WLKeyValueBean] {
        
        let res = WLJsonCast.cast(argu: content) as! [[String: String]]
        
        return res.map({ WLKeyValueBean(JSON: $0)! })
    }
    
    var imgs: [WLKeyValueBean] {
        
        var result: [WLKeyValueBean] = []
        
        for item in contentMap {
            
            if item.type == "image" {
                
                result += [item]
            }
        }
        
        if result.isEmpty {
            
            for item in contentMap {
                
                if item.type == "txt" && item.value.contains("Image:") {
                    
                    result += [item]
                }
            }
        }
        
        
        return result
    }
}

public struct WLKeyValueBean: Mappable ,IdentifiableType & Equatable {
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
