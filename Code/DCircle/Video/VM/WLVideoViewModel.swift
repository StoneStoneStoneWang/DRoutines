//
//  WLVideoViewModel.swift
//  DCircleDemo
//
//  Created by three stone 王 on 2019/8/13.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLReqKit
import DPrepare
import WLBaseResult

struct WLVideoViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput { }
    
    struct WLOutput { }
    
    init(_ input: WLInput) {
        
        self.input = input
        
        self.output = WLOutput()
    }
    
    static func addComment(_ encoded: String,content: String) -> Driver<WLBaseResult> {
        
        return onUserDictResp(WLUserApi.addComment(encoded, content: content, tablename: "CircleFriends", type: "0"))
            .mapObject(type: WLCommentBean.self)
            .map({ WLBaseResult.operation($0) })
            .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
    }
    static func addBlack(_ OUsEncoded: String,targetEncoded: String ,content: String) -> Driver<WLBaseResult> {
        
        return onUserVoidResp(WLUserApi.addBlack(OUsEncoded, targetEncoded: targetEncoded, content: content))
            .map({ _ in WLBaseResult.ok("添加黑名单成功")})
            .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
    }
    
    static func focus(_ uid: String ,encode: String) -> Driver<WLBaseResult> {
        
        return onUserVoidResp(WLUserApi.focus(uid, targetEncoded: encode))
            .flatMapLatest({ return Driver.just(WLBaseResult.ok("关注或取消关注成功")) })
            .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
    }
}
