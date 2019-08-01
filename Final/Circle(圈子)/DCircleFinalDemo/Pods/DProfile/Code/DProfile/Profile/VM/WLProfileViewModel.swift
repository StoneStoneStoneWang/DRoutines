//
//  WLProfileViewModel.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import DPrepare

struct WLProfileViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<WLProfileType>
        
        let itemSelect: ControlEvent<IndexPath>
    }
    
    struct WLOutput {
        
        let zip: Observable<(WLProfileType,IndexPath)>
        
        let tableData: BehaviorRelay<[WLProfileType]> = BehaviorRelay<[WLProfileType]>(value: WLProfileType.types)
        
        let userInfo: Observable<WLUserBean?>
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let userInfo: Observable<WLUserBean?> = WLUserInfoCache.default.rx.observe(WLUserBean.self, "userBean")
        
        WLUserInfoCache.default.userBean = WLUserInfoCache.default.queryUser()
        
        onUserDictResp(WLUserApi.fetchProfile)
            .mapObject(type: WLUserBean.self)
            .map({ WLUserInfoCache.default.saveUser(data: $0) })
            .subscribe(onNext: { (_) in })
            .disposed(by: disposed)
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        self.output = WLOutput(zip: zip, userInfo: userInfo)
    }
}

