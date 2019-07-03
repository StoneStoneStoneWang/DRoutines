//
//  WLJShareUtil.h
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/6/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

typedef void (^WLJShareSocialRequestCompletionHandler)(NSInteger state,id _Nullable result,NSError *_Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface WLJShareUtil : NSObject

+ (BOOL)handle:(NSURL *)url options:(NSDictionary*)options ;

+ (void)setupWithConfig:(NSString *)appKey andWechatKey:(NSString *)weChatAppId andWechatSecret:(NSString *)wechatSecret;

+ (void)shareWithMessageObject:(id)messageObject
                    completion:(WLJShareSocialRequestCompletionHandler )completion;

+ (id)getShareObj:(NSString *)url andTitle:(NSString *)title andDesc:(NSString *)desc andThumbImg:(UIImage *)img andAppName:(NSString *)appname andPlat:(NSInteger )plat;

@end

NS_ASSUME_NONNULL_END
