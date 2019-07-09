//
//  WLReportBean.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources

public struct WLReportBean: IdentifiableType & Equatable {
    
    public var identity: String
    
    public typealias Identity = String
    
    var title: String
    
    var isSelected: Bool
    
    var type: String = ""
    
    static var reports: [WLReportBean] {
        
        let ad = WLReportBean(identity: NSUUID().uuidString, title: "广告骚扰", isSelected: true, type: "1")
        
        let d = WLReportBean(identity: NSUUID().uuidString, title: "欺诈骗钱", isSelected: false, type: "2")
        
        let sexy = WLReportBean(identity: NSUUID().uuidString, title: "色情暴力", isSelected: false, type: "3")
        
        let trash = WLReportBean(identity: NSUUID().uuidString, title: "垃圾信息", isSelected: false, type: "4")
        
        let other = WLReportBean(identity: NSUUID().uuidString, title: "其他", isSelected: false, type: "5")
        
        return [ad,d,sexy,trash,other]
    }
}
