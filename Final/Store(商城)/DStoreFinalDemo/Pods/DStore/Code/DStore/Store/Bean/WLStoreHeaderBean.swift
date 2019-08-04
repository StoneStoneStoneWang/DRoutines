//
//  WLStoreHeaderBean.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ObjectMapper
public class WLStoreHeaderBean: Mappable{
    public required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        
        title <- map["title"]
        
        isSelected <- map["isSelected"]
        
        tag <- map["tag"]
    }
    
    var isSelected: Bool = false
    
    var title: String = ""
    
    var tag: String = ""
}
