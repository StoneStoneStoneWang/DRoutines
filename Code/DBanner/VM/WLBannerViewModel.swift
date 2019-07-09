//
//  WLBannerViewModel.swift
//  HOwner-iOS
//
//  Created by three stone 王 on 2019/6/13.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift

struct WLBannerViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let contentoffSetX: Observable<CGFloat>
        
        let banners: [String]
        
        let modelSelect: ControlEvent<String>
        
        let itemSelect: ControlEvent<IndexPath>
        
        /* 定时器 序列*/
        let timer: Observable<Int> = Observable<Int>.timer(1, period: 2, scheduler: MainScheduler.instance)
        
    }
    
    struct WLOutput {
        
        let tableData: BehaviorRelay<[String]>
        
        let timered: Observable<Int>
        
        let zip: Observable<(String,IndexPath)>
        
    }
    
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let tableData: BehaviorRelay<[String]> = BehaviorRelay<[String]>(value: input.banners)
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        input
            .contentoffSetX
            .subscribe({ _ in })
            .disposed(by: disposed)
        
        let timered: Observable<Int> = Observable<Int>
            .create({ (ob) -> Disposable in
                
                input
                    .timer
                    .subscribe(onNext: { (res) in
                        
//                        printLog(message: res)
                        
                        ob.onNext(res + 1 + tableData.value.count / 2)
                        
                    })
                    .disposed(by: disposed)
                
                return Disposables.create { _ = input.timer.takeLast(tableData.value.count) }
            })
        
        self.output = WLOutput(tableData: tableData, timered: timered, zip: zip)
    }
}
