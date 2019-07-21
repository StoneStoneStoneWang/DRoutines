//
//  WLStoreViewModel.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLBaseResult
import WLToolsKit
import DPrepare
import WLReqKit

struct WLStoreDetailViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<WLKeyValueBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let commodity: WLCommodityBean
        
        let addTaps: Signal<Void>
    }
    
    struct WLOutput {
        
        let zip: Observable<(WLKeyValueBean,IndexPath)>
        
        let tableData: BehaviorRelay<[WLKeyValueBean]> = BehaviorRelay<[WLKeyValueBean]>(value: [])
        
        let added: Driver<Void>
    }
    init(_ input: WLInput) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let output = WLOutput(zip: zip, added: input.addTaps.flatMap { Driver.just($0) })
        
        output.tableData.accept(input.commodity.imgs)
        
        self.output = output
    }
    public static func addToCart(_ commodity: WLCommodityBean) -> Driver<WLBaseResult>{
        
        var contentMap: [WLKeyValueBean] = []
        
        
        for item in commodity.contentMap {
            
            if item.type == "image" {
                
                var temp = item
                
                temp.type = "txt"
                
                temp.value = "Image:\(item.value)"
                
                contentMap += [temp]
            } else {
                
                contentMap += [item]
            }
        }
        
        let content = WLJsonCast.cast(argu: contentMap.toJSON())
        
        return onUserDictResp(WLUserApi.publish("购物车", content: content))
            .mapObject(type: WLCommodityBean.self)
            .map({ _ in WLBaseResult.ok("添加到购物车成功") })
            .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
    }
}
