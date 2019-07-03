//
//  WLGlobalManager.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

final class WLGlobalManager {
    
    public static let `default`: WLGlobalManager = WLGlobalManager()
    
    private init() { }
    
    var signname: String = ""
    
    var appkey: String = ""
}

extension WLGlobalManager {
    
    static func regAppkey(_ appkey: String ,signname: String) {
        
        WLGlobalManager.default.appkey = appkey
        
        WLGlobalManager.default.signname = signname
    }
}
