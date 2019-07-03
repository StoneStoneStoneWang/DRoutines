//
//  WLUMUtil+Login.m
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/6/6.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLUMUtil+Login.h"
#import <UMShare/UMShare.h>
@implementation WLUMUtil (Login)

- (void)getAuthWithUserInfoFromQQ:(WLLoginSucc)succ andFail:(WLLoginFail)fail {
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:(UMSocialPlatformType_QQ) currentViewController:nil completion:^(id result, NSError *error) {
        
        if (error) {
            
            fail();
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            succ(resp.openid,resp.name,resp.iconurl,resp.gender);
            
        }
    }];
}

- (void)getAuthWithUserInfoFromWechat:(WLLoginSucc)succ andFail:(WLLoginFail)fail
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
            fail();
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            succ(resp.openid,resp.name,resp.iconurl,resp.gender);
            
        }
    }];
}

@end
