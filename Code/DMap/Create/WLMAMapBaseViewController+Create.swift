//
//  WLMAMapBaseViewController+Create.swift
//  WLMapkitDemo
//
//  Created by three stone 王 on 2019/5/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxSwift
import WLBaseViewController

extension Reactive where Base: WLMAMapBaseViewController {
    
    public static func creatMapPush(_ style: WLMapStyle ,config: WLMapConfig,_ parent: UIViewController) -> Observable<WLMAMapBaseViewController> {
        
        return Observable.create { [weak parent] (observer) -> Disposable in
            
            let map = WLMAMapBaseViewController.createMap(style, config: config)
            
            let nav = WLNaviController(rootViewController: map)
            
            _ = map.view
            
            parent?.present(nav, animated: true, completion: nil)
            
            observer.onNext(map)
            
            return Disposables.create {
                
                map.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    public static func creatMapPresent(_ style: WLMapStyle ,config: WLMapConfig,_ parent: UIViewController) -> Observable<WLMAMapBaseViewController> {
        
        return Observable.create { [weak parent] (observer) -> Disposable in
            
            let map = WLMAMapBaseViewController.createMap(style, config: config)
            
            _ = map.view
            
            parent?.navigationController?.pushViewController(map, animated: true)
            
            observer.onNext(map)
            
            return Disposables.create {
                
                map.navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension WLMAMapBaseViewController {
    @objc (createMapWithStyle:andConfig:)
    public static func createMap(_ style: WLMapStyle ,config: WLMapConfig) -> WLMAMapBaseViewController {
        
        switch style {
        case .one: return WLMAMap1ViewController( config)
            
        case .two: return WLMAMap2ViewController( config)
            
        default: return WLMAMap1ViewController( config)
            
        }
    }
}
