//
//  DConfigure.h
//  DRoutinesKit
//
//  Created by three stone 王 on 2019/7/3.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DRoutinesDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

NS_ASSUME_NONNULL_BEGIN

// 过期提醒


typedef NS_ENUM(NSInteger ,DConfigureType) {
    
    DConfigureTypeCircle NS_SWIFT_NAME(circle),
    
    DConfigureTypeStore NS_SWIFT_NAME(store)
};
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
                smsPwd:(NSString *)smsPwd DRoutinesDeprecated("请使用+ (void)initWithAppKey:(NSString *)appKey domain:(NSString *)domain smsSign:(NSString *)smsSign smsLogin:(NSString *)smsLogin smsPwd:(NSString *)smsPwd pType:(DConfigureType)ptype;");

/** 初始化所有组件产品
 @param appKey 开发者在官网申请的appKey.
 @param domain 请求主地址
 @param smsSign 短信签名
 @param smsLogin 短信注册/登陆码
 @param smsPwd 短信z找回密码码
 @param ptype 类型 1.圈子 2.商城 3.待定 默认1 圈子
 */
+ (void)initWithAppKey:(NSString *)appKey
                domain:(NSString *)domain
               smsSign:(NSString *)smsSign
              smsLogin:(NSString *)smsLogin
                smsPwd:(NSString *)smsPwd
                 pType:(DConfigureType)ptype;


/**
 @result signature
 */
+ (NSString *)fetchSignature;

+ (NSString *)fetchAppKey;

+ (NSString *)fetchDomain;

+ (NSString *)fetchSmsSign;

+ (NSString *)fetchSmsLogin;

+ (NSString *)fetchSmsPwd;

+ (DConfigureType )fetchPType;

@end
NS_ASSUME_NONNULL_END
