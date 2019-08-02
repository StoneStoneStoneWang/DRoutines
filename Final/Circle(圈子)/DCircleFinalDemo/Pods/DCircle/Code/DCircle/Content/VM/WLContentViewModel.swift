//
//  WLContentViewModel.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift

struct WLContentViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<WLPublishBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let circle: WLCircleBean
    }
    
    struct WLOutput {
        
        let zip: Observable<(WLPublishBean,IndexPath)>
        
        let tableData: BehaviorRelay<[WLPublishBean]> = BehaviorRelay<[WLPublishBean]>(value: [])
    }
    init(_ input: WLInput) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let output = WLOutput(zip: zip)
        
        output.tableData.accept(input.circle.contentMap)
        
        self.output = output
    }
}
