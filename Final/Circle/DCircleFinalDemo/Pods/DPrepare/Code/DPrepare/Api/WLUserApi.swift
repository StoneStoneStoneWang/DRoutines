//
//  WLUserApi.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/14.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

public enum WLUserApi {
    
    case login(_ phone: String,password: String)
    
    case smsCode(_ phone: String)
    
    case swiftLogin(_ phone: String,code: String)
    
    case reg(_ phone: String,password: String ,code: String)
    
    case feedback(_ email: String,content: String)
    
    case fetchProfile
    
    case updateUserInfo(_ key: String,value: String)
    
    case smsPassword(_ phone: String)
    
    case resettingPassword(_ phone: String,password: String ,code: String)
    
    case modifyPassword(_ oldPassword: String,password: String)
    
    case aliToken
    
    case fetchBlackList
    
    case removeBlack(_ encode: String)
    
    case focus(_ OUsEncoded: String,targetEncoded: String)
    
    case fetchMyFocus(_ page: Int)
    
    case publish(_ tag: String,content: String)
    
    case fetchList(_ tag: String,page: Int)
    
    case fetchMyList(_ tag: String,page: Int)
    
    case fetchComments(_ page: Int,targetEncoded: String)
    
    case addComment(_ targetEncoded: String,content: String,tablename: String,type: String)
    
    case like(_ targetEncoded: String)
    
    case report(_ OUsEncoded: String,targetEncoded: String ,type: String ,content: String)
    
    case addBlack(_ OUsEncoded: String,targetEncoded: String,content: String)
    
    case fetchPublish(_ tag: String ,page: Int ,userId: String)
    
    case attention(_ OUsEncoded: String,targetEncoded: String)
}

// 可以使用
//onUserDictResp(WLUserApi.login("手机号", password: "密码"))
//.mapObject(type: WLUserBean.self)
//    .subscribe(onNext: { (user) in
//
//
//    }, onError: { (error) in
//
//
//    }).disposed(by: disposed)