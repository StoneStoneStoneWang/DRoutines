//
//  WLPublishDelegate.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/7.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit

@objc (WLPublishDelegate)
public protocol WLPublishDelegate {
    
    func onPublishSucc(_ from: UIViewController ,pubBean: [String: Any])
}
