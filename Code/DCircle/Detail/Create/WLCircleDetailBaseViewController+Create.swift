//
//  WLCircleDetailBaseViewController+Create.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DPrepare
import DLogin

extension WLCircleDetailBaseViewController {
    @objc (createCircleDetailWithStyle:andContentStyle:andContentConfig:andCommentStyle:andCommentConfig:andLoginStyle:andLoginConfig:andUid:andEncoded:andCircleJson:andDelegate:)
    public static func createCircleDetail(_ style: WLCircleDetailStyle,contentStyle: WLContentStyle ,contentConfig: WLContentConfig,commentStyle: WLCommentStyle ,commentConfig: WLCommentConfig ,loginStyle: WLLoginStyle,loginConfig: WLLoginConfig,uid: String,encoded: String,circleJson: [String : Any] ,delegate: WLCircleDetailDelegate) -> WLCircleDetailBaseViewController {
        
        switch style {
        case .one: return WLCricleDetail1ViewController(contentStyle, contentConfig: contentConfig, commentStyle: commentStyle, commentConfig: commentConfig,loginStyle: loginStyle,loginConfig: loginConfig,uid: uid, encoded: encoded, circleJson: circleJson ,delegate: delegate)
            
        default: return WLCricleDetail1ViewController(contentStyle, contentConfig: contentConfig, commentStyle: commentStyle, commentConfig: commentConfig,loginStyle: loginStyle,loginConfig: loginConfig,uid: uid, encoded: encoded, circleJson: circleJson ,delegate: delegate)
            
        }
    }
}
