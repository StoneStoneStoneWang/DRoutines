//
//  WLModifyPwdBaseViewController.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLToolsKit
import WLThirdUtil.WLHudUtil
import WLComponentView
import DPrepare
import DNotification

@objc (WLModifyPwdBaseViewController)
open class WLModifyPwdBaseViewController: WLBaseDisposeViewController {
    
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
    
    public final let oldpassword: WLPasswordImageTextFiled = WLPasswordImageTextFiled(frame: .zero).then {
        
        $0.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - 80, height: 1))
    }
    
    public final let password: WLPasswordImageTextFiled = WLPasswordImageTextFiled(frame: .zero).then {
        
        $0.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - 80, height: 1))
        
    }
    
    public final let passwordAgain: WLPasswordImageTextFiled = WLPasswordImageTextFiled(frame: .zero).then {
        
        $0.set_bottomLineFrame(CGRect(x: 0, y: 59, width: WL_SCREEN_WIDTH - 80, height: 1))
    }
    
    public final let completeItem: UIButton = UIButton(type: .custom).then {
        
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        $0.layer.cornerRadius = 25
        
        $0.layer.masksToBounds = true
    }
    
    var viewModel: WLModifyPwdViewModel!
    
    override open func configViewModel() {
        
        let input = WLModifyPwdViewModel.WLInput(oldpassword: oldpassword.rx.text.orEmpty.asDriver(),
                                                 password: password.rx.text.orEmpty.asDriver() ,
                                                 passwordAgain: passwordAgain.rx.text.orEmpty.asDriver(),
                                                 completeTaps: completeItem.rx.tap.asSignal())
        
        viewModel = WLModifyPwdViewModel(input, disposed: disposed)
        
        // MARK: 修改密码 点击
        viewModel
            .output
            .completing
            .drive(onNext: { [weak self] _ in
                
                guard let `self` = self else { return }
                
                self.view.endEditing(true)
                
                WLHudUtil.show(withStatus: "修改密码中...")
                
            })
            .disposed(by: disposed)
        
        // MARK: 修改密码 完成
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
                    
                    DNotificationConfigration.postNotification(withName: NSNotification.Name(rawValue: DNotificationModifyPwdSucc), andValue: nil, andFrom: self)
                    
                default: break
                }
            })
            .disposed(by: disposed)
        
    }
    override open func configNaviItem() {
        
        title = "修改密码"
    }
}
