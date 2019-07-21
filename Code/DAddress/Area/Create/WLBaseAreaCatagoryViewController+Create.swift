//
//  WLBaseAreaCatagoryViewController+Create.swift
//  DAddressDemo
//
//  Created by three stone 王 on 2019/7/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import WLBaseViewController

extension WLBaseAreaCatagoryViewController {
    
    public static func createAreaCatagory(_ areas: [WLAreaBean] ,config: WLAddressConfig,selectedAreaId: Int) -> WLBaseAreaCatagoryViewController {
        
        return WLAreaCatagoryViewController(areas, config: config, selectedAreaId: selectedAreaId)
    }
    
    @objc public static func createAreaCatagory(_ areas: [[String: Any]] ,config: WLAddressConfig,selectedAreaId: Int) -> WLBaseAreaCatagoryViewController {
        
        var result: [WLAreaBean] = []
        
        for item in areas {
            
            result += [WLAreaBean(JSON: item )!]
        }
        
        return WLAreaCatagoryViewController(result, config: config, selectedAreaId: selectedAreaId)
    }
}
