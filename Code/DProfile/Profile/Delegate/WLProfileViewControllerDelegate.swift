//
//  WLProfileViewControllerDelegate.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit

@objc (WLProfileViewControllerDelegate)
public protocol WLProfileViewControllerDelegate {
    
    func onUserInfoTap(_ vc: UIViewController)
    
    func onPravicyTap(_ vc: UIViewController)
    
    func onAboutTap(_ vc: UIViewController)
    
    func onSettingTap(_ vc: UIViewController)
    
    func onFocusTap(_ vc: UIViewController)
}

@objc (WLProfileViewControllerMyPubDelegate)
public protocol WLProfileViewControllerMyPubDelegate {
    
    func onCircleTap(_ vc: UIViewController)
}
