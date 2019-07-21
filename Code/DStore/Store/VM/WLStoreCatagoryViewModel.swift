//
//  WLStoreCatagoryViewModel.swift
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

struct WLStoreCatagoryViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let headers: [[String: Any]]
        
        let modelSelect: ControlEvent<WLStoreHeaderBean>
        
        let itemSelect: ControlEvent<IndexPath>
    }
    
    struct WLOutput {
        
        let zip: Observable<(WLStoreHeaderBean,IndexPath)>
        
        let tableData: BehaviorRelay<[WLStoreHeaderBean]> = BehaviorRelay<[WLStoreHeaderBean]>(value: [])
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let output = WLOutput(zip: zip)
        
        output.tableData.accept(input.headers.map { WLStoreHeaderBean(JSON: $0)! })
        
        self.output = output
    }
}
