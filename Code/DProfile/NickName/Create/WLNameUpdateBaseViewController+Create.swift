//
//  WLNameUpdateBaseViewController+Create.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import WLBaseViewController

extension WLNameUpdateBaseViewController {
    
    @objc (createNickNameWithConfig:)
    public static func createNickName(_ config: WLUserInfoConfig) -> WLNameUpdateBaseViewController {
        
        return WLNameUpdateViewController(config)
    }
}

extension Reactive where Base: WLNameUpdateBaseViewController {
    
    public static func creatUpdateName(_ nickname: String ,config: WLUserInfoConfig,_ parent: UIViewController) -> Observable<WLNameUpdateBaseViewController> {
        
        return Observable.create { [weak parent] (observer) -> Disposable in
            
            let updateName = WLNameUpdateBaseViewController.createNickName(config)
            
            updateName.nickname.accept(nickname)
            
            let nav = WLNaviController(rootViewController: updateName)
            
            _ = updateName.view
            
            parent?.present(nav, animated: true, completion: nil)
            
            observer.onNext(updateName)
            
            return Disposables.create {
                
                updateName.dismiss(animated: true, completion: nil)
            }
        }
    }
}
