//
//  WLPassword1ViewController.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit
import SnapKit

@objc (WLPassword1ViewController)
final class WLPassword1ViewController: WLPasswordBaseViewController {
    
    final let iconImageView: UIImageView = UIImageView().then {
        
        $0.layer.cornerRadius = 50
        
        $0.layer.masksToBounds = true
        
        $0.backgroundColor = .white
        
        $0.layer.borderWidth = 1
    }
    
    final let whiteView: UIView = UIView().then {
        
        $0.backgroundColor = .white
        
        $0.layer.masksToBounds = true
    }
    
    override public func addOwnSubViews() {
        
        view.addSubview(whiteView)
        
        view.addSubview(iconImageView)
        
        whiteView.addSubview(phone)
        
        whiteView.addSubview(vcode)
        
        whiteView.addSubview(password)
        
        whiteView.addSubview(completeItem)
    }
    
    override public func configOwnSubViews() {
        
        let margin: CGFloat = 15
        
        if let config = config {
            
            iconImageView.layer.borderColor = WLHEXCOLOR(hexColor: config.itemColor).cgColor
            
            completeItem.setTitle("找回密码", for: .normal)
            
            completeItem.setTitle("找回密码", for: .highlighted)
            
            iconImageView.image = UIImage(named: config.logo)
            
            iconImageView.snp.makeConstraints { (make) in
                
                make.width.height.equalTo(100)
                
                make.centerX.equalTo(view.bounds.width / 2)
                
                make.top.equalTo(WL_TOP_LAYOUT_GUARD)
            }
            
            whiteView.layer.cornerRadius = margin
            
            whiteView.snp.makeConstraints { (make) in
                
                make.left.equalTo(margin)
                
                make.right.bottom.equalTo(-margin)
                
                make.top.equalTo(iconImageView.snp.centerY)
            }
            phone.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - 80, height: 1))
            
            phone.leftImageName = config.phoneIcon
            
            phone.attributedPlaceholder = NSAttributedString(string: "请输入手机号", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60")])
            
            phone.set_bottomLineColor(WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60"))
            
            phone.snp.makeConstraints { (make) in
                
                make.left.equalTo(margin)
                
                make.right.equalTo(-margin)
                
                make.top.equalTo(iconImageView.snp.bottom).offset(30)
                
                make.height.equalTo(60)
            }
            
            vcode.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - 80, height: 1))
            
            vcode.leftImageName = config.vcodeIcon
            
            vcode.attributedPlaceholder = NSAttributedString(string: "请输入6位验证码", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60")])
            //
            vcode.set_editType(.vcode_length6)
            
            vcode.set_bottomLineColor(WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60"))
            
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
                
                make.top.equalTo(phone.snp.bottom)
                
                make.height.equalTo(phone.snp.height)
            }
            
            password.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - 80, height: 1))
            
            password.leftImageName = config.passwordIcon
            
            password.attributedPlaceholder = NSAttributedString(string: "请输入6-18位新密码", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60")])
            
            password.set_bottomLineColor(WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60"))
            
            password.normalIcon = config.passwordItemNIcon
            
            password.selectedIcon = config.passwordItemSIcon
            
            password.passwordItem.sizeToFit()
            
            password.snp.makeConstraints { (make) in
                
                make.left.equalTo(phone.snp.left)
                
                make.right.equalTo(phone.snp.right)
                
                make.top.equalTo(vcode.snp.bottom)
                
                make.height.equalTo(phone.snp.height)
            }
            
            completeItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR(hexColor: config.itemColor)), for: .normal)
            
            completeItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60")), for: .highlighted)
            
            completeItem.snp.makeConstraints { (make) in
                
                make.left.equalTo(phone.snp.left)
                
                make.right.equalTo(phone.snp.right)
                
                make.top.equalTo(password.snp.bottom).offset(50)
                
                make.height.equalTo(50)
            }
        }
    }
    
}
