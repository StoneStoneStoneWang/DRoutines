//
//  WLCircleBean.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/30.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources
import WLToolsKit
import DPrepare

public class WLCircleBean: Mappable , IdentifiableType & Equatable{
    public static func == (lhs: WLCircleBean, rhs: WLCircleBean) -> Bool {
        
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
    
    var contentMap: [WLPublishBean] {
        
        let res = WLJsonCast.cast(argu: content) as! [[String: String]]
        
        return res.map({ WLPublishBean(JSON: $0)! })
    }
}
