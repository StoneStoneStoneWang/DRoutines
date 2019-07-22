//
//  WLUMUtil+Share.m
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/4/3.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLUMUtil+Share.h"
#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>

@implementation WLUMUtil (Share)

- (void)setUsingHttpsWhenShareContent:(BOOL)isUsingHttp {
    
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = isUsingHttp;
}
- (void)configWechat:(NSString *)appkey andSecret:(NSString *)secret andRedirectURL:(NSString *)redirectURL {
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:appkey appSecret:secret redirectURL:redirectURL];
}

- (void)configQQ:(NSString *)appkey andSecret:(NSString *)secret andRedirectURL:(NSString *)redirectURL {
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:appkey appSecret:secret redirectURL:redirectURL];
}

- (BOOL)handle:(NSURL *)url forSourceApplication:(NSString *)sourceApplication andAnnotation:(id)annotation{
    
    return [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (BOOL)handle:(NSURL *)url options:(NSDictionary *)options {
    
    return [[UMSocialManager defaultManager] handleOpenURL:url options:options];
}

- (void)setPreDefinePlatforms:(NSArray *)plats {
    
    [UMSocialUIManager setPreDefinePlatforms:plats];
}

- (void)addCustomPlatformWithoutFilted:(NSInteger)platformType withPlatformIcon:(UIImage *)platformIcon withPlatformName:(NSString *)platformName {
    
    [UMSocialUIManager addCustomPlatformWithoutFilted:platformType withPlatformIcon:platformIcon withPlatformName:platformName];
}

- (void)openShareMenu:(WLSocialOpenMenuCompletionHandler)completion {
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        completion(platformType);
        
    }];
}

- (void)shareToPlatform:(NSInteger)platformType messageObject:(id)messageObject currentViewController:(id)currentViewController completion:(WLSocialRequestCompletionHandler __nullable)completion {
    
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:currentViewController completion:^(id result, NSError *error) {
        
        completion(result,error);
    }];
}

- (id)getShareObj:(NSString *)url andTitle:(NSString *)title andDesc:(NSString *)desc andThumbImg:(UIImage *)img{
    
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:desc thumImage:img];
    //设置网页地址
    shareObject.webpageUrl = url;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    return messageObject;
}

@end

