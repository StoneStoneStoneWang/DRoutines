//
//  WLAreaManager.swift
//  DAddressDemo
//
//  Created by three stone 王 on 2019/7/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseResult
import RxCocoa
import DRoutinesKit
import RxSwift
import DPrepare

@objc (WLAreaManager)
public class WLAreaManager: NSObject {
    
    static let `default`: WLAreaManager = WLAreaManager()
    
    private override init() { }
    // 全部地区
    var allAreas: [WLAreaBean] = []
    // 所有省
    
    var provinces: [WLAreaBean] = []
    // 所有市
    
    var cities: [WLAreaBean] = []
    // 所有区县
    
    var regions: [WLAreaBean] = []
}

extension WLAreaManager {
    
    func fetchAreas() -> Observable<[String:Any]> {
        
        return Observable<[String:Any]>.create({ (observer) -> Disposable in
            
            var params = req.params
            
            if !WLAccountCache.default.token.isEmpty {
                
                params.updateValue(WLAccountCache.default.token, forKey: "token")
            }
            
            if let info = Bundle.main.infoDictionary {
                
                params.updateValue(info["CFBundleDisplayName"] as? String ?? "", forKey: "displayname")
            }
            
            if let buddleId = Bundle.main.bundleIdentifier {
                
                params.updateValue(buddleId, forKey: "buddleId")
            }
            
            let appkey = DConfigure.fetchAppKey()
            
            params.updateValue(appkey, forKey: "appkey")
            
            let sign = DSignCreate.createSign(params)
            
            params.updateValue(sign, forKey: "sign")
            
            let sinature = DConfigure.fetchSignature()
            
            params.updateValue(sinature, forKey: "sinature")
            
            request(URL(string: req.host + req.reqName)!, method: req.method, parameters: params, encoding: URLEncoding.default, headers: req.headers).responseJSON { (response) in
                
                switch response.result {
                    
                case let .success(result):
                    
                    if JSONSerialization.isValidJSONObject(result) {
                        
                        if let base = WLBaseBean(JSON: result as! [String : Any]) {
                            
                            switch base.code {
                            case .succ:
                                
                                observer.onNext(base.data as! [String:Any])
                                
                                observer.onCompleted()
                                
                            case .fail:
                                
                                observer.onError(WLBaseError.ServerResponseError(base.msg))
                                
                            case .tokenInvalid:
                                
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tokenInvalid"), object: nil, userInfo: nil)
                                
                                observer.onError(WLBaseError.ServerResponseError(base.msg))
                            default:
                                observer.onError(WLBaseError.ServerResponseError(base.msg))
                            }
                            
                        } else {
                            
                            observer.onError(WLBaseError.MapperError("invalid json"))
                        }
                        
                    } else {
                        
                        observer.onError(WLBaseError.MapperError("invalid json"))
                    }
                    
                case let .failure(error):
                    
                    observer.onError(WLBaseError.HTTPFailed(error))
                }
            }
            
            return Disposables.create { }
        })
    }
}
