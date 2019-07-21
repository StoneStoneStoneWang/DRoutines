//
//  WLTextEditBaseViewController.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DPrepare
import RxSwift
import RxCocoa


extension Reactive where Base: WLTextEditBaseViewController {
    
    public var complete: Observable<String> {
        
        return self.base.completeItem.rx.tap.withLatestFrom(self.base.texttv.rx.text.orEmpty.asObservable())
    }
}

@objc (WLTextEditBaseViewController)
open class WLTextEditBaseViewController: WLF1DisposeViewController {
    
    public required init() {
        super.init(nibName: nil, bundle: nil)
        
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    final let texttv: UITextView = UITextView(frame: .zero).then {
        
        $0.font = UIFont.systemFont(ofSize: 15)
        
        $0.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    final let completeItem = UIButton(type: .custom).then {
        
        $0.setTitle("完成", for: .normal)
        
        $0.setTitle("完成", for: .highlighted)
        
        $0.setTitle("完成", for: .disabled)
        
        $0.sizeToFit()
        
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    override open func configNaviItem() {
        
        title = "编辑文案"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: completeItem)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButtonItem(imageName: "", target: self, action: #selector(dismissa))
    }
    
    open override func configViewModel() {
        
        completeItem
            .rx
            .tap
            .subscribe(onNext: { [unowned self] (_) in
                
                if !self.texttv.text.isEmpty {
                    
                    self.dismissa()
                }
                
            })
            .disposed(by: disposed)
    }
    
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        texttv.becomeFirstResponder()
    }
    
    @objc func dismissa() {
        
        view.endEditing(true)
        
        dismiss(animated: true, completion: nil)
    }
}

