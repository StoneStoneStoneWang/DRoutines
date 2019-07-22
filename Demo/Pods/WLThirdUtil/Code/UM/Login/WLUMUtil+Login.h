//
//  WLUMUtil+Login.h
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/6/6.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLUMUtil.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^WLLoginSucc)(NSString *openid ,NSString *name,NSString *icon,NSString *gender);

typedef void (^WLLoginFail)(void);

@interface WLUMUtil (Login)

- (void)getAuthWithUserInfoFromQQ:(WLLoginSucc)succ andFail:(WLLoginFail)fail;

- (void)getAuthWithUserInfoFromWechat:(WLLoginSucc)succ andFail:(WLLoginFail)fail;

@end

NS_ASSUME_NONNULL_END
