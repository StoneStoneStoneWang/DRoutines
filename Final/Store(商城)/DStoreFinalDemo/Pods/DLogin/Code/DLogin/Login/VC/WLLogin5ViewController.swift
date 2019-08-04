//
//  WLLogin5ViewController.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit
import WLComponentView
import SnapKit
@objc (WLLogin5ViewController)
final class WLLogin5ViewController: WLLoginBaseViewController {
    
    final let styleView: WLLoginStyle1View = WLLoginStyle1View()
    
    override public func addOwnSubViews() {
        
        view.addSubview(styleView)
        
        styleView.addSubview(phone)
        
        styleView.addSubview(password)
        
        styleView.addSubview(loginItem)
        
        styleView.addSubview(forgetItem)
        
        view.addSubview(swiftLoginItem)
    }
    
    override public func configOwnSubViews() {
        
        let margin: CGFloat = 15
        
        if let config = config {
            
            styleView.backgroundColor = .clear
            
            styleView.fillColor = .white
            
            styleView.snp.makeConstraints { (make) in
                
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
            
            password.passwordItem.setImage(UIImage(named: config.passwordItemSIcon), for: .selected)
            
            password.snp.makeConstraints { (make) in
                
                make.left.equalTo(phone.snp.left)
                
                make.right.equalTo(phone.snp.right)
                
                make.top.equalTo(phone.snp.bottom)
                
                make.height.equalTo(phone.snp.height)
            }
            
            loginItem.setImage(UIImage(named: config.goIcon), for: .normal)
            
            loginItem.setImage(UIImage(named: config.goIcon), for: .highlighted)
            
            loginItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR(hexColor: config.itemColor)), for: .normal)
            
            loginItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60")), for: .highlighted)
            
            loginItem.snp.makeConstraints { (make) in
                
                make.right.equalTo(phone.snp.right)
                
                make.bottom.equalToSuperview().offset(-margin)
                
                make.height.width.equalTo(50)
            }
            
            forgetItem.snp.makeConstraints { (make) in
                
                make.right.equalTo(loginItem.snp.right)
                
                make.top.equalTo(password.snp.bottom).offset(margin * 2)
            }
            
            forgetItem.setTitleColor(WLHEXCOLOR(hexColor: config.itemColor), for: .normal)
            
            forgetItem.setTitleColor(WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60"), for: .highlighted)
            
            swiftLoginItem.setTitle("没有账号，前往注册/登录？", for: .normal)
            
            swiftLoginItem.setTitle("没有账号，前往注册/登录？", for: .highlighted)
            
            swiftLoginItem.setTitleColor(WLHEXCOLOR(hexColor: "#ffffff"), for: .normal)
            
            swiftLoginItem.setTitleColor(WLHEXCOLOR_ALPHA(hexColor: "#ffffff" + "60"), for: .highlighted)
            
            swiftLoginItem.snp.makeConstraints { (make) in
                
                make.centerX.equalToSuperview()
                
                make.bottom.equalToSuperview().offset(-margin * 2)
            }
            
        }
    }
}
