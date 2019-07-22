//
//  WLUMUtil+Push.m
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/4/3.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLUMUtil+Push.h"
#import <UMPush/UMessage.h>

@implementation WLUMUtil (Push)

- (void)registerForRemoteNotificationsWithLaunchOptions:(NSDictionary *)launchOptions andCompletionHandler:(void (^)(BOOL, NSError * _Nullable))completionHandler {
    
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert|UMessageAuthorizationOptionSound;
    
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity
                                            completionHandler:completionHandler];
}
- (void)setAutoAlert:(BOOL)autoAlert {
    
    [UMessage setAutoAlert:autoAlert];
}
- (void)setBadgeClear:(BOOL)badgeClear {
    
    [UMessage setBadgeClear:badgeClear];
}
- (void)registerDeviceToken:(NSData *)deviceToken {
    
    [UMessage registerDeviceToken:deviceToken];
}

- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [UMessage didReceiveRemoteNotification:userInfo];
}

- (void)setPushDelegate {
    
    [UNUserNotificationCenter currentNotificationCenter].delegate=self;
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage didReceiveRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

// iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage didReceiveRemoteNotification:userInfo];
    }
}

- (void)addTags:(id)tag response:(void (^)(id _Nullable, NSInteger, NSError * _Nullable))handle {
    
    [UMessage addTags:tag response:handle];
}

@end
