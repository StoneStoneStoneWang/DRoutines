//
//  WLUserInfoViewModel.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLReqKit
import DPrepare
import WLBaseResult


public struct WLUserInfoViewModel: WLBaseViewModel {
    
    public var input: WLInput
    
    public var output: WLOutput
    
    public struct WLInput {
        
        let modelSelect: ControlEvent<WLUserInfoBean>
        
        let itemSelect: ControlEvent<IndexPath>
    }
    public struct WLOutput {
        
        let zip: Observable<(WLUserInfoBean,IndexPath)>
        
        let tableData: BehaviorRelay<[WLUserInfoBean]> = BehaviorRelay<[WLUserInfoBean]>(value: WLUserInfoBean.types)
    }
    public init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let output = WLOutput(zip: zip)
        
        WLUserInfoCache.default
            .rx
            .observe(WLUserBean.self, "userBean")
            .subscribe(onNext: { (user) in
                
                if let user = user {
                    
                    output.tableData.value[1].subtitle = user.headImg
                    
                    output.tableData.value[2].subtitle = user.nickname
                    
                    output.tableData.value[3].subtitle = user.phone
                    
                    output.tableData.value[5].subtitle = user.gender.gender
                    
                    output.tableData.value[6].subtitle = user.birthday
                    
                    output.tableData.value[7].subtitle = user.signature
                }
            })
            .disposed(by: disposed)
        
        self.output = output
    }
    
    public static func updateUserInfo(type: WLUserInfoType,value: String) -> Driver<WLBaseResult>{
        
        return onUserDictResp(WLUserApi.updateUserInfo(type.updateKey, value: value))
            .mapObject(type: WLUserBean.self)
            .map { WLBaseResult.updateUserInfoSucc($0, msg: type.title + "修改成功")}
            .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
    }
    
    public static func fetchAliToken() -> Driver<WLBaseResult> {
        
        return onAliDictResp(WLUserApi.aliToken)
            .map { WLBaseResult.fetchSomeObject($0 as AnyObject)}
            .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
    }
}

