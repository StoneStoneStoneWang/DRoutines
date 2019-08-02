//
//  WLCommentBean.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources
import DPrepare

public struct WLCommentBean: Mappable,IdentifiableType & Equatable {
    
    
    public var identity: String = ""
    
    public typealias Identity = String
    
    public init?(map: Map) {
        
        
    }
    
    public init() {
        
        
    }
    
    public mutating func mapping(map: Map) {
        
        intime  <- map["intime"]
        
        content  <- map["content"]
        
        users  <- map["users"]
        
        encoded  <- map["encoded"]
        
        identity  <- map["encoded"]
    }
    
    var intime: String = ""
    
    var content: String = ""
    
    var users: WLUserBean!
    
    var encoded: String = ""
    
    var type: WLCommentType = .normal
    
    public enum WLCommentType: Int {
        
        case empty
        
        case normal
        
        case noMore
        
        case failed
        
        case total
        
        case rectangle
    }
}

