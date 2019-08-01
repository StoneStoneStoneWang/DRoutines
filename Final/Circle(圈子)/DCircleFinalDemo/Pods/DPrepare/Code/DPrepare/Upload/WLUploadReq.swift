//
//  WLUploadReq.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLReqKit
import RxSwift
import WLToolsKit
import DSign
import DRoutinesKit
import DUpload

public func onAliDictResp<T : WLObserverReq>(_ req: T) -> Observable<DALCredentialsBean> {
    
    return Observable<DALCredentialsBean>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        if !WLAccountCache.default.token.isEmpty {
            
            params.updateValue(WLAccountCache.default.token, forKey: "token")
        }
        
        DUploadManager.fetchAliObj(withUrl: req.host + req.reqName , andParams: params, andHeader: req.headers, andSucc: { (credentials) in
            
            observer.onNext(credentials)
            
            observer.onCompleted()
            
        }, andFail: { (error) in
            
            let ocError = error as NSError
            
            if ocError.code == 131 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }
                
            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

public func onUploadImgResp(_ data: Data ,file: String ,param: DALCredentialsBean) -> Observable<String> {
    
    return Observable<String>.create({ (observer) -> Disposable in
        
        DUploadManager.uploadAvatar(with: data, andFile: file, andUid: WLAccountCache.default.uid, andParams: param, andSucc: { (objKey) in
            
            observer.onNext(objKey)
            
            observer.onCompleted()
            
        }, andFail: { (error) in
            
            let ocError = error as NSError
            
            if ocError.code == 132 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }
                
            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

public func onUploadPubImgResp(_ data: Data ,file: String ,param: DALCredentialsBean) -> Observable<String> {
    
    return Observable<String>.create({ (observer) -> Disposable in
        
        DUploadManager.uploadImage(with: data, andFile: file, andUid: WLAccountCache.default.uid, andParams: param, andSucc: { (objKey) in
            
            observer.onNext(objKey)
            
            observer.onCompleted()
            
        }, andFail: { (error) in
            
            let ocError = error as NSError
            
            if ocError.code == 132 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }
                
            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}
public func onUploadVideoResp(_ data: Data ,file: String ,param: DALCredentialsBean) -> Observable<String> {
    
    return Observable<String>.create({ (observer) -> Disposable in
        
        DUploadManager.uploadVideo(with: data, andFile: file, andUid: WLAccountCache.default.uid, andParams: param, andSucc: { (objKey) in
            
            observer.onNext(objKey)
            
            observer.onCompleted()

        }, andFail: { (error) in
            
            let ocError = error as NSError
            
            if ocError.code == 132 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }
                
            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })

        return Disposables.create { }
    })
}
