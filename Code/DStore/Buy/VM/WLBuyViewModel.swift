//
//  WLBuyViewModel.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift

struct WLBuyViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<WLBuyBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let commodity: WLCommodityBean!
    }
    
    struct WLOutput {
        
        let zip: Observable<(WLBuyBean,IndexPath)>
        
        let tableData: BehaviorRelay<[WLBuyBean]> = BehaviorRelay<[WLBuyBean]>(value: [])
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let output = WLOutput(zip: zip)
        
        let commodity = WLBuyBean()
        
        commodity.type = .commodity
        
        commodity.commodity = input.commodity
        
        let space = WLBuyBean()
        
        space.type = .space
        
        output.tableData.accept([commodity,space])
        
        self.output = output
    }
}
