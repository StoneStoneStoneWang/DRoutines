//
//  WLStoreOrderConfirmViewModel.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLBaseResult
import ObjectMapper
import DPrepare
import WLReqKit
import WLToolsKit
import DAddress

struct WLStoreOrderConfirmViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let address: WLAddressBean!
        
        let commodity: WLCommodityBean
        
        let modelSelect: ControlEvent<WLStoreOrderConfirmBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let addTaps: Signal<Void>
        
        let tableData: BehaviorRelay<[WLStoreOrderConfirmBean]> = BehaviorRelay<[WLStoreOrderConfirmBean]>(value: [])
    }
    
    struct WLOutput {
        
        let zip: Observable<(WLStoreOrderConfirmBean,IndexPath)>
        
        let added: Driver<WLBaseResult>
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        
        
        let added: Driver<WLBaseResult> = input.addTaps.withLatestFrom(input.tableData.asDriver()).flatMapLatest {
            
            if $0[1].address == nil {
                
                return Driver<WLBaseResult>.just(WLBaseResult.failed("请选择地址"))
            }
            
            //            "user/zhihe/" + time + "/" + file + "/" + WLAccountCache.default.uid + "/" + "\(WLAccountCache.default.uid).png";
            let address = WLKeyValueBean(JSON: ["type":"txt","value": "Address:\($0[1].address!.encoded)"])!
            
            var contentMap: [WLKeyValueBean] = []
            
            for item in input.commodity.contentMap {
                
                if item.type == "image" {
                    
                    var temp = item
                    
                    temp.type = "txt"
                    
                    temp.value = "Image:\(item.value)"
                    
                    contentMap += [temp]
                } else {
                    
                    contentMap += [item]
                }
            }
            contentMap += [address]
            
            let content = WLJsonCast.cast(argu: contentMap.toJSON())
            
            return onUserDictResp(WLUserApi.publish("订单", content: content))
                .mapObject(type: WLCommodityBean.self)
                .map({ _ in WLBaseResult.ok("添加订单成功") })
                .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
            
        }
        
        let output = WLOutput(zip: zip, added: added)
        
        let address = WLStoreOrderConfirmBean()
        
        address.type = .address
        
        address.address = input.address
        
        let commodity = WLStoreOrderConfirmBean()
        
        commodity.type = .commodity
        
        commodity.commodity = input.commodity
        
        let contactUs = WLStoreOrderConfirmBean()
        
        contactUs.type = .contactUs
        
        contactUs.commodity = input.commodity
        
        let introduce = WLStoreOrderConfirmBean()
        
        introduce.type = .introduce
        
        introduce.commodity = input.commodity
        
        let space1 = WLStoreOrderConfirmBean()
        
        space1.type = .space
        
        let space2 = WLStoreOrderConfirmBean()
        
        space2.type = .space
        
        let space3 = WLStoreOrderConfirmBean()
        
        space3.type = .space
        
        let space4 = WLStoreOrderConfirmBean()
        
        space4.type = .space
        
        input.tableData.accept([space1,address,space2,commodity,space3,contactUs,space4,introduce])
        
        self.output = output
    }
}
