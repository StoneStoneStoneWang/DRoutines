//
//  WLMapPublishBean.swift
//  WLMapkitDemo
//
//  Created by three stone 王 on 2019/5/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ObjectMapper

final class WLMapPublishBean: Mappable  {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        type <- map["type"]
        
        value  <- map["value"]
        
        place  <- map["place"]
    }
    
    var type: String = ""
    
    var value: String = ""
    
    var place: String = ""
}
