//
//  WLAddressEditViewModel.swift
//  DAddressDemo
//
//  Created by three stone 王 on 2019/7/17.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLBaseResult
import DPrepare
import WLReqKit

struct WLAddressEditViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let addressBean: BehaviorRelay<WLAddressBean>
        
        let modelSelect: ControlEvent<WLAddressEditBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let addTaps: Signal<Void>
        
        let tableData: BehaviorRelay<[WLAddressEditBean]> = BehaviorRelay<[WLAddressEditBean]>(value: WLAddressEditBean.editTypes)
    }
    
    struct WLOutput {
        
        let zip: Observable<(WLAddressEditBean,IndexPath)>
        
        let adding: Driver<Void>
        
        let added: Driver<WLBaseResult>
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let value = input.tableData.value
        
        let name = value[0]
        
        name.value = input.addressBean.value.name
        
        let phone = value[1]
        
        phone.value = input.addressBean.value.phone
        
        let area = value[2]

        area.pArea.id = input.addressBean.value.plcl
        
        area.pArea.name = input.addressBean.value.plclne
        
        area.cArea.id = input.addressBean.value.city
        
        area.cArea.name = input.addressBean.value.cityne
        
        area.rArea.id = input.addressBean.value.region
        
        area.rArea.name = input.addressBean.value.regionne
        
        let detail = value[3]

        detail.value = input.addressBean.value.addr
        
        let def = value[4]
        
        def.isDef = input.addressBean.value.isdel
        
        input.tableData.accept([name,phone,area,detail,def])
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let adding: Driver<Void> = input.addTaps.flatMap { Driver.just($0) }
        
        let added: Driver<WLBaseResult> = input.addTaps.withLatestFrom(input.tableData.asDriver())
            .flatMapLatest {
                
                if $0[0].value.isEmpty {
                    
                    return Driver<WLBaseResult>.just(WLBaseResult.failed("请填写收货人姓名"))
                }
                if $0[1].value.isEmpty {
                    
                    return Driver<WLBaseResult>.just(WLBaseResult.failed("请填写收货人手机号"))
                }
                if !String.validPhone(phone: $0[1].value) {
                    
                    return Driver<WLBaseResult>.just(WLBaseResult.failed("请填写收货人11位手机号"))
                }
                
                if $0[2].pArea.name.isEmpty {
                    
                    return Driver<WLBaseResult>.just(WLBaseResult.failed("请选择所在地区"))
                }
                
                if $0[3].value.isEmpty {
                    
                    return Driver<WLBaseResult>.just(WLBaseResult.failed("请填写详细地址"))
                }
                
                return onUserDictResp(WLUserApi.editAddress(input.addressBean.value.encoded, name: $0[0].value, phone: $0[1].value, plcl: $0[2].pArea.id, plclne: $0[2].pArea.name, city: $0[2].cArea.id, cityne: $0[2].cArea.name, region: $0[2].rArea.id, regionne: $0[2].rArea.name, addr: $0[3].value, isdef: $0[4].isDef, zipCode: ""))
                    .mapObject(type: WLAddressBean.self)
                    .map({ WLBaseResult.operation($0) })
                    .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
        }
        self.output = WLOutput(zip: zip, adding: adding,added: added)
        
    }
}

