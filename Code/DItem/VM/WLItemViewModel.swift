//
//  WLItemViewModel.swift
//  HOwner-iOS
//
//  Created by three stone 王 on 2019/6/13.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLToolsKit

struct WLItemViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let vcType: WLItemVCType
        
        let modelSelect: ControlEvent<WLItemType>
        
        let itemSelect: ControlEvent<IndexPath>
    }
    
    struct WLOutput {
        
        let tableData: BehaviorRelay<[WLItemType]>
        
        let zip: Observable<(WLItemType,IndexPath)>
        
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let tableData: BehaviorRelay<[WLItemType]> = BehaviorRelay<[WLItemType]>(value: input.vcType == .home ? WLItemType.homes : WLItemType.services)
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        self.output = WLOutput(tableData: tableData, zip: zip)
    }
}
