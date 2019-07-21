//
//  WLBuyBean.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import RxDataSources

@objc (WLBuyType)
public enum WLBuyType: Int {
    
    case commodity
    
    case space
}


@objc (WLBuyBean)
public class WLBuyBean: NSObject ,IdentifiableType {
    
    public var identity: String = NSUUID().uuidString
    
    public typealias Identity = String
    
    var type: WLBuyType = .commodity
    
    var commodity: WLCommodityBean!
    
    var cellHeight: CGFloat {
        
        if type == .commodity {
            
            return 100
        } else {
            
            return 10
        }
    }
}
