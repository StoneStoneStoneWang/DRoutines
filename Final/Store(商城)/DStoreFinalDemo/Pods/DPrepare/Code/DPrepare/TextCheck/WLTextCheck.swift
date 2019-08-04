//
//  WLTextCheck.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit
import WLBaseResult

public func checkPhoneResult(_ mobile: String ) -> WLBaseResult {
    
    if mobile.isEmpty || mobile.wl_isEmpty {
        
        return WLBaseResult.failed("手机号不能为空")
    }
    if !String.validPhone(phone: mobile) {
        
        return WLBaseResult.failed( "请输入正确手机号")
    }
    return WLBaseResult.ok("")
}

public func smsResult(count: Int) -> (Bool ,String) {
    
    if count <= 0 { return  (true ,"获取验证码") }
        
    else { return (false ,"(\(count)s)")}
}

public func swiftLoginCheckResult(_ mobile: String ,vcode: String) -> WLBaseResult {
    
    if mobile.isEmpty || mobile.wl_isEmpty {
        
        return WLBaseResult.failed("手机号不能为空")
    }
    if !String.validPhone(phone: mobile) {
        
        return WLBaseResult.failed( "请输入正确手机号")
    }
    
    if vcode.isEmpty || vcode.wl_isEmpty {
        
        return WLBaseResult.failed( "请输入6位验证码")
    }
    
    if vcode.length < 6 {
        
        return WLBaseResult.failed( "请输入6位验证码")
    }
    
    return WLBaseResult.ok( "")
}

public func pwdCheckResult(_ mobile: String ,vcode: String ,password: String) -> WLBaseResult {
    
    if mobile.isEmpty || mobile.wl_isEmpty {
        
        return WLBaseResult.failed("手机号不能为空")
    }
    if !String.validPhone(phone: mobile) {
        
        return WLBaseResult.failed( "请输入正确手机号")
    }
    
    if vcode.isEmpty || vcode.wl_isEmpty {
        
        return WLBaseResult.failed( "请输入6位验证码")
    }
    
    if vcode.length < 6 {
        
        return WLBaseResult.failed( "请输入6位验证码")
    }
    
    if password.isEmpty || password.wl_isEmpty {
        
        return WLBaseResult.failed( "请输入6-18位密码")
    }
    
    if password.length < 6 {
        
        return WLBaseResult.failed( "请输入6-18位密码")
    }
    
    return WLBaseResult.ok( "")
}
