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
import RxSwift
import DPrepare
import WLReqKit
import Alamofire
import RxSwift
import WLThirdUtil.WLCacheUtil

@objc (WLAreaManager)
public class WLAreaManager: NSObject {
    
    static let `default`: WLAreaManager = WLAreaManager()
    
    private override init() { }
    // 全部地区
    var allAreas: [WLAreaBean] = []
}

extension WLAreaManager {
    
    public func fetchAreas() -> Driver<WLBaseResult> {
        
        if allAreas.count > 0 {
            
            return Driver.just(WLBaseResult.fetchList(allAreas))
        } else {
            
            if isAreaFileExist() {
                
                let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!
                
                let targetPath = cachePath + "/Areas"
                
                if let arr = NSArray(contentsOfFile: targetPath) {
                    
                    var mutable: [WLAreaBean] = []
                    
                    for item in arr {
                        
                        mutable += [WLAreaBean(JSON: item as! [String: Any])!]
                    }
                    
                    allAreas += mutable
                    
                    return Driver.just(WLBaseResult.fetchList(mutable))
                }
                
                return Driver.just(WLBaseResult.failed("获取本地数据失败!"))
            } else {
                
                return onAreaArrayResp(WLUserApi.fetchAreaJson)
                    .map({ WLAreaManager.default.saveArea($0) })
                    .map({ _ in WLBaseResult.fetchList(WLAreaManager.default.allAreas)  })
                    .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
            }
        }
    }
    
    public func fetchSomeArea(_ id: Int ,areas: [WLAreaBean])  -> WLAreaBean {
        
        assert(allAreas.count > 0, "请先调用 fetchArea")
        
        var result: WLAreaBean!
        
        for item in areas {
            
            if item.id == id {
                
                result = item
                
                break
            }
        }
        
        return result ?? WLAreaBean()
    }
    
    public func saveArea(_ areas: [Any]) -> [Any] {
        
        for item in areas {
            
            allAreas += [WLAreaBean(JSON: item as! [String: Any])!]
        }
        
        let mutable = NSMutableArray()
        
        mutable.addObjects(from: areas)
        
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!
        
        let targetPath = cachePath + "/Areas"
        
        mutable.write(toFile: targetPath, atomically: true)
        
        return areas
    }
    
    public func isAreaFileExist() -> Bool {
        
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!
        
        let targetPath = cachePath + "/Areas"
        
        return FileManager.default.fileExists(atPath: targetPath)
    }
}

public func onAreaArrayResp<T : WLObserverReq>(_ req: T) -> Observable<[Any]> {
    
    return Observable<[Any]>.create({ (observer) -> Disposable in
        
        request(URL(string: req.host + req.reqName)!, method: req.method, parameters: req.params, encoding: URLEncoding.default, headers: req.headers).responseJSON { (response) in
            
            switch response.result {
                
            case let .success(result):
                
                if JSONSerialization.isValidJSONObject(result) {
                    
                    observer.onNext(result as! [Any])
                    
                    observer.onCompleted()
                    
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
