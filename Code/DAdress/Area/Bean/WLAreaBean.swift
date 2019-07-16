//
//  WLAreaBean.swift
//  DAddressDemo
//
//  Created by three stone 王 on 2019/7/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources

public struct WLAreaBean: Mappable ,IdentifiableType & Equatable{
    
    public var identity: String = NSUUID().uuidString
    
    public typealias Identity = String
    
    var id: String = ""
    
    var aid: String = ""
    
    var pid: String = ""
    
    var name: String = ""
    
    var alif: String = ""
    
    var areacode: String = ""
    
    var arealevel: Int = 0
    
    var typename: String = ""
    
    var addrList: [WLAreaBean] = []
    
    public init?(map: Map) { }
    
    public mutating func mapping(map: Map) {
        
        id <- map["id"]
        
        aid <- map["aid"]
        
        pid <- map["pid"]
        
        name <- map["name"]
        
        alif <- map["alif"]
        
        areacode <- map["areacode"]
        
        arealevel <- map["arealevel"]
        
        typename <- map["typename"]
        
        addrList <- map["addrList"]
    }
    
    var isSelected: Bool = false
}
