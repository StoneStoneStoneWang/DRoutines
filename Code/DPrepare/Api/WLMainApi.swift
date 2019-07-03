//
//  WLMainApi.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/3.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

public enum WLMainApi {
    
    case publish(_ tag: String,content: String)
    
    case fetchList(_ tag: String,page: Int)
    
    case fetchMyList(_ tag: String,page: Int)
    
    case fetchDetail
    
    case fetchComments(_ page: Int,targetEncoded: String)
    
    case addComment(_ targetEncoded: String,content: String,tablename: String,type: String)
    
    case deleteComment(_ encoded: String)
    
    case like(_ targetEncoded: String)
    
    case report(_ OUsEncoded: String,targetEncoded: String ,type: String ,content: String)
    
    case addBlack(_ OUsEncoded: String,targetEncoded: String,content: String)
    
    case fetchPublish(_ tag: String ,page: Int ,userId: String)
    
    case attention(_ OUsEncoded: String,targetEncoded: String)
    
    case fetchMyFocus(_ page: Int)
    
}
