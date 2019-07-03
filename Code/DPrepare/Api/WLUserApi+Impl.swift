//
//  WLApiImpl.swift
//  SPrepare
//
//  Created by three stone 王 on 2019/6/24.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLReqKit
import Alamofire
import WLToolsKit

extension WLUserApi: WLObserverReq {
    public var reqName: String {
        
        switch self {
            
        case .login: return "other/login_mobLoginPhone?"
            
        case .swiftLogin: return "other/login_mobQuickLogin?"
            
        case .smsCode: return "mob/sms_mobSendQuickLoginCode?"
            
        case .reg: return "mob/users_mobPhoneAddUsers?"
            
        case .feedback: return "mob/feedback_mobFeedbackAdd?"
            
        case .fetchProfile: return "mob/users_mobUsersInfo?"
            
        case .updateUserInfo: return "mob/users_mobUsersUpdate?"
            
        case .smsPassword: return "mob/sms_mobSendForgetPwdCode?"
            
        case .resettingPassword: return "mob/users_mobForgetPassword?"
            
        case .modifyPassword: return "mob/users_mobUpdatePassword?"
            
        case .aliToken: return "other/oss_stsAssumeRole?"
            
        case .fetchBlackList: return "mob/blacklist_mobListBlacklist?"
            
        case .removeBlack: return "mob/blacklist_mobDelBlacklist"
            
        case .focus: return "mob/attention_mobSucrAttention?"
            
        case .fetchMyFocus: return "mob/attention_mobListAttention?"
            
        case .publish: return "mob/circleFriends_mobAddCircleFriends?"
            
        case .fetchList: return "mob/circleFriends_mobListCircleFriends?"
            
        case .fetchMyList: return "mob/circleFriends_mobUserCircleFriends?"
            
        case .fetchComments: return "mob/comment_mobListComment?"
            
        case .addComment: return "mob/comment_mobAddComment?"
            
        case .like: return "mob/laud_mobAddLaud?"
            
        case .report: return "mob/report_mobReportAdd?"
            
        case .addBlack: return "mob/blacklist_mobAddBlacklist?"
            
        case .fetchPublish: return "mob/circleFriends_mobUserCircleFriends?"
            
        case .attention: return "mob/attention_mobSucrAttention?"
            
        }
    }
    
    public var params: Dictionary<String, Any> {
        
        switch self {
        case let .login(phone, password: password): return ["phone": phone,"password": password,"platform": "1" ,"deviceId": DeviceId]
            
        case let .smsCode(phone): return ["phone": phone,"signName":DGlobalManager.default.signname,"templateCode":DGlobalManager.default.smsCode]
            
        case let .swiftLogin(phone, code): return ["phone":phone,"code":code,"platform":"1"]
            
        case let .reg(phone, password: password, code: code): return ["phone": phone,"password": password,"platform": "1","code": code,"openid": ""]
            
        case let .feedback(email, content: content): return ["fb.email": email,"fb.content": content]
            
        case .fetchProfile: return ["platform": "1"]
            
        case let .updateUserInfo(key, value: value): return [key: value]
            
        case let .smsPassword(phone): return ["phone": phone,"signName":DGlobalManager.default.signname,"templateCode":DGlobalManager.default.pwdCode]
            
        case let .resettingPassword(phone, password: password, code: code): return ["phone": phone,"password": password,"platform": "1","code": code]
            
        case let .modifyPassword(oldPassword, password: password): return ["oldPassword": oldPassword,"password": password]
            
        case .fetchBlackList: return ["projectId":DGlobalManager.default.appkey]
        case .aliToken: return [:]
            
        case let .removeBlack(encoded): return ["projectId":DGlobalManager.default.appkey,"bt.encoded": encoded]
            
        case let .focus(OUsEncoded, targetEncoded: targetEncoded): return ["atn.OUsEncoded":OUsEncoded,"atn.targetEncoded":targetEncoded,"projectId": DGlobalManager.default.appkey,"atn.tableName":"Users"]
        case let .fetchMyFocus(page): return ["page":page,"projectId": DGlobalManager.default.appkey]
            
        case let .publish(tag,content: content): return ["cfs.tag":tag,"cfs.projectId":DGlobalManager.default.appkey,"cfs.content":content]
            
        case let .fetchList(tag, page: page): return ["cfs.tag":tag,"cfs.projectId":DGlobalManager.default.appkey,"page":page]
            
        case let .fetchMyList(tag, page: page): return ["cfs.tag":tag,"cfs.projectId":DGlobalManager.default.appkey,"page":page]
            
        case let .fetchComments(page, targetEncoded: targetEncoded):
            
            return ["comment.targetEncoded":targetEncoded,"page":page,"limit": 20,"projectId": DGlobalManager.default.appkey]
            
        case let .addComment(targetEncoded, content: content, tablename: tablename, type: type):
            
            return ["comment.targetEncoded":targetEncoded,"comment.content":content,"comment.tableName": tablename,"comment.type": type,"projectId": DGlobalManager.default.appkey]
            
        case let .like(targetEncoded): return ["targetEncoded":targetEncoded]
            
        case let .report(OUsEncoded, targetEncoded: targetEncoded, type: type, content: content):
            
            return ["rt.OUsEncoded":OUsEncoded,"rt.targetEncoded":targetEncoded,"rt.type": type,"rt.content": content,"rt.projectId": DGlobalManager.default.appkey,"rt.tableName": "CircleFriends"]
        case let .addBlack(OUsEncoded, targetEncoded: targetEncoded, content: content):
            
            return ["bt.OUsEncoded":OUsEncoded,"bt.targetEncoded":targetEncoded,"bt.content": content,"projectId": DGlobalManager.default.appkey,"bt.tableName": "CircleFriends"]
            
        case let .attention(OUsEncoded, targetEncoded: targetEncoded): return ["atn.OUsEncoded":OUsEncoded,"atn.targetEncoded":targetEncoded,"projectId": DGlobalManager.default.appkey,"atn.tableName":"Users"]
            
        case let .fetchPublish(tag, page: page, userId: userId): return ["cfs.projectId":DGlobalManager.default.appkey,"cfs.tag": tag,"page": page,"userId": userId]
            
        }
    }
    
    public var headers: Dictionary<String, String> {
        
        switch self {
            
        default: return [:]
            
        }
    }
    
    public var method: HTTPMethod {
        switch self {
            
        default: return .post
            
        }
    }
    
    public var host: String {
        
        switch self {
            
        default: return DGlobalManager.default.host
            
        }
    }
}
