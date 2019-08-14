//
//  WLVideoBroadBaseViewController+Create.swift
//  DCircleDemo
//
//  Created by three stone 王 on 2019/8/12.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DLogin

extension WLVideoBroadBaseViewController {
    @objc
    public static func createVideoBroad(_ config: WLCommentConfig ,loginStyle: WLLoginStyle,loginConfig: WLLoginConfig,videoUrl: String,circleJson: [String : Any]) -> WLVideoBroadBaseViewController {
    
        return WLVideoBroadViewController(config, loginStyle: loginStyle, loginConfig: loginConfig, videoUrl: videoUrl, circleJson: circleJson)
    }
}
