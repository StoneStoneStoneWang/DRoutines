//
//  WLStoreDelegate.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
@objc (WLStoreDelegate)
public protocol WLStoreDelegate {
    
    func onCommodityClick(_ vc: UIViewController,storeJson: [String: Any])
}
