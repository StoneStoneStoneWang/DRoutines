//
//  WLAddressBean.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources

public struct WLAddressBean: Mappable,IdentifiableType & Equatable {
    public var identity: String = ""
    
    public typealias Identity = String

    public init?(map: Map) { }
    
    mutating public func mapping(map: Map) {
        
        id <- map["id"]
        
        identity <- map["encoded"]
        
        encoded <- map["encoded"]
        
        intime <- map["intime"]
        
        isdel <- map["isdel"]
        
        phone <- map["phone"]
        
        plcl <- map["plcl"]
        
        plclne <- map["plclne"]
        
        city <- map["city"]
        
        cityne <- map["cityne"]
    
        region <- map["region"]
        
        name <- map["name"]
        
        addr <- map["addr"]
        
        cityne <- map["cityne"]
        
        regionne <- map["regionne"]

    }
    
    var id: Int = 0
    
    var intime: Int = Int.max
    
    var isdel: Bool = false
    
    var phone: String = ""
    
    var plcl: Int = 0
    
    var plclne: String = ""
    
    var city: Int = 0
    
    var cityne: String = ""
    
    var region: Int = 0
    
    var regionne: String = ""
    
    var encoded: String = ""
    
    var name: String = ""
    
    var addr: String = ""
    
    public init() { }
}
