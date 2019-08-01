//
//  WLSwiftLogin7ViewController.swift
//  SRegDemo
//
//  Created by three stone 王 on 2019/6/11.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit
import WLComponentView
import SnapKit
import WLBaseViewController

@objc (WLSwiftLogin7ViewController)
final class WLSwiftLogin7ViewController: WLSwiftLoginBaseViewController {
    
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
        
        view.addSubview(vcode)
        
        view.addSubview(loginItem)
        
        view.addSubview(proItem)
        
        view.addSubview(backLoginItem)
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
            
//            phone.leftImageName = config.phoneIcon
            
            phone.attributedPlaceholder = NSAttributedString(string: "请输入手机号", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: "#999999" + "60")])
            
            phone.set_bottomLineColor(WLHEXCOLOR_ALPHA(hexColor: "#999999" + "30"))
            
            phone.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - margin * 4, height: 1))
            
            phone.snp.makeConstraints { (make) in
                
                make.left.equalTo(margin * 2)
                
                make.right.equalTo(-margin * 2)
                
                make.top.equalTo(topView.snp.bottom).offset(30)
                
                make.height.equalTo(60)
            }
            
//            vcode.leftImageName = config.vcodeIcon
            
            vcode.attributedPlaceholder = NSAttributedString(string: "请输入6位验证码", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: "#999999" + "60")])
            
            vcode.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - margin * 4, height: 1))
            
            vcode.set_editType(.vcode_length6)
            
            vcode.set_bottomLineColor(WLHEXCOLOR_ALPHA(hexColor: "#999999" + "30"))
            
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
            
            loginItem.layer.cornerRadius = 5
            
            loginItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR(hexColor: config.itemColor)), for: .normal)
            
            loginItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60")), for: .highlighted)
            
            loginItem.setTitle("注册", for: .normal)
            
            loginItem.setTitle("注册", for: .highlighted)
            
            loginItem.snp.makeConstraints { (make) in
                
                make.left.equalTo(phone.snp.left)
                
                make.right.equalTo(phone.snp.right)
                
                make.top.equalTo(vcode.snp.bottom).offset(50)
                
                make.height.equalTo(44)
            }
            
            let mutable = NSMutableAttributedString()
            
            let hMutable = NSMutableAttributedString()
            
            if let displayName = Bundle.main.infoDictionary!["CFBundleDisplayName"] as? String {
                
                mutable.setAttributedString(NSAttributedString(string: "\(displayName)  ", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60")]))
                
                hMutable.setAttributedString(NSAttributedString(string: "\(displayName)  ", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60")]))
            }
            
            mutable.append(NSAttributedString(string: "《注册协议与隐私》", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR(hexColor:config.itemColor)]))
            
            hMutable.append(NSAttributedString(string: "《注册协议与隐私》", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60")]))
            
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
        
        view.backgroundColor = WLHEXCOLOR(hexColor: "#ffffff")
    }
}
