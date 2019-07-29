//
//  WLAddressEditBean.swift
//  DAddressDemo
//
//  Created by three stone 王 on 2019/7/17.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import RxDataSources

@objc (WLAddressEditBean)
public class WLAddressEditBean: NSObject ,IdentifiableType{
    public var identity: String = NSUUID().uuidString
    
    public typealias Identity = String
    
    public var type: WLAddressEditType = .name
    
    public var value: String = ""
    
    public var pArea: WLAreaBean = WLAreaBean()
    
    public var cArea: WLAreaBean = WLAreaBean()
    
    public var rArea: WLAreaBean = WLAreaBean()
    
    public var isDef: Bool = true
    
    public static var editTypes: [WLAddressEditBean] {
        
        let name = WLAddressEditBean()
        
        name.type = .name
        
        let phone = WLAddressEditBean()
        
        phone.type = .phone
        
        let area = WLAddressEditBean()
        
        area.type = .area
        
        let detail = WLAddressEditBean()
        
        detail.type = .detail
        
        let def = WLAddressEditBean()
        
        def.type = .def
        
        def.isDef = true
        
        return [name,phone,area,detail,def]
    }
}

@objc (WLAddressEditType)
public enum WLAddressEditType:Int {
    case name
    
    case phone
    
    case area
    
    case detail
    
    case def
}

extension WLAddressEditType {
    
    public var title: String {
        
        switch self {
        case .name: return "收货人"
            
        case .phone: return "手机号码"
            
        case .area: return "所在地区"
            
        case .detail: return "详细地址"
            
        case .def: return "默认地址"
        }
    }
    
    public static var types: [WLAddressEditType] {
        
        return [.name,.phone,.area,.detail,.def]
    }
    
    public var placeholder: String {
        
        switch self {
        case .name: return "请填写收货人姓名"
            
        case .phone: return "请填写收货人手机号"
            
        case .area: return "请选择所在地区"
            
        case .detail: return "请填写街道、门牌号"
            
        case .def: return ""
            
        }
    }
    
    var cellHeight: CGFloat {
        
        return 48
    }
}
