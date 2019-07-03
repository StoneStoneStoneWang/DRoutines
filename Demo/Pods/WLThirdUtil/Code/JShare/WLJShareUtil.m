//
//  WLJShareUtil.m
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/6/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLJShareUtil.h"
#import "JSHAREService.h"
#import <AdSupport/AdSupport.h>

@implementation WLJShareUtil

+ (BOOL)handle:(NSURL *)url options:(NSDictionary*)options {
    
    Class cls = NSClassFromString(@"JSHAREService");
    
    if ([cls respondsToSelector:@selector(handleOpenUrl:)] ) {
        
        return [cls performSelector:NSSelectorFromString(@"handleOpenUrl:") withObject:url ];
    }
    
    return false;
}
+ (void)setupWithConfig:(NSString *)appKey andWechatKey:(NSString *)weChatAppId andWechatSecret:(NSString *)wechatSecret {
    
    
    Class cls = NSClassFromString(@"JSHARELaunchConfig");
    
    id config = [[cls alloc]init];
    
    [config performSelector:NSSelectorFromString(@"setAppKey:") withObject:appKey];
    
    [config performSelector:NSSelectorFromString(@"setWeChatAppId:") withObject:weChatAppId];
    
    [config performSelector:NSSelectorFromString(@"setWeChatAppSecret:") withObject:wechatSecret];
    
    Class ser = NSClassFromString(@"JSHAREService");
    
    [ser performSelector:NSSelectorFromString(@"setupWithConfig:") withObject:config];
    
    [ser performSelector:NSSelectorFromString(@"setDebug:") withObject:@(true)];
}
+ (void)shareWithMessageObject:(id)messageObject completion:(WLJShareSocialRequestCompletionHandler )completion {
    
    Class ser = NSClassFromString(@"JSHAREService");
    
    if ([ser respondsToSelector:@selector(share:completionHandler:)]) {
        
        [ser performSelector:NSSelectorFromString(@"share:completionHandler:") withObject:messageObject withObject:completion];
    }
}

+ (id)getShareObj:(NSString *)url andTitle:(NSString *)title andDesc:(NSString *)desc andThumbImg:(UIImage *)img andAppName:(NSString *)appname andPlat:(NSInteger )plat {
    
    Class cls = NSClassFromString(@"JSHAREMessage");
    
    id message = [cls performSelector:NSSelectorFromString(@"message") ];
    
    [message performSelector:NSSelectorFromString(@"setMediaType:") withObject:@(3)];
    
    [message performSelector:NSSelectorFromString(@"setUrl:") withObject:url];
    
    [message performSelector:NSSelectorFromString(@"setText:") withObject:desc];
    
    [message performSelector:NSSelectorFromString(@"setTitle:") withObject:title];
    
    [message performSelector:NSSelectorFromString(@"setPlatform:") withObject:@(plat)];
    
    [message performSelector:NSSelectorFromString(@"setImage:") withObject:UIImagePNGRepresentation(img)];
    
    [message performSelector:NSSelectorFromString(@"setCallbackUrl:") withObject:@"https://www.jiguang.cn/"];
    
    [message performSelector:NSSelectorFromString(@"setAppName:") withObject:appname];
    
    return message;
}

@end
