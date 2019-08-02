//
//  WLPublishBean.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/30.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources

public struct WLPublishBean: Mappable ,IdentifiableType & Equatable {
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
    
    var img: UIImage?
}
