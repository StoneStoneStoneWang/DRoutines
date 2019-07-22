//
//  WLUMUtil+Share.h
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/4/3.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLUMUtil.h"
@import UIKit;


NS_ASSUME_NONNULL_BEGIN
typedef void (^WLSocialRequestCompletionHandler)(id result,NSError *_Nullable error);

typedef void (^WLSocialOpenMenuCompletionHandler)(NSInteger platform);

typedef void(^UMSuccBlock)(void);

typedef void(^UMFailBlock)(void);

@interface WLUMUtil (Share)

- (void)setUsingHttpsWhenShareContent:(BOOL) isUsingHttp;

- (void)configWechat:(NSString *)appkey andSecret:(NSString *)secret andRedirectURL:(NSString *)redirectURL;

- (void)configQQ:(NSString *)appkey andSecret:(NSString *)secret andRedirectURL:(NSString *)redirectURL;

- (BOOL)handle:(NSURL *)url forSourceApplication:(NSString *)sourceApplication andAnnotation:(id)annotation;

- (BOOL)handle:(NSURL *)url options:(NSDictionary*)options ;

/*
 
 UMSocialPlatformType_QQ                 = 4
 
 UMSocialPlatformType_WechatSession = 1
 
 UMSocialPlatformType_WechatTimeLine = 2
 */

- (void)setPreDefinePlatforms:(NSArray *)plats;

- (void)addCustomPlatformWithoutFilted:(NSInteger)platformType
                withPlatformIcon:(UIImage*)platformIcon
                withPlatformName:(NSString*)platformName;

- (void)openShareMenu:(WLSocialOpenMenuCompletionHandler)completion;

- (void)shareToPlatform:(NSInteger)platformType
          messageObject:(id __nullable)messageObject
  currentViewController:(id __nullable)currentViewController
             completion:(WLSocialRequestCompletionHandler __nullable)completion;

- (id)getShareObj:(NSString *)url andTitle:(NSString *)title andDesc:(NSString *)desc andThumbImg:(UIImage *)img;


@end

NS_ASSUME_NONNULL_END
