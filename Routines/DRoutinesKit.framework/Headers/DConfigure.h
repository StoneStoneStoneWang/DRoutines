//
//  DConfigure.h
//  DRoutinesKit
//
//  Created by three stone 王 on 2019/7/3.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface DConfigure : NSObject

/** 初始化所有组件产品
 @param appKey 开发者在官网申请的appKey.
 @param domain 请求主地址
 @param smsSign 短信签名
 @param smsLogin 短信注册/登陆码
 @param smsPwd 短信z找回密码码
 */
+ (void)initWithAppKey:(NSString *)appKey
                domain:(NSString *)domain
               smsSign:(NSString *)smsSign
              smsLogin:(NSString *)smsLogin
                smsPwd:(NSString *)smsPwd;
/**
 @result signature
 */
+ (NSString *)fetchSignature;

@end
NS_ASSUME_NONNULL_END
