//
//  WLPublishTableBaseViewController+Create.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/6.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import WLBaseViewController

extension WLPublishTableBaseViewController {
    
    @objc (createPublishWithTag:andStyle:)
    public static func createPublish(_ tag: String, style: WLPublishStyle) -> WLPublishTableBaseViewController {
        
        switch style {
            
        case .image: return WLPublish1ViewController(tag, style: style )
            
        default: return WLPublish1ViewController(tag,style: style)
            
        }
    }
}

extension Reactive where Base: WLPublishTableBaseViewController {
    
    public static func createPublish(_ tag: String, style: WLPublishStyle ,isPush: Bool, parent: UIViewController) -> Observable<WLPublishTableBaseViewController> {
        
        return Observable.create { [weak parent] (observer) -> Disposable in
            
            let publish = WLPublishTableBaseViewController.createPublish(tag, style: style)
            
            _ = publish.view
            
            if isPush {
                
                parent?.navigationController?.pushViewController(publish, animated: true)
            } else {
                
                let nav = WLNaviController(rootViewController: publish)
                
                parent?.present(nav, animated: true, completion: nil)
            }
            
            observer.onNext(publish)
            
            return Disposables.create {
                
                if isPush {
                    
                    publish.navigationController?.popViewController(animated: true)
                } else {
                    
                    publish.dismiss(animated: true, completion: nil)
                }
                
                
            }
        }
    }
}
