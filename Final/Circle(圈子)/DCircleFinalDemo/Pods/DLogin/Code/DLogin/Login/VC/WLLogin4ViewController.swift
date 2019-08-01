//
//  WLLogin4ViewController.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit
import SnapKit
@objc (WLLogin4ViewController)
final class WLLogin4ViewController: WLLoginBaseViewController {
    
    final let whiteView: UIView = UIView()
    
    override public func addOwnSubViews() {
        
        view.addSubview(whiteView)
        
        whiteView.addSubview(phone)
        
        whiteView.addSubview(password)
        
        whiteView.addSubview(loginItem)
        
        whiteView.addSubview(swiftLoginItem)
        
        whiteView.addSubview(forgetItem)
    }
    
    override public func configOwnSubViews() {
        
        let margin: CGFloat = 15
        
        if let config = config {
            
            whiteView.backgroundColor = .white
            
            whiteView.layer.cornerRadius = margin
            
            whiteView.layer.masksToBounds = true
            
            whiteView.snp.makeConstraints { (make) in
                
                make.left.equalTo(margin)
                
                make.right.equalTo(-margin)
                
                make.center.equalToSuperview()
                
                make.height.equalTo((WL_SCREEN_WIDTH - 2 * margin) * 3 / 2)
            }
            
            phone.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - 80, height: 1))
            
            phone.leftImageName = config.phoneIcon
            
            phone.attributedPlaceholder = NSAttributedString(string: "请输入手机号", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60")])
            
            phone.set_bottomLineColor(WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60"))
            
            phone.snp.makeConstraints { (make) in
                
                make.left.equalTo(margin)
                
                make.right.equalTo(-margin)
                
                make.top.equalTo(60)
                
                make.height.equalTo(60)
            }
            
            password.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - 80, height: 1))
            
            password.leftImageName = config.passwordIcon
            
            password.attributedPlaceholder = NSAttributedString(string: "请输入6-18位密码", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60")])
            
            password.set_bottomLineColor(WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60"))
            
            password.normalIcon = config.passwordItemNIcon
            
            password.selectedIcon = config.passwordItemSIcon
            
            password.passwordItem.sizeToFit()
            
            password.snp.makeConstraints { (make) in
                
                make.left.equalTo(phone.snp.left)
                
                make.right.equalTo(phone.snp.right)
                
                make.top.equalTo(phone.snp.bottom)
                
                make.height.equalTo(phone.snp.height)
            }
            
            loginItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR(hexColor: config.itemColor)), for: .normal)
            
            loginItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60")), for: .highlighted)
            
            loginItem.snp.makeConstraints { (make) in
                
                make.left.equalTo(phone.snp.left)
                
                make.right.equalTo(phone.snp.right)
                
                make.top.equalTo(password.snp.bottom).offset(50)
                
                make.height.equalTo(50)
            }
            
            loginItem.setTitle("登录", for: .normal)
            
            loginItem.setTitle("登录", for: .highlighted)
            
            forgetItem.snp.makeConstraints { (make) in
                
                make.right.equalTo(loginItem.snp.right)
                
                make.top.equalTo(loginItem.snp.bottom).offset(margin * 2)
            }
            
            forgetItem.setTitleColor(WLHEXCOLOR(hexColor: config.itemColor), for: .normal)
            
            forgetItem.setTitleColor(WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60"), for: .highlighted)
            
            swiftLoginItem.setTitle("没有账号，前往注册/登录？", for: .normal)
            
            swiftLoginItem.setTitle("没有账号，前往注册/登录？", for: .highlighted)
            
            swiftLoginItem.setTitleColor(WLHEXCOLOR(hexColor: config.itemColor), for: .normal)
            
            swiftLoginItem.setTitleColor(WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60"), for: .highlighted)
            
            swiftLoginItem.snp.makeConstraints { (make) in
                
                make.centerX.equalToSuperview()
                
                make.bottom.equalToSuperview().offset(-margin * 2)
            }
        }
    }
    
}
