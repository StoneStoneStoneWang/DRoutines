//
//  WLOrderBaseViewController+Create.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

extension WLOrderBaseViewController {
    @objc
    public static func createOrder(_ tag: String) -> WLOrderBaseViewController {
        
        return WLOrderViewController(tag)
    }
}
