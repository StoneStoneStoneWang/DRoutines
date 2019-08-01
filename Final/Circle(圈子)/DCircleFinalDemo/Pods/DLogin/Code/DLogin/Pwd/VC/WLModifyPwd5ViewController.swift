//
//  WLModifyPwdViewController.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit
import WLComponentView
import SnapKit

@objc (WLModifyPwd5ViewController)
final class WLModifyPwd5ViewController: WLModifyPwdBaseViewController {
    
    final let styleView: WLLoginStyle1View = WLLoginStyle1View()
    
    override public func addOwnSubViews() {
        
        view.addSubview(styleView)
        
        styleView.addSubview(oldpassword)
        
        styleView.addSubview(password)
        
        styleView.addSubview(passwordAgain)
        
        styleView.addSubview(completeItem)
        
    }
    
    override public func configOwnSubViews() {
        
        if let config = config {
            
            let margin: CGFloat = 15
            
            styleView.backgroundColor = .clear
            
            styleView.snp.makeConstraints { (make) in
                
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
                
                make.top.equalTo(margin * 2)
                
                make.height.equalTo(60)
            }
            
            password.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - 80, height: 1))
            
            password.leftImageName = config.passwordIcon
            
            password.attributedPlaceholder = NSAttributedString(string: "请输入6-18位新密码", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60")])
            
            password.set_bottomLineColor(WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60"))
            
            password.snp.makeConstraints { (make) in
                
                make.left.equalTo(oldpassword.snp.left)
                
                make.right.equalTo(oldpassword.snp.right)
                
                make.top.equalTo(oldpassword.snp.bottom)
                
                make.height.equalTo(60)
            }
            
            passwordAgain.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - 80, height: 1))
            
            passwordAgain.leftImageName = config.passwordIcon
            
            passwordAgain.attributedPlaceholder = NSAttributedString(string: "请输入6-18位确认密码", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60")])
            
            passwordAgain.set_bottomLineColor(WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60"))
            
            passwordAgain.snp.makeConstraints { (make) in
                
                make.left.equalTo(oldpassword.snp.left)
                
                make.right.equalTo(oldpassword.snp.right)
                
                make.top.equalTo(password.snp.bottom)
                
                make.height.equalTo(60)
            }
            
            completeItem.setImage(UIImage(named: config.goIcon), for: .normal)
            
            completeItem.setImage(UIImage(named: config.goIcon), for: .highlighted)
            
            completeItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR(hexColor: config.itemColor)), for: .normal)
            
            completeItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60" )), for: .highlighted)
            
            completeItem.snp.makeConstraints { (make) in
                
                make.right.bottom.equalTo(-margin)
                
                make.width.height.equalTo(50)
            }
        }
        
    }
}
