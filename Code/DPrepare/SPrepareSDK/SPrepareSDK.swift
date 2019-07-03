//
//  SPrepareSDK.swift
//  SPrepare
//
//  Created by three stone 王 on 2019/6/24.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
@objc (SPrepareSDK)
public final class SPrepareSDK: NSObject { }

extension SPrepareSDK {
    
    @objc (regAppkeyWithAppKey:andSignname:)
    public static func regAppkey(_ appkey: String ,signname: String) {
        
        WLGlobalManager.regAppkey(appkey, signname: signname)
    }
}

