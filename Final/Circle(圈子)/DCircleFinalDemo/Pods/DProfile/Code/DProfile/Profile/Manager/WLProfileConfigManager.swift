//
//  WLProfileManager.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/23.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

public final class WLProfileConfigManager {
    
    public static let `default`: WLProfileConfigManager = WLProfileConfigManager()
    
    private init() {}
    
    public var config: WLProfileConfig!

}
