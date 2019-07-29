//
//  WLStoreOrderConfirmBean.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxDataSources
import WLToolsKit
import DAddress
@objc (WLStoreOrderConfirmType)
public enum WLStoreOrderConfirmType: Int {
    
    case address
    
    case commodity
    
    case contactUs
    
    case introduce
    
    case space
}


@objc (WLStoreOrderConfirmBean)
public class WLStoreOrderConfirmBean: NSObject ,IdentifiableType {
    
    public var identity: String = NSUUID().uuidString
    
    public typealias Identity = String
    
    var type: WLStoreOrderConfirmType = .address
    
    var address: WLAddressBean!
    
    var commodity: WLCommodityBean!
    
    var cellHeight: CGFloat {
        
        if type == .address {
            
            if let address = address {
                
                var height: CGFloat = 50
                
                let subText = address.plclne + address.cityne + address.regionne + address.addr
                
                height += subText.caculateHeight(CGSize(width: WL_SCREEN_WIDTH - 12 - 25, height: 999), fontSize: 13)
                
                height += 15
                
                return height
            }
            
            return 48
        } else if type == .commodity {
            
            return 100
        } else if type == .contactUs {
            
            return 48
        } else if type == .introduce {
            
            return 60
            
        }  else {
            
            return 10
        }
    }
}
