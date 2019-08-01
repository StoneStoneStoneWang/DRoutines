//
//  WLModifyPwd3ViewController.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit
import SnapKit

@objc (WLModifyPwd3ViewController)
final class WLModifyPwd3ViewController: WLModifyPwdBaseViewController {
    
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
        
        view.addSubview(oldpassword)
        
        view.addSubview(password)
        
        view.addSubview(passwordAgain)
        
        view.addSubview(completeItem)
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
                
                make.bottom.equalTo(completeItem.snp.bottom).offset(100)
            }
            
            oldpassword.layer.cornerRadius = 30
            
            oldpassword.layer.masksToBounds = true
            
            oldpassword.backgroundColor = WLHEXCOLOR(hexColor: "#ffffff")
            
            oldpassword.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - 80, height: 1))
            
            oldpassword.leftImageName = config.passwordIcon
            
            oldpassword.attributedPlaceholder = NSAttributedString(string: "请输入6-18位旧密码", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60")])
            
            oldpassword.snp.makeConstraints { (make) in
                
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
            
            password.attributedPlaceholder = NSAttributedString(string: "请输入6-18位新密码", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60")])
            //
            
            password.snp.makeConstraints { (make) in
                
                make.left.equalTo(oldpassword.snp.left)
                
                make.right.equalTo(oldpassword.snp.right)
                
                make.top.equalTo(oldpassword.snp.bottom).offset(margin)
                
                make.height.equalTo(oldpassword.snp.height)
            }
            
            passwordAgain.layer.cornerRadius = 30
            
            passwordAgain.layer.masksToBounds = true
            
            passwordAgain.backgroundColor = WLHEXCOLOR(hexColor: "#ffffff")
            
            passwordAgain.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - 80, height: 1))
            
            passwordAgain.leftImageName = config.passwordIcon
            
            passwordAgain.attributedPlaceholder = NSAttributedString(string: "请输入6-18位确认密码", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60")])
            
            passwordAgain.snp.makeConstraints { (make) in
                
                make.left.equalTo(oldpassword.snp.left)
                
                make.right.equalTo(oldpassword.snp.right)
                
                make.top.equalTo(password.snp.bottom).offset(margin)
                
                make.height.equalTo(oldpassword.snp.height)
            }
            
            completeItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR(hexColor: "#ffffff")), for: .normal)
            
            completeItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR_ALPHA(hexColor: "#ffffff60")), for: .highlighted)
            
            completeItem.setTitleColor(WLHEXCOLOR(hexColor: config.itemColor), for: .normal)
            
            completeItem.setTitleColor(WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60"), for: .highlighted)
            
            completeItem.snp.makeConstraints { (make) in
                
                make.left.equalTo(oldpassword.snp.left)
                
                make.right.equalTo(oldpassword.snp.right)
                
                make.top.equalTo(passwordAgain.snp.bottom).offset(50)
                
                make.height.equalTo(50)
            }
            completeItem.setTitle("修改密码", for: .normal)
            
            completeItem.setTitle("修改密码", for: .highlighted)
        }
    }
    
    override public func configOwnProperties() {
        
        view.backgroundColor = WLHEXCOLOR(hexColor: "#e1e1e1")
    }
}
