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
    
    @objc (createProfileWithProfileStyle:andProfileConfig:andUserInfoConfig: andBlackStyle:andBlackConfig:andLoginStyle:andLoginConfig:andAboutConfig:andFocusStyle: andFocusConfig:andDelegate:)
    public static func createProfile(_ profileStyle: WLProfileStyle,profileConfig: WLProfileConfig,userInfoConfig: WLUserInfoConfig,blackStyle: WLBlackListStyle ,blackConfig: WLBlackListConfig ,loginStyle: WLLoginStyle,loginConfig: WLLoginConfig ,aboutConfig: WLAboutConfig ,focusStyle: WLFocusListStyle,focusConfig: WLFocusListConfig ,delegate: WLProfileViewControllerDelegate?) -> WLProfileBaseViewController {
        
        var result: WLProfileBaseViewController!
        
        switch profileStyle {
        case .one:
            
            let profile = WLProfileViewController(profileStyle, profileConfig: profileConfig, userInfoConfig: userInfoConfig, blackStyle: blackStyle, blackConfig: blackConfig, loginStyle: loginStyle, loginConfig: loginConfig, aboutConfig: aboutConfig ,focusStyle: focusStyle,focusConfig: focusConfig,delegate: delegate)
            
            result = profile
            
        case .two:
            
            let profile = WLProfile2ViewController(profileStyle, profileConfig: profileConfig, userInfoConfig: userInfoConfig, blackStyle: blackStyle, blackConfig: blackConfig, loginStyle: loginStyle, loginConfig: loginConfig, aboutConfig: aboutConfig ,focusStyle: focusStyle,focusConfig: focusConfig,delegate: delegate)
            
            result = profile
            
        case .three:
            
            let profile = WLProfile3ViewController(profileStyle, profileConfig: profileConfig, userInfoConfig: userInfoConfig, blackStyle: blackStyle, blackConfig: blackConfig, loginStyle: loginStyle, loginConfig: loginConfig, aboutConfig: aboutConfig ,focusStyle: focusStyle,focusConfig: focusConfig,delegate: delegate)
            
            result = profile
            
        case .four:
            
            let profile = WLProfile4ViewController(profileStyle, profileConfig: profileConfig, userInfoConfig: userInfoConfig, blackStyle: blackStyle, blackConfig: blackConfig, loginStyle: loginStyle, loginConfig: loginConfig, aboutConfig: aboutConfig ,focusStyle: focusStyle,focusConfig: focusConfig,delegate: delegate)
            
            result = profile
            
        default:
            
            let profile = WLProfileViewController(profileStyle, profileConfig: profileConfig, userInfoConfig: userInfoConfig, blackStyle: blackStyle, blackConfig: blackConfig, loginStyle: loginStyle, loginConfig: loginConfig, aboutConfig: aboutConfig ,focusStyle: focusStyle,focusConfig: focusConfig,delegate: delegate)
            
            result = profile
        }
        
        NotificationCenter.default.addObserver(result as Any, selector: #selector(WLProfileBaseViewController.tokenInvalid), name: NSNotification.Name(rawValue: "tokenInvalid"), object: nil)
        
        return result
    }
    @objc (createProfileWithProfileStyle:andProfileConfig:andUserInfoConfig: andBlackStyle:andBlackConfig:andLoginStyle:andLoginConfig:andAboutConfig:andFocusStyle: andFocusConfig:andDelegate:andCDelegate:)
    public static func createProfile(_ profileStyle: WLProfileStyle,profileConfig: WLProfileConfig,userInfoConfig: WLUserInfoConfig,blackStyle: WLBlackListStyle ,blackConfig: WLBlackListConfig ,loginStyle: WLLoginStyle,loginConfig: WLLoginConfig ,aboutConfig: WLAboutConfig ,focusStyle: WLFocusListStyle,focusConfig: WLFocusListConfig ,delegate: WLProfileViewControllerDelegate? ,cDelegate: WLProfileViewControllerMyPubDelegate) -> WLProfileBaseViewController {
        
        var result: WLProfileBaseViewController!
        
        switch profileStyle {
        case .one:
            
            let profile = WLProfileViewController(profileStyle, profileConfig: profileConfig, userInfoConfig: userInfoConfig, blackStyle: blackStyle, blackConfig: blackConfig, loginStyle: loginStyle, loginConfig: loginConfig, aboutConfig: aboutConfig ,focusStyle: focusStyle,focusConfig: focusConfig,delegate: delegate ,cDelegate: cDelegate)
            
            result = profile
            
        case .two:
            
            let profile = WLProfile2ViewController(profileStyle, profileConfig: profileConfig, userInfoConfig: userInfoConfig, blackStyle: blackStyle, blackConfig: blackConfig, loginStyle: loginStyle, loginConfig: loginConfig, aboutConfig: aboutConfig ,focusStyle: focusStyle,focusConfig: focusConfig,delegate: delegate,cDelegate: cDelegate)
            
            result = profile
            
        case .three:
            
            let profile = WLProfile3ViewController(profileStyle, profileConfig: profileConfig, userInfoConfig: userInfoConfig, blackStyle: blackStyle, blackConfig: blackConfig, loginStyle: loginStyle, loginConfig: loginConfig, aboutConfig: aboutConfig ,focusStyle: focusStyle,focusConfig: focusConfig,delegate: delegate,cDelegate: cDelegate)
            
            result = profile
            
        case .four:

            let profile = WLProfile4ViewController(profileStyle, profileConfig: profileConfig, userInfoConfig: userInfoConfig, blackStyle: blackStyle, blackConfig: blackConfig, loginStyle: loginStyle, loginConfig: loginConfig, aboutConfig: aboutConfig ,focusStyle: focusStyle,focusConfig: focusConfig,delegate: delegate,cDelegate: cDelegate)

            result = profile
            
        default:
            
            let profile = WLProfileViewController(profileStyle, profileConfig: profileConfig, userInfoConfig: userInfoConfig, blackStyle: blackStyle, blackConfig: blackConfig, loginStyle: loginStyle, loginConfig: loginConfig, aboutConfig: aboutConfig ,focusStyle: focusStyle,focusConfig: focusConfig,delegate: delegate,cDelegate: cDelegate)
            
            result = profile
        }
        
        NotificationCenter.default.addObserver(result as Any, selector: #selector(WLProfileBaseViewController.tokenInvalid), name: NSNotification.Name.DTokenInvalid, object: nil)
        
        return result
    }
}
