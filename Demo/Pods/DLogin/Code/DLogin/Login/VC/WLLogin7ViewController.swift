//
//  WLLogin7ViewController.swift
//  SLoginDemo
//
//  Created by three stone 王 on 2019/6/11.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit
import SnapKit

@objc (WLLogin7ViewController)
class WLLogin7ViewController: WLLoginBaseViewController {
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.wl_setBackgroundColor(.clear)
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: WLHEXCOLOR(hexColor: "#ffffff")
        ]
    }
    
    final let iconImageView: UIImageView = UIImageView().then {
        
        $0.layer.cornerRadius = 60
        
        $0.layer.masksToBounds = true
        
        $0.backgroundColor = .white
        
        $0.layer.borderWidth = 1
    }
    
    final let topView: UIImageView = UIImageView(image: UIImage(named: "bg_login_head")).then {
        
        $0.layer.masksToBounds = true
    }
    
    override public func addOwnSubViews() {
        
        view.addSubview(topView)
        
        topView.addSubview(iconImageView)
        
        view.addSubview(phone)
        
        view.addSubview(password)
        
        view.addSubview(loginItem)
        
        view.addSubview(swiftLoginItem)
        
        view.addSubview(forgetItem)
        
    }
    
    override public func configOwnSubViews() {
        
        let margin: CGFloat = 15
        
        if let config = config {
            
            iconImageView.layer.borderColor = WLHEXCOLOR(hexColor: config.itemColor).cgColor
            
            iconImageView.image = UIImage(named: config.logo)
            
            topView.backgroundColor = WLHEXCOLOR(hexColor: config.itemColor)
            
            topView.snp.makeConstraints { (make) in
                
                make.left.right.equalToSuperview()
                
                make.top.equalTo(0)
                
                make.height.equalTo(WL_SCREEN_WIDTH * 5 / 8)
            }
            
            iconImageView.snp.makeConstraints { (make) in
                
                make.width.height.equalTo(120)
                
                make.centerX.equalTo(topView.snp.centerX)
                
                make.centerY.equalTo(topView.snp.centerY).offset(margin * 2)
            }
            
            phone.leftImageName = config.phoneIcon
            
            phone.attributedPlaceholder = NSAttributedString(string: "请输入手机号", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: "#999999" + "60")])
            
            phone.set_bottomLineColor(WLHEXCOLOR_ALPHA(hexColor: "#99999930"))
            
            phone.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - margin * 4, height: 1))
            
            phone.snp.makeConstraints { (make) in
                
                make.left.equalTo(margin * 2)
                
                make.right.equalTo(-margin * 2)
                
                make.top.equalTo(topView.snp.bottom).offset(30)
                
                make.height.equalTo(60)
            }
            
            password.leftImageName = config.passwordIcon
            
            password.attributedPlaceholder = NSAttributedString(string: "请输入6-18位密码", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: "#999999" + "60")])
            
            password.set_bottomLineColor(WLHEXCOLOR_ALPHA(hexColor: "#99999930"))
            
            password.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - margin * 4, height: 1))
            
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
            
            loginItem.setTitle("登录", for: .normal)
            
            loginItem.setTitle("登录", for: .highlighted)
            
            loginItem.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            
            forgetItem.snp.makeConstraints { (make) in
                
                make.right.equalTo(password.snp.right)
                
                make.top.equalTo(password.snp.bottom).offset(margin * 2)
            }
            
            forgetItem.setTitleColor(WLHEXCOLOR(hexColor: "#666666"), for: .normal)
            
            forgetItem.setTitleColor(WLHEXCOLOR_ALPHA(hexColor: "#666666" + "60"), for: .highlighted)
            
            swiftLoginItem.setTitle("注册", for: .normal)
            
            swiftLoginItem.setTitle("注册", for: .highlighted)
            
            swiftLoginItem.setTitleColor(WLHEXCOLOR(hexColor: config.itemColor), for: .normal)
            
            swiftLoginItem.setTitleColor(WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60"), for: .highlighted)
            
            swiftLoginItem.snp.makeConstraints { (make) in
                
                make.left.equalTo(password.snp.left)
                
                make.top.equalTo(password.snp.bottom).offset(margin * 2)
            }
            
            loginItem.layer.cornerRadius = 5
            
            loginItem.snp.makeConstraints { (make) in
                
                make.left.equalTo(phone.snp.left)
                
                make.right.equalTo(phone.snp.right)
                
                make.top.equalTo(swiftLoginItem.snp.bottom).offset(margin * 2)
                
                make.height.equalTo(44)
            }
            
        }
    }
    
    override public func configOwnProperties() {
        
        view.backgroundColor = WLHEXCOLOR(hexColor: "#ffffff")
    }
    
}
