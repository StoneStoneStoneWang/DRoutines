//
//  WLMAMapViewModel.swift
//  WLMapkitDemo
//
//  Created by three stone 王 on 2019/5/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLProfileKit
import WLCircleKit
import WLReqKit
import WLToolsKit

struct WLMAMapViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<WLMapPublishBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let config: WLMapConfig
        
        let completeTaps: Signal<Void>
        
        let tag: String
    }
    struct WLOutput {
        
        let zip: Observable<(WLMapPublishBean,IndexPath)>
        
        let tableData: BehaviorRelay<[WLMapPublishBean]> = BehaviorRelay<[WLMapPublishBean]>(value: [])
        
        let completing: Driver<Void>
        
        var completed: Driver<WLUserResult>
    }
    init(_ input: WLInput) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let completing: Driver<Void> = input.completeTaps.flatMap { Driver.just($0) }
        
        var output = WLOutput(zip: zip, completing: completing, completed: Driver<WLUserResult>.just(WLUserResult.empty))
        
        output.completed = input.completeTaps.withLatestFrom(output.tableData.asDriver()).flatMapLatest {
            
            var arr: [[String: String]] = []
            for item in $0 {
                
                var res: [String: String] = [:]
                
                res.updateValue(item.type, forKey: "type")
                
                res.updateValue(item.value, forKey: "value")
                
                arr += [res]
            }
            
            return onUserDictResp(WLMainApi.publish(input.tag, content: WLJsonCast.cast(argu: arr)))
                .mapObject(type: WLCircleBean.self)
                .map({ WLUserResult.operation($0) })
                .asDriver(onErrorRecover: { return Driver.just(WLUserResult.failed(($0 as! WLBaseError).description.0)) })
        }
    
        for item in input.config.pubs {
            
            let res = WLMapPublishBean(JSON: item)
            
            output.tableData.accept( output.tableData.value + [res!])
        }
        
        self.output = output
    }
}
