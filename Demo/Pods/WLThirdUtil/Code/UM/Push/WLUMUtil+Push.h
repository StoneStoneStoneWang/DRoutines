//
//  WLUMUtil+Push.h
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/4/3.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLUMUtil.h"
#import <UserNotifications/UserNotifications.h>
NS_ASSUME_NONNULL_BEGIN

@interface WLUMUtil (Push) <UNUserNotificationCenterDelegate>

- (void)registerForRemoteNotificationsWithLaunchOptions:(NSDictionary * __nullable)launchOptions andCompletionHandler:(void (^ __nullable)(BOOL granted, NSError *_Nullable error))completionHandler;

- (void)setAutoAlert:(BOOL )autoAlert;

- (void)setBadgeClear:(BOOL )badgeClear;

- (void)registerDeviceToken:(NSData *__nullable)deviceToken;

- (void)didReceiveRemoteNotification:( NSDictionary * __nullable)userInfo;

#pragma mark ---- UNUserNotificationCenterDelegate
- (void)setPushDelegate;

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler;

-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler;

#pragma mark --- addTags
- (void)addTags:(__nonnull id)tag response:( void (^ __nonnull)(id __nullable responseObject ,NSInteger remain,NSError * __nullable error))handle;
@end

NS_ASSUME_NONNULL_END
