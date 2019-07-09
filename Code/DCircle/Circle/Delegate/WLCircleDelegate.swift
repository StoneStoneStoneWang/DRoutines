//
//  WLCirlceDelegate.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/7.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
@objc (WLCircleDelegate)
public protocol WLCircleDelegate {
    
    func onReportClick(_ vc: UIViewController,uid: String,encoded: String)
    
    func onCircleClick(_ vc: UIViewController,circlJson: [String: Any],uid: String,encoded: String)
    
    func onShareClick(_ vc: UIViewController,webUrl: String ,title: String,desc: String)
}
