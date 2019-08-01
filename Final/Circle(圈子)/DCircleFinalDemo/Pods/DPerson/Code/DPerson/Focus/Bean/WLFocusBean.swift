//
//  WLFocusBean.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources
import DPrepare

public struct WLFocusBean: Mappable,IdentifiableType & Equatable {
    public var identity: String = ""
    
    public typealias Identity = String
    
    var intime: Int = Int.max
    
    public init?(map: Map) {
        
        
    }
    
    mutating public func mapping(map: Map) {
        
        identity <- map["encoded"]
        
        encoded <- map["encoded"]
        
        intime <- map["intime"]
        
        users <- map["users"]
        
        tableName <- map["tableName"]
        
        oUsEncoded <- map["oUsEncoded"]
        
        targetEncoded <- map["targetEncoded"]
        
        usEncoded <- map["usEncoded"]
        
        content <- map["content"]
    }
    var users: WLUserBean!
    
    var tableName: String = ""
    
    var oUsEncoded: String = ""
    
    var targetEncoded: String = ""
    
    var usEncoded: String = ""
    
    var content: String = ""
    
    var encoded: String = ""
}

