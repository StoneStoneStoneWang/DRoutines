//
//  WLLoginBaseViewController.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLToolsKit
import WLThirdUtil.WLHudUtil
import WLThirdUtil.WLJPushUtil
import WLComponentView
import DPrepare
import DNotification

@objc (WLLoginBaseViewController)
open class WLLoginBaseViewController: WLBaseDisposeViewController {
    
    public var config: WLLoginConfig!
    
    public var style: WLLoginStyle = .one
    
    public required init(_ style: WLLoginStyle,config: WLLoginConfig) {
        super.init(nibName: nil, bundle: nil)
        
        self.config = config
        
        self.style = style
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public final let phone: WLLeftImageTextField = WLLeftImageTextField(frame: .zero).then {
        
        $0.set_editType(.phone)
        
        $0.set_maxLength(11)
    }
    
    public final let password: WLPasswordImageTextFiled = WLPasswordImageTextFiled(frame: .zero)
    
    public final let loginItem: UIButton = UIButton(type: .custom).then {
        
        $0.layer.cornerRadius = 25
        
        $0.layer.masksToBounds = true
    }
    
    public final let forgetItem: UIButton = UIButton(type: .custom).then {
        
        $0.setTitle("忘记密码？", for: .normal)
        
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        $0.setTitle("忘记密码？", for: .highlighted)
    }
    
    public final let swiftLoginItem: UIButton = UIButton(type: .custom).then {
        
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
    }
    
    public final let backItem: UIButton = UIButton(type: .custom)
    
    var viewModel: WLLoginViewModel!
    
    override open func configViewModel() {
        
        let input = WLLoginViewModel.WLInput(username: phone.rx.text.orEmpty.asDriver(),
                                             password: password.rx.text.orEmpty.asDriver() ,
                                             loginTaps: loginItem.rx.tap.asSignal(),
                                             swiftLoginTaps: swiftLoginItem.rx.tap.asSignal(),
                                             forgetTaps: forgetItem.rx.tap.asSignal(),
                                             passwordItemTaps: password.passwordItem.rx.tap.asSignal())
        
        viewModel = WLLoginViewModel(input)
        
        backItem
            .rx
            .tap
            .subscribe(onNext: { [weak self] (_) in
                
                guard let `self` = self else { return }
                
                self.navigationController?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposed)
        
        // MARK: 登录点击中序列
        viewModel
            .output
            .logining
            .drive(onNext: { [weak self] _ in
                
                guard let `self` = self else { return }
                
                self.view.endEditing(true)
                
                WLHudUtil.show(withStatus: "登录中...")
            })
            .disposed(by: disposed)
        
        // MARK: 登录事件返回序列
        viewModel
            .output
            .logined
            .drive(onNext: { [weak self] in
                guard let `self` = self else { return }
                
                WLHudUtil.pop()
                
                switch $0 {
                    
                case let .failed(msg): WLHudUtil.showInfo(msg)
                    
                case .logined:
                    
                    WLJPushUtil.shared().jp_setAlias(WLAccountCache.default.uid, completion: { (_, _, _) in
                        
                    }, seq: 1)
                    
                    WLHudUtil.showInfo("登录成功")
                    
                    DNotificationConfigration.postNotification(withName: NSNotification.Name(rawValue: DNotificationLoginSucc), andValue: nil, andFrom: self)
                    
                default: break
                }
            })
            .disposed(by: disposed)
        
        viewModel
            .output
            .swiftLogined
            .drive(onNext: { [weak self]  (_) in
                
                guard let `self` = self else { return }
                
                DNotificationConfigration.postNotification(withName: NSNotification.Name(rawValue: DNotificationLoginSucc), andValue: nil, andFrom: self)
                
            })
            .disposed(by: disposed)
        
        viewModel
            .output
            .forgeted
            .drive(onNext: { [weak self]  (_) in
                
                guard let `self` = self else { return }
                
                DNotificationConfigration.postNotification(withName: NSNotification.Name(rawValue: DNotificationLoginSucc), andValue: nil, andFrom: self)
                
            })
            .disposed(by: disposed)
        
        viewModel
            .output
            .passwordItemed
            .drive(password.passwordItem.rx.isSelected)
            .disposed(by: disposed)
        
        viewModel
            .output
            .passwordEntryed
            .drive(password.rx.isSecureTextEntry)
            .disposed(by: disposed)
        
    }
    override open func configNaviItem() {
        
        title = "登录"
        
        if let config = config {
            
            backItem.setImage(UIImage(named: config.backIcon), for: .normal)
            
            backItem.setImage(UIImage(named: config.backIcon), for: .highlighted)
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backItem)
        }
    }
}


