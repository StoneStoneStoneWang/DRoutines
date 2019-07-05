//
//  WLBaseBean.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ObjectMapper

public struct WLBaseBean: Mappable {
    
    public init?(map: Map) {
        
    }
    
    mutating public func mapping(map: Map) {
        
        data <- map["data"]
        
        code <- map["state"]
        
        msg <- map["msg"]

    }
    /*
     返回数据
     */
    public var data: Any!
    /*
     返回码
     */
    public var code: WLServiceCode = .none
    /*
     返回msg
     */
    public var msg: String = ""
}

public enum WLServiceCode: String {
    
    case none = ""
    
    case succ = "success"
    
    case fail = "error"
    
    case tokenInvalid = "tokenInvalid"
}
