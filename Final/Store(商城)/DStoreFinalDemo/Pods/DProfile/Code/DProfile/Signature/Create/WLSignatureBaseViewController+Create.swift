//
//  WLSignatureBaseViewController+Create.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import WLBaseViewController

extension WLSignatureBaseViewController {
    
    @objc (creatSignatureWithConfig:)
    public static func creatSignature(_ config: WLUserInfoConfig) -> WLSignatureBaseViewController {
        
        return WLSignatureViewController(config)
    }
}

extension Reactive where Base: WLSignatureBaseViewController {
    
    public static func creatSignature(_ signature: String,config: WLUserInfoConfig, parent: UIViewController) -> Observable<WLSignatureBaseViewController> {
        
        return Observable.create { [weak parent] (observer) -> Disposable in
            
            let sa = WLSignatureBaseViewController.creatSignature(config)
            
            sa.signature.accept(signature)
            
            let nav = WLNaviController(rootViewController: sa)
            
            _ = sa.view
            
            parent?.present(nav, animated: true, completion: nil)
            
            observer.onNext(sa)
            
            return Disposables.create {
                
                sa.dismiss(animated: true, completion: nil)
            }
        }
    }
}
