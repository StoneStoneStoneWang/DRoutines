//
//  WLBaseReq.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/14.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLReqKit
import RxSwift
import WLToolsKit
import DSign
import DRoutinesKit
import DReq

public func onUserDictResp<T : WLObserverReq>(_ req: T) -> Observable<[String:Any]> {
    
    return Observable<[String:Any]>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        if !WLAccountCache.default.token.isEmpty {
            
            params.updateValue(WLAccountCache.default.token, forKey: "token")
        }
        
        DReqManager.post(withUrl: req.host + req.reqName, andParams: params, andHeader: req.headers, andSucc: { (data) in
            
            observer.onNext(data as! [String:Any])
            
            observer.onCompleted()
            
        }, andFail: { (error) in
            
            let ocError = error as NSError
            
            if ocError.code == 122 || ocError.code == 123 || ocError.code == 124 || ocError.code == 121 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }
            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

public func onUserArrayResp<T : WLObserverReq>(_ req: T) -> Observable<[Any]> {
    
    return Observable<[Any]>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        if !WLAccountCache.default.token.isEmpty {
            
            params.updateValue(WLAccountCache.default.token, forKey: "token")
        }
        DReqManager.post(withUrl: req.host + req.reqName, andParams: params, andHeader: req.headers, andSucc: { (data) in
            
            observer.onNext(data as! [Any])
            
            observer.onCompleted()
            
        }, andFail: { (error) in
            
            let ocError = error as NSError
            
            if ocError.code == 122 || ocError.code == 123 || ocError.code == 124 || ocError.code == 121 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }
            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

// 无返回值的 在data里
public func onUserVoidResp<T : WLObserverReq>(_ req: T) -> Observable<Void> {
    
    return Observable<Void>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        if !WLAccountCache.default.token.isEmpty {
            
            params.updateValue(WLAccountCache.default.token, forKey: "token")
        }
        
        DReqManager.post(withUrl: req.host + req.reqName, andParams: params, andHeader: req.headers, andSucc: { (data) in
            
            observer.onNext(())
            
            observer.onCompleted()
            
        }, andFail: { (error) in
            
            let ocError = error as NSError
            
            if ocError.code == 122 || ocError.code == 123 || ocError.code == 124 || ocError.code == 121 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }
            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}
