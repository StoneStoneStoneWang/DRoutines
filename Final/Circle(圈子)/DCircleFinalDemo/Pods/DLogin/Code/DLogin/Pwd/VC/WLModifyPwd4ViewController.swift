//
//  WLModifyPwd4ViewController.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit
import SnapKit

@objc (WLModifyPwd4ViewController)
final class WLModifyPwd4ViewController: WLModifyPwdBaseViewController {
    
    final let whiteView: UIView = UIView()
    
    override public func addOwnSubViews() {
        
        view.addSubview(whiteView)
        
        whiteView.addSubview(oldpassword)
        
        whiteView.addSubview(password)
        
        whiteView.addSubview(passwordAgain)
        
        whiteView.addSubview(completeItem)
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
            
            oldpassword.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - 80, height: 1))
            
            oldpassword.leftImageName = config.passwordIcon
            
            oldpassword.attributedPlaceholder = NSAttributedString(string: "请输入6-18位旧密码", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60")])
            
            oldpassword.set_bottomLineColor(WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60"))
            
            oldpassword.snp.makeConstraints { (make) in
                
                make.left.equalTo(margin)
                
                make.right.equalTo(-margin)
                
                make.top.equalTo(60)
                
                make.height.equalTo(60)
            }
            
            password.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - 80, height: 1))
            
            password.leftImageName = config.passwordIcon
            
            password.attributedPlaceholder = NSAttributedString(string: "请输入6-18位旧密码", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60")])
 
            password.set_bottomLineColor(WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60"))
            
            password.snp.makeConstraints { (make) in
                
                make.left.equalTo(oldpassword.snp.left)
                
                make.right.equalTo(oldpassword.snp.right)
                
                make.top.equalTo(oldpassword.snp.bottom)
                
                make.height.equalTo(oldpassword.snp.height)
            }
            
            
            passwordAgain.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - 80, height: 1))
            
            passwordAgain.leftImageName = config.passwordIcon
            
            passwordAgain.attributedPlaceholder = NSAttributedString(string: "请输入6-18位新密码", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60")])
            
            passwordAgain.set_bottomLineColor(WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60"))
            
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
    
}
