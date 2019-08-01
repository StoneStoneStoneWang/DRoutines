//
//  WLModifyPwd2ViewController.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit
import SnapKit

@objc (WLModifyPwd2ViewController)
final class WLModifyPwd2ViewController: WLModifyPwdBaseViewController {
    
    final let iconImageView: UIImageView = UIImageView().then {
        
        $0.layer.cornerRadius = 50
        
        $0.layer.masksToBounds = true
        
        $0.backgroundColor = .white
        
        $0.layer.borderWidth = 1
    }
    
    final let topView: UIView = UIView().then {
        
        $0.layer.masksToBounds = true
    }
    
    override public func addOwnSubViews() {
        
        view.addSubview(topView)
        
        topView.addSubview(iconImageView)
        
        view.addSubview(oldpassword)
        
        view.addSubview(password)
        
        view.addSubview(passwordAgain)
        
        view.addSubview(completeItem)
    }
    
    override public func configOwnSubViews() {
        
        let margin: CGFloat = 15
        
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
            
            oldpassword.leftImageName = config.passwordIcon
            
            oldpassword.attributedPlaceholder = NSAttributedString(string: "请输入6-18位旧密码", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60")])
            
            oldpassword.set_bottomLineColor(WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60"))
            
            oldpassword.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - margin * 4, height: 1))
            
            oldpassword.snp.makeConstraints { (make) in
                
                make.left.equalTo(margin * 2)
                
                make.right.equalTo(-margin * 2)
                
                make.top.equalTo(topView.snp.bottom).offset(30)
                
                make.height.equalTo(60)
            }
            
            password.leftImageName = config.passwordIcon
            
            password.attributedPlaceholder = NSAttributedString(string: "请输入6-18位新密码", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60")])
            
            password.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - margin * 4, height: 1))
            
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
            
            passwordAgain.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - margin * 4, height: 1))
            
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
                
                make.top.equalTo(passwordAgain.snp.bottom).offset(50)
                
                make.height.equalTo(50)
            }
            completeItem.setTitle("修改密码", for: .normal)
            
            completeItem.setTitle("修改密码", for: .highlighted)
        }
    }
    
    override public func configOwnProperties() {
        
        view.backgroundColor = WLHEXCOLOR(hexColor: "#ffffff")
    }
}
