//
//  WLModifyPwd7ViewController.swift
//  SLoginDemo
//
//  Created by 张丽 on 2019/6/6.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import UIKit
import WLToolsKit
import SnapKit

@objc (WLModifyPwd6ViewController)
final class WLModifyPwd6ViewController: WLModifyPwdBaseViewController {
    
    final let iconImageView: UIImageView = UIImageView().then {
        
        $0.layer.cornerRadius = 60
        
        $0.layer.masksToBounds = true
        
        $0.backgroundColor = .white
        
        $0.layer.borderWidth = 1
    }
    
    final let topView: UIView = UIView().then {
        
        $0.layer.masksToBounds = true
    }
    
    final let mainView: UIView = UIView().then {
        
        $0.layer.masksToBounds = true
        
        $0.backgroundColor = .white
        
        $0.layer.borderColor = UIColor.white.cgColor
        
        $0.layer.borderWidth = 1
    }
    
    override public func addOwnSubViews() {
        
        view.addSubview(topView)
        
        topView.addSubview(iconImageView)
        
        view.addSubview(mainView)
        
        mainView.addSubview(oldpassword)
        
        mainView.addSubview(password)
        
        mainView.addSubview(passwordAgain)
        
        mainView.addSubview(completeItem)
    }
    
    override public func configOwnSubViews() {
        
        let margin: CGFloat = 15
        
        let mainViewMargin: CGFloat = 30
        
        if let config = config {
            
            iconImageView.layer.borderColor = WLHEXCOLOR(hexColor: config.itemColor).cgColor
            
            iconImageView.image = UIImage(named: config.logo)
            
            topView.backgroundColor = WLHEXCOLOR(hexColor: config.itemColor)
            
            topView.snp.makeConstraints { (make) in
                
                make.left.right.equalToSuperview()
                
                make.top.equalTo(WL_TOP_LAYOUT_GUARD)
                
                make.height.equalTo(WL_SCREEN_WIDTH / 2)
            }
            
            iconImageView.snp.makeConstraints { (make) in
                
                make.width.height.equalTo(100)
                
                make.center.equalTo(topView.snp.center)
            }
            
            mainView.layer.cornerRadius = margin
            
            mainView.snp.makeConstraints { (make) in
                
                make.left.equalTo(mainViewMargin)
                
                make.right.equalTo(-mainViewMargin)
                
                make.top.equalTo(iconImageView.snp.bottom).offset(20)
                
                make.bottom.equalToSuperview().offset(-mainViewMargin * 3)
            }
            
            oldpassword.leftImageName = config.passwordIcon
            
            oldpassword.attributedPlaceholder = NSAttributedString(string: "请输入6-18位旧密码", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60")])
            
            oldpassword.set_bottomLineColor(WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60"))
            
            oldpassword.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - mainViewMargin * 4, height: 1))
            
            oldpassword.snp.makeConstraints { (make) in
                
                make.left.equalTo(margin * 2)
                
                make.right.equalTo(-margin * 2)
                
                make.top.equalTo(topView.snp.bottom).offset(30)
                
                make.height.equalTo(60)
            }
            
            password.leftImageName = config.passwordIcon
            
            password.attributedPlaceholder = NSAttributedString(string: "请输入6-18位新密码", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60")])
            
            password.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - mainViewMargin * 4, height: 1))
            
            password.set_bottomLineColor(WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60"))
            
            password.snp.makeConstraints { (make) in
                
                make.left.equalTo(oldpassword.snp.left)
                
                make.right.equalTo(oldpassword.snp.right)
                
                make.top.equalTo(oldpassword.snp.bottom)
                
                make.height.equalTo(oldpassword.snp.height)
            }
            
            passwordAgain.leftImageName = config.passwordIcon
            
            passwordAgain.attributedPlaceholder = NSAttributedString(string: "请输入6-18位确认密码", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60")])
            
            passwordAgain.set_bottomLineColor(WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60"))
            
            passwordAgain.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - mainViewMargin * 4, height: 1))
            
            passwordAgain.snp.makeConstraints { (make) in
                
                make.left.equalTo(oldpassword.snp.left)
                
                make.right.equalTo(oldpassword.snp.right)
                
                make.top.equalTo(password.snp.bottom)
                
                make.height.equalTo(oldpassword.snp.height)
            }
            
            completeItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR(hexColor: config.itemColor)), for: .normal)
            
            completeItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60")), for: .highlighted)
            
            completeItem.snp.makeConstraints { (make) in
                
                make.left.equalTo(oldpassword.snp.left)
                
                make.right.equalTo(oldpassword.snp.right)
                
                make.top.equalTo(passwordAgain.snp.bottom).offset(80)
                
                make.height.equalTo(50)
            }
            completeItem.setTitle("修改密码", for: .normal)
            
            completeItem.setTitle("修改密码", for: .highlighted)
        }
    }
    
    override public func configOwnProperties() {
        
        view.backgroundColor = WLHEXCOLOR(hexColor: "#f1f1f1")
    }
}
