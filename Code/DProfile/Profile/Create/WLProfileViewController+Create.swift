//
//  WLProfileViewController+Create.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DPerson
import DLogin
import DReq


extension WLProfileBaseViewController {
    

    @objc (createProfileWithProfileStyle:andProfileConfig:andLoginConfig:andAboutConfig:)
    public static func createProfile(_ profileStyle: WLProfileStyle,profileConfig: WLProfileConfig,loginStyle: WLLoginStyle,loginConfig: WLLoginConfig ) -> WLProfileBaseViewController {
        
        var result: WLProfileBaseViewController!
        
        switch profileStyle {
        case .one:
            
            let profile = WLProfileViewController(profileStyle, profileConfig: profileConfig, loginStyle: loginStyle, loginConfig: loginConfig)
    
            result = profile
            
        case .two:
            
            let profile = WLProfile2ViewController(profileStyle, profileConfig: profileConfig, loginStyle: loginStyle, loginConfig: loginConfig)
            
            result = profile
            
        case .three:
            
            let profile = WLProfile3ViewController(profileStyle, profileConfig: profileConfig, loginStyle: loginStyle, loginConfig: loginConfig)
            
            result = profile
            
        case .four:

            let profile = WLProfile4ViewController(profileStyle, profileConfig: profileConfig, loginStyle: loginStyle, loginConfig: loginConfig)

            result = profile
            
        default:
            
            let profile = WLProfileViewController(profileStyle, profileConfig: profileConfig, loginStyle: loginStyle, loginConfig: loginConfig)
            
            result = profile
        }
        
        NotificationCenter.default.addObserver(result as Any, selector: #selector(WLProfileBaseViewController.tokenInvalid), name: NSNotification.Name.DTokenInvalid, object: nil)
        
        return result
    }
}
