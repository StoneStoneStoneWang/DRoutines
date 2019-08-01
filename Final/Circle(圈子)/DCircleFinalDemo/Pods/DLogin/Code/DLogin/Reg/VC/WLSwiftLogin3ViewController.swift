//
//  WLSwiftLogin3ViewController.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit
import SnapKit

@objc (WLSwiftLogin3ViewController)
final class WLSwiftLogin3ViewController: WLSwiftLoginBaseViewController {
    
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
        
        view.addSubview(vcode)
        
        view.addSubview(loginItem)
        
        view.addSubview(proItem)
        
        view.addSubview(backLoginItem)
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
                
                make.bottom.equalTo(backLoginItem.snp.bottom).offset(-margin * 3)
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
            
            vcode.layer.cornerRadius = 30
            
            vcode.layer.masksToBounds = true
            
            vcode.backgroundColor = WLHEXCOLOR(hexColor: "#ffffff")
            
            vcode.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - 80, height: 1))
            
            vcode.leftImageName = config.vcodeIcon
            
            vcode.attributedPlaceholder = NSAttributedString(string: "请输入6位验证码", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60")])
            //
            vcode.set_editType(.vcode_length6)
            
            vcode.vcodeItem.setTitle("获取验证码", for: .normal)
            
            vcode.vcodeItem.sizeToFit()
            
            vcode.set_rightView(vcode.vcodeItem)
            
            vcode.set_rightViewMode(.always)
            
            vcode.vcodeItem.setTitleColor(WLHEXCOLOR(hexColor: config.itemColor), for: .normal)
            
            vcode.vcodeItem.setTitleColor(WLHEXCOLOR(hexColor: config.itemColor), for: .highlighted)
            
            vcode.vcodeItem.setTitleColor(WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60"), for: .disabled)
            
            vcode.snp.makeConstraints { (make) in
                
                make.left.equalTo(phone.snp.left)
                
                make.right.equalTo(phone.snp.right)
                
                make.top.equalTo(phone.snp.bottom).offset(margin)
                
                make.height.equalTo(phone.snp.height)
            }
            
            loginItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR(hexColor: "#ffffff")), for: .normal)
            
            loginItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR_ALPHA(hexColor: "#ffffff60")), for: .highlighted)
            
            loginItem.setTitleColor(WLHEXCOLOR(hexColor: config.itemColor), for: .normal)
            
            loginItem.setTitleColor(WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60"), for: .highlighted)
            
            loginItem.setTitle("注册/登陆", for: .normal)
            
            loginItem.setTitle("注册/登陆", for: .highlighted)
            
            loginItem.snp.makeConstraints { (make) in
                
                make.left.equalTo(phone.snp.left)
                
                make.right.equalTo(phone.snp.right)
                
                make.top.equalTo(vcode.snp.bottom).offset(50)
                
                make.height.equalTo(50)
            }
            
            let mutable = NSMutableAttributedString()
            
            let hMutable = NSMutableAttributedString()
            
            if let displayName = Bundle.main.infoDictionary!["CFBundleDisplayName"] as? String {
                
                mutable.setAttributedString(NSAttributedString(string: "\(displayName)  ", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: "#ffffff60")]))
                
                hMutable.setAttributedString(NSAttributedString(string: "\(displayName)  ", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: "#ffffff60")]))
            }
            
            mutable.append(NSAttributedString(string: "《注册协议与隐私》", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR(hexColor:"#ffffff")]))
            
            hMutable.append(NSAttributedString(string: "《注册协议与隐私》", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: "#ffffff60")]))
            
            proItem.setAttributedTitle(mutable, for: .normal)
            
            proItem.setAttributedTitle(hMutable, for: .highlighted)
            
            proItem.snp.makeConstraints { (make) in
                
                make.right.equalTo(loginItem.snp.right)
                
                make.top.equalTo(loginItem.snp.bottom).offset(margin)
            }
            
            backLoginItem.snp.makeConstraints { (make) in
                
                make.centerX.equalToSuperview()
                
                make.bottom.equalTo(-margin * 3)
            }
            
            backLoginItem.setTitleColor(WLHEXCOLOR(hexColor: config.itemColor), for: .normal)
            
            backLoginItem.setTitleColor(WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60"), for: .highlighted)
        }
    }
    
    override public func configOwnProperties() {
        
        view.backgroundColor = WLHEXCOLOR(hexColor: "#e1e1e1")
    }
}
