//
//  WLLogin3ViewController.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit
import SnapKit

@objc (WLLogin3ViewController)
final class WLLogin3ViewController: WLLoginBaseViewController {
    
    final let iconImageView: UIImageView = UIImageView().then {
        
        $0.layer.cornerRadius = 50
        
        $0.layer.masksToBounds = true
        
        $0.backgroundColor = .white
        
        $0.layer.borderWidth = 1
    }
    
    final let backgroundView: UIView = UIView().then {
        
        $0.backgroundColor = .white
        
        $0.layer.masksToBounds = true
    }
    
    override public func addOwnSubViews() {
        
        view.addSubview(backgroundView)
        
        view.addSubview(iconImageView)
        
        view.addSubview(phone)
        
        view.addSubview(password)
        
        view.addSubview(loginItem)
        
        view.addSubview(swiftLoginItem)
        
        view.addSubview(forgetItem)
    }
    
    override public func configOwnSubViews() {
        
        let margin: CGFloat = 15
        
        if let config = config {
            
            navigationController?.navigationBar.wl_setBackgroundColor(WLHEXCOLOR(hexColor: "#ffffff"))
            
            iconImageView.image = UIImage(named: config.logo)
            
            backgroundView.backgroundColor = WLHEXCOLOR(hexColor: config.itemColor)
            
            backgroundView.layer.borderColor = WLHEXCOLOR(hexColor: config.itemColor).cgColor
            
            backgroundView.layer.borderWidth = 1
            
            iconImageView.layer.borderColor = WLHEXCOLOR(hexColor: config.itemColor).cgColor
            
            iconImageView.snp.makeConstraints { (make) in
                
                make.width.height.equalTo(100)
                
                make.centerX.equalTo(view.bounds.width / 2)
                
                make.top.equalTo(WL_TOP_LAYOUT_GUARD)
            }
            
            backgroundView.layer.cornerRadius = margin
            
            backgroundView.snp.makeConstraints { (make) in
                
                make.left.equalTo(margin)
                
                make.right.equalTo(-margin)
                
                make.top.equalTo(iconImageView.snp.centerY)
                
                make.bottom.equalTo(swiftLoginItem.snp.bottom).offset(-margin * 3)
            }
            
            phone.layer.cornerRadius = 30
            
            phone.layer.masksToBounds = true
            
            phone.backgroundColor = WLHEXCOLOR(hexColor: "#ffffff")
            
            phone.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - 80, height: 1))
            
            phone.leftImageName = config.phoneIcon
            
            phone.attributedPlaceholder = NSAttributedString(string: "请输入手机号", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60")])
            
            phone.snp.makeConstraints { (make) in
                
                make.left.equalTo(margin * 2)
                
                make.right.equalTo(-margin * 2)
                
                make.top.equalTo(iconImageView.snp.bottom).offset(30)
                
                make.height.equalTo(60)
            }
            
            password.layer.cornerRadius = 30
            
            password.layer.masksToBounds = true
            
            password.backgroundColor = WLHEXCOLOR(hexColor: "#ffffff")
            
            password.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - 80, height: 1))
            
            password.leftImageName = config.passwordIcon
            
            password.attributedPlaceholder = NSAttributedString(string: "请输入6-18位密码", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60")])
            
            password.normalIcon = config.passwordItemNIcon
            
            password.selectedIcon = config.passwordItemSIcon
            
            password.passwordItem.sizeToFit()
            
            password.snp.makeConstraints { (make) in
                
                make.left.equalTo(phone.snp.left)
                
                make.right.equalTo(phone.snp.right)
                
                make.top.equalTo(phone.snp.bottom).offset(margin)
                
                make.height.equalTo(phone.snp.height)
            }
            
            loginItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR(hexColor: "#ffffff")), for: .normal)
            
            loginItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR_ALPHA(hexColor: "#ffffff60")), for: .highlighted)
            
            loginItem.setTitleColor(WLHEXCOLOR(hexColor: config.itemColor), for: .normal)
            
            loginItem.setTitleColor(WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60"), for: .highlighted)
            
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
            
            forgetItem.setTitleColor(WLHEXCOLOR(hexColor: "#ffffff"), for: .normal)
            
            forgetItem.setTitleColor(WLHEXCOLOR_ALPHA(hexColor: "#ffffff" + "60"), for: .highlighted)
            
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
    
    override public func configOwnProperties() {
        
        view.backgroundColor = WLHEXCOLOR(hexColor: "#e1e1e1")
    }
}
