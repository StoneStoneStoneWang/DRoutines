//
//  WLSwiftLoginBaseViewController.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLToolsKit
import WLThirdUtil.WLJPushUtil
import WLThirdUtil.WLHudUtil
import WLComponentView
import DPrepare
import DNotification

@objc (WLSwiftLoginBaseViewController)
open class WLSwiftLoginBaseViewController: WLBaseDisposeViewController {
    
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
    
    public final let vcode: WLVCodeImageTextField = WLVCodeImageTextField(frame: .zero).then {
        
        $0.set_editType(.vcode_length6)
        
        $0.set_maxLength(6)
    }
    
    public final let loginItem: UIButton = UIButton(type: .custom).then {
        
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        $0.layer.cornerRadius = 25
        
        $0.layer.masksToBounds = true
    }
    
    public final let backLoginItem: UIButton = UIButton(type: .custom).then {
        
        $0.setTitle("已有账号，返回登录", for: .normal)
        
        $0.setTitle("已有账号，返回登录", for: .highlighted)
        
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
    }
    
    var viewModel: WLSwiftLoginViewModel!
    
    public final let proItem: UIButton = UIButton(type: .custom).then {
        
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 13)
    }
    
    
    override open func configViewModel() {
        
        let input = WLSwiftLoginViewModel.WLInput(username: phone.rx.text.orEmpty.asDriver(),
                                                  vcode: vcode.rx.text.orEmpty.asDriver() ,
                                                  loginTaps: loginItem.rx.tap.asSignal(),
                                                  verifyTaps: vcode.vcodeItem.rx.tap.asSignal(),
                                                  backLoginTaps: backLoginItem.rx.tap.asSignal(),
                                                  proTaps: proItem.rx.tap.asSignal())
        
        viewModel = WLSwiftLoginViewModel(input, disposed: disposed)
        
        backLoginItem
            .rx
            .tap
            .subscribe(onNext: { [weak self] (_) in
                
                guard let `self` = self else { return }
                
                DNotificationConfigration.postNotification(withName: NSNotification.Name(rawValue: DNotificationBackLogin), andValue: nil, andFrom: self)
            })
            .disposed(by: disposed)
        
        // MARK: 登录点击中序列
        viewModel
            .output
            .logining
            .drive(onNext: { [weak self] _ in
                
                guard let `self` = self else { return }
                
                self.view.endEditing(true)
                
                WLHudUtil.show(withStatus: "注册登录中...")
                
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
                    
                    WLHudUtil.showInfo("注册成功")
                    
                    WLJPushUtil.shared().jp_setAlias(WLAccountCache.default.uid, completion: { (_, _, _) in
                        
                    }, seq: 1)
                    
                    DNotificationConfigration.postNotification(withName: NSNotification.Name(rawValue: DNotificationRegSucc), andValue: nil, andFrom: self)
                    
                default: break
                }
            })
            .disposed(by: disposed)
        
        viewModel
            .output
            .pro
            .drive(onNext: {[weak self] (_) in
                
                guard let `self` = self else { return }
                
                DNotificationConfigration.postNotification(withName: NSNotification.Name(rawValue: DNotificationGotoProtocol), andValue: nil, andFrom: self)
            })
            .disposed(by: disposed)
        
        viewModel
            .output
            .verifying
            .drive(onNext: { [weak self] (_) in
                
                guard let `self` = self else { return }
                
                self.view.endEditing(true)
                
                WLHudUtil.show(withStatus: "获取验证码中...")
            })
            .disposed(by: disposed)
        
        viewModel
            .output
            .smsRelay
            .asObservable()
            .bind(to: vcode.vcodeItem.rx.sms)
            .disposed(by: disposed)
        
        viewModel
            .output
            .verifyed
            .drive(onNext: { [weak self] result in
                
                guard let `self` = self else { return }
                switch result {
                case let .failed(message: msg):
                    WLHudUtil.pop()
                    WLHudUtil.showInfo(msg)
                case let .ok(msg):
                    WLHudUtil.pop()
                    WLHudUtil.showInfo(msg)
                case let .smsOk(isEnabled: isEnabled, title: title):
                    
                    self.viewModel.output.smsRelay.accept((isEnabled,title))
                default: break
                    
                }
            })
            .disposed(by: disposed)
        
    }
    
    open override func configNaviItem() {
        
        title = "注册/登陆"
    }
}
