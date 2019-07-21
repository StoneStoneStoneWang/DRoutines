//
//  WLTextEditBaseViewController+Create.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxSwift
import WLBaseViewController

extension WLTextEditBaseViewController {
    
    @objc (creatTextEdit)
    public static func creatTextEdit() -> WLTextEditBaseViewController {
        
        return WLTextEditViewController()
    }
    
}

extension Reactive where Base: WLTextEditBaseViewController {
    
    public static func creatTextEdit(_ text: String, parent: UIViewController) -> Observable<WLTextEditBaseViewController> {
        
        return Observable.create { [weak parent] (observer) -> Disposable in
            
            let te = WLTextEditBaseViewController.creatTextEdit()
            
            te.texttv.text = text
            
            let nav = WLNaviController(rootViewController: te)
            
            _ = te.view
            
            parent?.present(nav, animated: true, completion: nil)
            
            observer.onNext(te)
            
            return Disposables.create {
                
                te.dismiss(animated: true, completion: nil)
            }
        }
    }
}
