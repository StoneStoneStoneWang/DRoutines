//
//  WLBlackListViewModel.swift
//  HZTC
//
//  Created by three stone 王 on 2019/3/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLReqKit
import ObjectMapper
import WLBaseResult
import DPrepare

struct WLBlackListViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<WLBlackListBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let headerRefresh: Driver<Void>
    }
    struct WLOutput {
        
        let zip: Observable<(WLBlackListBean,IndexPath)>
        
        let tableData: BehaviorRelay<[WLBlackListBean]> = BehaviorRelay<[WLBlackListBean]>(value: [])
        
        let endHeaderRefreshing: Driver<WLBaseResult>
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let headerRefreshData = input
            .headerRefresh
            .startWith(())
            .flatMapLatest({_ in
                return onUserArrayResp(WLUserApi.fetchBlackList)
                    .mapArray(type: WLBlackListBean.self)
                    .map({ return $0.count > 0 ? WLBaseResult.fetchList($0) : WLBaseResult.empty })
                    .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
            })
        
        let endHeaderRefreshing = headerRefreshData.map { $0 }
        
        let output = WLOutput(zip: zip, endHeaderRefreshing: endHeaderRefreshing)
        
        headerRefreshData
            .drive(onNext: { (result) in
                
                switch result {
                case let .fetchList(items):
                    
                    output.tableData.accept(items as! [WLBlackListBean])
                    
                default: break
                }
            })
            .disposed(by: disposed)
        
        self.output = output
    }
}
extension WLBlackListViewModel {
    
    static func removeBlack(_ encode: String) -> Driver<WLBaseResult> {
        
        return onUserVoidResp(WLUserApi.removeBlack(encode))
            .flatMapLatest({ return Driver.just(WLBaseResult.ok("移除成功")) })
            .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
    }
}
