//
//  WLCommentViewModel.swift
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

struct WLCommentViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<WLCommentBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let headerRefresh: Driver<Void>
        
        let footerRefresh: Driver<Void>
        
        let page: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 1)
        
        let encoded: String
    }
    
    struct WLOutput {
        
        let zip: Observable<(WLCommentBean,IndexPath)>
        
        let tableData: BehaviorRelay<[WLCommentBean]> = BehaviorRelay<[WLCommentBean]>(value: [])
        
        let endHeaderRefreshing: Driver<WLBaseResult>
        
        let endFooterRefreshing: Driver<WLBaseResult>
        
        let footerHidden: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: true)
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let headerRefreshData = input
            .headerRefresh
            .startWith(())
            .flatMapLatest({_ in
                
                return onUserArrayResp(WLMainApi.fetchComments(1, targetEncoded: input.encoded))
                    .mapArray(type: WLCommentBean.self)
                    .map({ return $0.count > 0 ? WLBaseResult.fetchList($0) : WLBaseResult.empty })
                    .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
            })
        
        let endHeaderRefreshing = headerRefreshData.map { $0 }
        
        let footerRefreshData = input
            .footerRefresh
            .flatMapLatest({_ in
                
                return onUserArrayResp(WLMainApi.fetchComments(input.page.value, targetEncoded: input.encoded))
                    .mapArray(type: WLCommentBean.self)
                    .map({ return $0.count > 0 ? WLBaseResult.fetchList($0) : WLBaseResult.empty })
                    .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
            })
        
        let endFooterRefreshing = footerRefreshData.map { $0 }
        
        let output = WLOutput(zip: zip, endHeaderRefreshing: endHeaderRefreshing, endFooterRefreshing: endFooterRefreshing)
        
        headerRefreshData
            .drive(onNext: { (result) in
                
                var rectangle = WLCommentBean()
                
                rectangle.type = .rectangle
                
                rectangle.content = ""
                
                rectangle.encoded = NSUUID().uuidString
                
                rectangle.identity = NSUUID().uuidString
                
                var total = WLCommentBean()
                
                total.type = .total
                
                total.content = "全部评论"
                
                total.encoded = NSUUID().uuidString
                
                total.identity = NSUUID().uuidString
                
                switch result {
                case let .fetchList(items):
                    
                    input.page.accept(2)
                    
                    if items.count < 20 {
                        
                        output.footerHidden.accept(true)
                        
                        input.page.accept(1)
                    } else {
                        
                        output.footerHidden.accept(false)
                    }
                    
                    output.tableData.accept([rectangle] + [total] + items as! [WLCommentBean])
                    
                    var noMore = WLCommentBean()
                    
                    noMore.encoded = NSUUID().uuidString
                    
                    noMore.identity = NSUUID().uuidString
                    
                    noMore.type = .noMore
                    
                    noMore.content = "没有更多了"
                    
                    output.tableData.accept(output.tableData.value + [noMore])
                    
                case .empty:
                    
                    var empty = WLCommentBean()
                    
                    empty.encoded = NSUUID().uuidString
                    
                    empty.identity = NSUUID().uuidString
                    
                    empty.type = .empty
                    
                    empty.content = "暂无评论"
                    
                    output.tableData.accept([rectangle,total,empty])
                case .failed:
                    
                    var failed = WLCommentBean()
                    
                    failed.type = .failed
                    
                    failed.identity = NSUUID().uuidString
                    
                    failed.encoded = NSUUID().uuidString
                    
                    output.tableData.accept([rectangle,total,failed])
                default: break
                }
            })
            .disposed(by: disposed)
        
        footerRefreshData
            .drive(onNext: { (result) in
                
                switch result {
                case let .fetchList(items):
                    
                    var page = input.page.value
                    
                    page += 1
                    
                    input.page.accept(page)
                    
                    if items.count < 20 {
                        
                        output.footerHidden.accept(true)
                        
                    } else {
                        
                        output.footerHidden.accept(false)
                    }
                    
                    var value = output.tableData.value
                    
                    value += (items as! [WLCommentBean])
                    
                    output.tableData.accept( value)
                    
                    var noMore = WLCommentBean()
                    
                    noMore.encoded = NSUUID().uuidString
                    
                    noMore.identity = NSUUID().uuidString
                    
                    noMore.type = .noMore
                    
                    noMore.content = "暂无评论"
                    
                    output.tableData.accept(output.tableData.value + [noMore])
                    
                case .failed:
                    
                    var failed = WLCommentBean()
                    
                    failed.encoded = NSUUID().uuidString
                    
                    failed.identity = NSUUID().uuidString
                    
                    failed.type = .failed
                    
                    failed.content = "网络错误 点击重新加载"
                    
                    output.tableData.accept(output.tableData.value + [failed])
                    
                default: break
                }
            })
            .disposed(by: disposed)
        
        self.output = output
    }
    
    static func addComment(_ encoded: String,content: String) -> Driver<WLBaseResult> {
        
        return onUserDictResp(WLMainApi.addComment(encoded, content: content, tablename: "CircleFriends", type: "0"))
            .mapObject(type: WLCommentBean.self)
            .map({ WLBaseResult.operation($0) })
            .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
    }
}
