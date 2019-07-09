//
//  File.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLReqKit
import DPrepare
import WLBaseResult

struct WLReportViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<WLReportBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let completeTaps: Signal<Void>
        
        let uid: String
        
        let encode: String
        
        /*  序列*/
        let report: Driver<String>
        
        let content: Driver<String>
    }
    
    struct WLOutput {
        
        let zip: Observable<(WLReportBean,IndexPath)>
        
        let tableData: BehaviorRelay<[WLReportBean]> = BehaviorRelay<[WLReportBean]>(value: WLReportBean.reports)
        
        /* 完成中... 序列*/
        let completing: Driver<Void>
        /* 完成结果... 序列*/
        let completed: Driver<WLBaseResult>
    }
    
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let combine = Driver.combineLatest(input.report.asDriver(),input.content.asDriver())
        
        let completing = input.completeTaps.flatMap { Driver.just($0) }
        
        let completed: Driver<WLBaseResult> = input
            .completeTaps
            .withLatestFrom(combine)
            .flatMapLatest {
                
                return onUserVoidResp(WLMainApi.report(input.uid, targetEncoded: input.encode, type: $0.0, content: $0.1))
                    .map({ _ in WLBaseResult.ok("举报成功") })
                    .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
        }
        
        self.output = WLOutput(zip: zip, completing: completing, completed: completed)
        
    }
    
}
