//
//  WLSwiftLogin5ViewController.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit
import WLComponentView
import SnapKit
@objc (WLSwiftLogin5ViewController)
final class WLSwiftLogin5ViewController: WLSwiftLoginBaseViewController {
    
    final let styleView: WLLoginStyle1View = WLLoginStyle1View()
    
    override public func addOwnSubViews() {
        
        view.addSubview(styleView)
        
        styleView.addSubview(phone)
        
        styleView.addSubview(vcode)
        
        styleView.addSubview(loginItem)
        
        styleView.addSubview(proItem)
        
        view.addSubview(backLoginItem)
    }
    
    override public func configOwnSubViews() {
        
        let margin: CGFloat = 15
        
        if let config = config {
            
            styleView.backgroundColor = .clear
            
            styleView.fillColor = .white
            
            styleView.snp.makeConstraints { (make) in
                
                make.left.equalTo(margin)
                
                make.right.equalTo(-margin)
                
                make.center.equalToSuperview()
                
                make.height.equalTo((WL_SCREEN_WIDTH - 2 * margin) * 3 / 2)
            }
            
            phone.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - 80, height: 1))
            
            phone.leftImageName = config.phoneIcon
            
            phone.attributedPlaceholder = NSAttributedString(string: "请输入手机号", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60")])
            
            phone.set_bottomLineColor(WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60"))
            
            phone.snp.makeConstraints { (make) in
                
                make.left.equalTo(margin)
                
                make.right.equalTo(-margin)
                
                make.top.equalTo(60)
                
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
        
            loginItem.setImage(UIImage(named: config.goIcon), for: .normal)
            
            loginItem.setImage(UIImage(named: config.goIcon), for: .highlighted)
            
            loginItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR(hexColor: config.itemColor)), for: .normal)
            
            loginItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60")), for: .highlighted)
            
            loginItem.snp.makeConstraints { (make) in
                
                make.right.equalTo(phone.snp.right)
                
                make.bottom.equalToSuperview().offset(-margin)
                
                make.height.width.equalTo(50)
                
            }
            let mutable = NSMutableAttributedString()
            
            let hMutable = NSMutableAttributedString()
            
            if let displayName = Bundle.main.infoDictionary!["CFBundleDisplayName"] as? String {
                
                mutable.setAttributedString(NSAttributedString(string: "\(displayName)  ", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60")]))
                
                hMutable.setAttributedString(NSAttributedString(string: "\(displayName)  ", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60")]))
            }
            
            mutable.append(NSAttributedString(string: "《注册协议与隐私》", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR(hexColor: config.itemColor)]))
            
            hMutable.append(NSAttributedString(string: "《注册协议与隐私》", attributes: [NSAttributedString.Key.foregroundColor: WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)60")]))
            
            proItem.setAttributedTitle(mutable, for: .normal)
            
            proItem.setAttributedTitle(hMutable, for: .highlighted)
            
            proItem.snp.makeConstraints { (make) in
                
                make.right.equalTo(loginItem.snp.right)
                
                make.top.equalTo(vcode.snp.bottom).offset(margin)
            }
            
            backLoginItem.snp.makeConstraints { (make) in
                
                make.centerX.equalToSuperview()
                
                make.bottom.equalTo(-margin * 3)
            }
            
            backLoginItem.setTitleColor(WLHEXCOLOR(hexColor: "#ffffff"), for: .normal)
            
            backLoginItem.setTitleColor(WLHEXCOLOR_ALPHA(hexColor: "#ffffff60"), for: .highlighted)
        }
    }
}
