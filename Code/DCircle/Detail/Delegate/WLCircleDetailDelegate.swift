//
//  WLCircleDetailDelegate.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit

@objc (WLCircleDetailDelegate)
public protocol WLCircleDetailDelegate {
    
    func onReportClick(_ vc: UIViewController,uid: String,encoded: String)
    
    func onShareClick(_ vc: UIViewController,webUrl: String ,title: String,desc: String)
}
