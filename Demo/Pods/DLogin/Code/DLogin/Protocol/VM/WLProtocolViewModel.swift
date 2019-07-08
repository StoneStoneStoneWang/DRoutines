//
//  WLProtocolViewModel.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxSwift
import WLBaseViewModel
import RxCocoa
import DRoutinesKit
struct WLProtocolViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
    }
    
    struct WLOutput {
        
        let contented: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    }
    init(_ input: WLInput) {
        
        self.input = input
        
        let output = WLOutput()
        //        https://zhih.ecsoi.com/other/other_privacyProtocols?encoded=7e730d5b41f7436da8b1b4a65a5aa49f
        if let url = URL(string: "\(DConfigure.fetchDomain())other/other_privacyProtocols?encoded=\(DConfigure.fetchAppKey())") {
            //            Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
            if UIApplication.shared.canOpenURL(url) {
                
                let queue = DispatchQueue(label: Bundle.main.bundleIdentifier ?? "com.ssht.wl")
                
                queue.async {
                    
                    do {
                        
                        output.contented.accept(try String(contentsOf: url))
                        
                    } catch  {
                        
                        debugPrint(error)
                    }
                }
            }
        }
        
        self.output = output
    }
}
