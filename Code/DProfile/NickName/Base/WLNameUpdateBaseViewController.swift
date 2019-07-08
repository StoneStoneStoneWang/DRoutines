//
//  WLNameUpdateBaseViewController.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxSwift
import WLComponentView
import WLToolsKit
import RxCocoa
import WLThirdUtil.WLHudUtil
import DPrepare

extension Reactive where Base: WLNameUpdateBaseViewController {
    
    public var complete: Observable<WLUserBean> {
        
        return self.base.userBean.asObservable()
    }
}

@objc (WLNameUpdateBaseViewController)
open class WLNameUpdateBaseViewController: WLF1DisposeViewController {
    
    public var config: WLUserInfoConfig!

    public required init(_ config: WLUserInfoConfig) {
        super.init(nibName: nil, bundle: nil)
        
        self.config = config
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nickname: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    let userBean: BehaviorRelay<WLUserBean> = BehaviorRelay<WLUserBean>(value: WLUserInfoCache.default.userBean)
    
    public final let name: WLNickNameTextField = WLNickNameTextField(frame: .zero).then {
        
        $0.set_clearButtonMode(.whileEditing)
        
        $0.set_returnKeyType(.done)
    }
    
    var observer = Observable<String>.empty()
    
    final let completeItem = UIButton(type: .custom).then {
        
        $0.setTitle("完成", for: .normal)
        
        $0.setTitle("完成", for: .highlighted)
        
        $0.setTitle("完成", for: .disabled)
        
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        $0.sizeToFit()
    }
    
    override open func configNaviItem() {
        
        title = "修改昵称"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: completeItem)
        
        if let config = config {
            
            navigationItem.leftBarButtonItem = UIBarButtonItem.barButtonItem(imageName: config.backIcon, target: self, action: #selector(dismissa))
        }
    }
    
    var viewModel: WLUpdateNameViewModel!
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        name.becomeFirstResponder()
    }
    
    open override func configViewModel() {
        
        let inputs = WLUpdateNameViewModel.WLInput(orignal: nickname.asDriver(),
                                                   updated: name.rx.text.orEmpty.asDriver(),
                                                   completTaps: completeItem.rx.tap.asSignal())
        
        viewModel = WLUpdateNameViewModel(inputs)
        
        viewModel
            .output
            .completeEnabled
            .drive(completeItem.rx.isEnabled)
            .disposed(by: disposed)
        
        viewModel
            .output
            .completing
            .drive(onNext: { [weak self] (_) in
                
                guard let `self` = self else { return }
                
                self.name.resignFirstResponder()
                
                WLHudUtil.show(withStatus: "修改昵称...")
            })
            .disposed(by: disposed)
        
        viewModel
            .output
            .completed
            .drive(onNext: { [weak self ] (result) in
                
                guard let `self` = self else { return }
                
                WLHudUtil.pop()
                
                switch result {
                case let .updateUserInfoSucc(user, msg: msg):
                    
                    self.userBean.accept(user as! WLUserBean)
                    
                    WLHudUtil.showInfo(msg)
                    
                    self.dismiss(animated: true, completion: nil)
                    
                case let .failed(msg):
                    
                    WLHudUtil.showInfo(msg)
                default: break
                    
                }
            })
            .disposed(by: disposed)
    }
    
    @objc func dismissa() {
        
        view.endEditing(true)
        
        dismiss(animated: true, completion: nil)
    }
}
