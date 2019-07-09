//
//  WLCommentBaseViewController+Create.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

extension WLCommentBaseViewController {
    
    @objc (createCommentWithStyle:andConfig:andUid:andEncoded:andDelegate:)
    public static func createComment(_ style: WLCommentStyle ,config: WLCommentConfig ,uid: String,encoded: String ,delegate: WLCommentDelegate) -> WLCommentBaseViewController {
        
        switch style {
        case .one: return WLComment1ViewController(style, config: config ,uid: uid, encoded: encoded ,delegate: delegate)
            
        default: return WLComment1ViewController(style, config: config,uid: uid, encoded: encoded ,delegate: delegate)
            
        }
    }
}
