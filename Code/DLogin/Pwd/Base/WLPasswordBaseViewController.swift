//
//  WLPasswordBaseViewController.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLThirdUtil.WLHudUtil
import WLComponentView
import DPrepare

@objc (WLPasswordBaseViewController)
open class WLPasswordBaseViewController: WLBaseDisposeViewController {
    
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
    
    public final let password: WLPasswordImageTextFiled = WLPasswordImageTextFiled(frame: .zero)
    
    public final let completeItem: UIButton = UIButton(type: .custom).then {
        
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        $0.layer.cornerRadius = 25
        
        $0.layer.masksToBounds = true
    }
    
    var viewModel: WLPwdViewModel!
    
    open override func configOwnSubViews() {
        super.configOwnSubViews()
        
    }
    
    override open func configViewModel() {
        
        let input = WLPwdViewModel.WLInput(username: phone.rx.text.orEmpty.asDriver(),
                                           vcode: vcode.rx.text.orEmpty.asDriver() ,
                                           password: password.rx.text.orEmpty.asDriver(),
                                           verifyTaps: vcode.vcodeItem.rx.tap.asSignal(),
                                           completeTaps: completeItem.rx.tap.asSignal(),
                                           passwordItemTaps: password.passwordItem.rx.tap.asSignal())
        
        viewModel = WLPwdViewModel(input, disposed: disposed)
        
        // MARK: 完成点击中序列
        viewModel
            .output
            .completing
            .drive(onNext: { [weak self] _ in
                
                guard let `self` = self else { return }
                
                self.view.endEditing(true)
                
                WLHudUtil.show(withStatus: "找回密码中...")
                
            })
            .disposed(by: disposed)
        
        // MARK: 完成事件返回序列
        viewModel
            .output
            .completed
            .drive(onNext: { [weak self] in
                guard let `self` = self else { return }
                
                WLHudUtil.pop()
                
                switch $0 {
                    
                case let .failed(msg): WLHudUtil.showInfo(msg)
                    
                case let .ok(msg):
                    
                    WLHudUtil.showInfo(msg)
                    
                    self.navigationController?.popViewController(animated: true)
                    
                default: break
                }
            })
            .disposed(by: disposed)
        // 验证码序列
        viewModel
            .output
            .verifying
            .drive(onNext: { [weak self] (_) in
                
                guard let `self` = self else { return }
                
                self.view.endEditing(true)
                
                WLHudUtil.show(withStatus: "获取验证码中...")
            })
            .disposed(by: disposed)
        // 验证码结果序列
        viewModel
            .output
            .smsRelay
            .asObservable()
            .bind(to: vcode.vcodeItem.rx.sms)
            .disposed(by: disposed)
        // 验证码结果序列
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
        
        title = "修改密码"
    }
}


