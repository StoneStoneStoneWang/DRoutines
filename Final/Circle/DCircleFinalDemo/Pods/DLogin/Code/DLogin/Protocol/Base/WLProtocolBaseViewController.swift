//
//  WLProtocolBaseViewController.swift
//  SRegDemo
//
//  Created by three stone 王 on 2019/6/11.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DPrepare

@objc (WLProtocolBaseViewController)
open class WLProtocolBaseViewController: WLInnerDisposeViewController {
    
    override open func configNaviItem() {
        
        title = "协议与隐私"
    }
    
    var viewModel: WLProtocolViewModel!
    
    override open func configViewModel() {
        
        let inputs = WLProtocolViewModel.WLInput()
        
        viewModel = WLProtocolViewModel(inputs)
        
        viewModel
            .output
            .contented
            .asObservable()
            .subscribe(onNext: { [weak self] (value) in
                
                guard let `self` = self else { return }
                
                DispatchQueue.main.async {
                    
                    self.loadHTML(value)
                }
                
            })
            .disposed(by: disposed)
    }
}


