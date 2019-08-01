//
//  WLModifyPwd7ViewController.swift
//  SPwdDemo
//
//  Created by three stone 王 on 2019/6/11.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit
import SnapKit

@objc (WLModifyPwd7ViewController)
final class WLModifyPwd7ViewController: WLModifyPwdBaseViewController {
    
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
                
                make.top.equalTo(0)
                
                make.height.equalTo(WL_SCREEN_WIDTH * 5 / 8)
            }
            
            iconImageView.snp.makeConstraints { (make) in
                
                make.width.height.equalTo(120)
                
                make.centerX.equalTo(topView.snp.centerX)
                
                make.centerY.equalTo(topView.snp.centerY).offset(margin * 2)
            }
            
            oldpassword.attributedPlaceholder = NSAttributedString(string: "请输入6-18位旧密码", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: "#999999" + "60")])
            
            oldpassword.set_bottomLineColor(WLHEXCOLOR_ALPHA(hexColor: "#99999930"))
            
            oldpassword.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - margin * 4, height: 1))
            
            oldpassword.snp.makeConstraints { (make) in
                
                make.left.equalTo(margin * 2)
                
                make.right.equalTo(-margin * 2)
                
                make.top.equalTo(topView.snp.bottom).offset(30)
                
                make.height.equalTo(60)
            }
            
            password.attributedPlaceholder = NSAttributedString(string: "请输入6-18位新密码", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: "#999999" + "60")])
            
            password.set_bottomLineColor(WLHEXCOLOR_ALPHA(hexColor: "#99999930"))
            
            password.snp.makeConstraints { (make) in
                
                make.left.equalTo(oldpassword.snp.left)
                
                make.right.equalTo(oldpassword.snp.right)
                
                make.top.equalTo(oldpassword.snp.bottom)
                
                make.height.equalTo(oldpassword.snp.height)
            }
            
            passwordAgain.attributedPlaceholder = NSAttributedString(string: "请输入6-18位确认密码", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: "#999999" + "60")])
            
            passwordAgain.set_bottomLineColor(WLHEXCOLOR_ALPHA(hexColor: "#99999930"))
            
            passwordAgain.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - margin * 4, height: 1))
            
            passwordAgain.snp.makeConstraints { (make) in
                
                make.left.equalTo(oldpassword.snp.left)
                
                make.right.equalTo(oldpassword.snp.right)
                
                make.top.equalTo(password.snp.bottom)
                
                make.height.equalTo(oldpassword.snp.height)
            }
            
            completeItem.layer.cornerRadius = 5
            
            completeItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR(hexColor: config.itemColor)), for: .normal)
            
            completeItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60")), for: .highlighted)
            
            completeItem.snp.makeConstraints { (make) in
                
                make.left.equalTo(oldpassword.snp.left)
                
                make.right.equalTo(oldpassword.snp.right)
                
                make.top.equalTo(passwordAgain.snp.bottom).offset(50)
                
                make.height.equalTo(44)
            }
            completeItem.setTitle("修改密码", for: .normal)
            
            completeItem.setTitle("修改密码", for: .highlighted)
        }
    }
    
    override public func configOwnProperties() {
        
        view.backgroundColor = WLHEXCOLOR(hexColor: "#ffffff")
    }
}
