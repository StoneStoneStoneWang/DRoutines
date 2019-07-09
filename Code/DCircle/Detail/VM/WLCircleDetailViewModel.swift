//
//  WLCircleDetailViewModel.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxSwift
import WLBaseViewModel
import RxCocoa

struct WLCircleDetailViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        /* 验证码 序列*/
        let content:Driver<String>
        /* 登录按钮点击 序列*/
        let coverTaps:Signal<Void>
        
        let moreTaps:Signal<Void>
    }
    
    struct WLOutput {
        
        //        /* 登录中 序列*/
        //        let logining: Driver<Void>
        //        /* 登录结果  本地判断手机号是否合法、验证码是否合法 之后我再进行网络请求 序列*/
        //        let logined: Driver<WLBaseResult>
        //        /* 获取验证码中 序列*/
        //        let verifying: Driver<Void>
        /* 获取验证码结果 序列*/
        let covered: Driver<Void>
        
        let mored: Driver<Void>
    }
    init(_ input: WLInput) {
        
        self.input = input
        
        let covered = input.coverTaps.flatMapLatest { Driver.just($0) }
        
        let mored = input.moreTaps.flatMapLatest { Driver.just($0) }
        
        let output = WLOutput(covered: covered, mored: mored)
        
        self.output = output
    }
}
