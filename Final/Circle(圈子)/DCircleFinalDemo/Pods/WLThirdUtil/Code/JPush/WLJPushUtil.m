//
//  WLJPushUtil.m
//  WLJPushDemo
//
//  Created by three stone 王 on 2019/4/2.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLJPushUtil.h"
#import "JPUSHService.h"
#import <UIKit/UIKit.h>
// 如果需要使用 idfa 功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
@interface WLJPushUtil()<JPUSHRegisterDelegate>

@end
@implementation WLJPushUtil

+ (instancetype)shared {
    static WLJPushUtil *manager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{  manager = [WLJPushUtil new]; });
    
    return manager;
}

- (void)jp_setupWithOption:(NSDictionary *)launchingOption appKey:(NSString *)appKey channel:(NSString *)channel {
#if TARGET_IPHONE_SIMULATOR  //模拟器
    
    
    
#elif TARGET_OS_IPHONE      //真机
    
    [JPUSHService setupWithOption:launchingOption
                           appKey:appKey
                          channel:channel
#ifdef DEBUG
                 apsForProduction:false];
#else
apsForProduction:true];
#endif
    
#endif
    
    
}
- (void)jp_setupWithOption:(NSDictionary *)launchingOption appKey:(NSString *)appKey channel:(NSString *)channel advertisingIdentifier:(NSString *)advertisingId {
#if TARGET_IPHONE_SIMULATOR  //模拟器
    
    
    
#elif TARGET_OS_IPHONE      //真机
    
    [JPUSHService setupWithOption:launchingOption
                           appKey:appKey
                          channel:channel
#ifdef DEBUG
                 apsForProduction:false
#else
                 apsForProduction:true
#endif
            advertisingIdentifier:advertisingId];
    
#endif
    
}
- (void)jp_registerForRemoteNotificationConfig {
    
#if TARGET_IPHONE_SIMULATOR  //模拟器
    
    
#elif TARGET_OS_IPHONE
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
#endif
    
}
- (void)jp_registerDeviceToken:(NSData *)deviceToken {
#if TARGET_IPHONE_SIMULATOR  //模拟器
    
#elif TARGET_OS_IPHONE
    
    [JPUSHService registerDeviceToken:deviceToken];
    
#endif
    
}
#pragma mark --- 推送

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
#if TARGET_IPHONE_SIMULATOR  //模拟器
    
    
#elif TARGET_OS_IPHONE
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:WLDidReceivePush object:nil userInfo: userInfo];
    // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound);
#endif
    
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    
#if TARGET_IPHONE_SIMULATOR  //模拟器
    
    
#elif TARGET_OS_IPHONE
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:WLDidHandlePush object:nil userInfo: userInfo];
    
    completionHandler();  // 系统要求执行这个方法
#endif
    
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(nullable UNNotification *)notification {
#if TARGET_IPHONE_SIMULATOR  //模拟器
    
    
#elif TARGET_OS_IPHONE
    
    if ([[[[[UIDevice currentDevice] systemVersion] substringToIndex:1] stringByAppendingString:@"0"] intValue] >= 12) {
        
        if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            //从通知界面直接进入应用
        }else{
            //从通知设置界面进入应用
        }
    }
#endif
    
}

@end

@implementation WLJPushUtil(WLNoti)

NSNotificationName const WLDidReceivePush = @"WLDidReceivePush";

NSNotificationName const WLDidHandlePush = @"WLDidHandlePush";

@end
@implementation WLJPushUtil(WLTag)

- (void)jp_addTag:(NSSet<NSString *> *)tags completion:(nonnull void (^)(NSInteger, NSSet * _Nonnull, NSInteger))completion seq:(NSInteger)seq{
#if TARGET_IPHONE_SIMULATOR  //模拟器
    
    
#elif TARGET_OS_IPHONE
    
    [JPUSHService addTags:tags completion:completion seq:seq];
#endif
    
}
- (void)jp_deleteTags:(NSSet<NSString *> *)tags completion:(void (^)(NSInteger, NSSet * _Nonnull, NSInteger))completion seq:(NSInteger)seq  {
#if TARGET_IPHONE_SIMULATOR  //模拟器
    
    
#elif TARGET_OS_IPHONE
    
    [JPUSHService deleteTags:tags completion:completion seq:seq];
#endif
    
}
- (void)jp_cleanTags:(void (^)(NSInteger, NSSet * _Nonnull, NSInteger))completion seq:(NSInteger)seq {
#if TARGET_IPHONE_SIMULATOR  //模拟器
    
    
#elif TARGET_OS_IPHONE
    
    [JPUSHService cleanTags:completion seq:seq];
#endif
    
}
- (void)jp_getAllTags:(void (^)(NSInteger, NSSet * _Nonnull, NSInteger))completion seq:(NSInteger)seq {
#if TARGET_IPHONE_SIMULATOR  //模拟器
    
    
#elif TARGET_OS_IPHONE
    
    [JPUSHService getAllTags:completion seq:seq];
#endif
    
}
@end

@implementation WLJPushUtil(WLAlias)

- (void)jp_setAlias:(NSString *)alias
         completion:(void (^)(NSInteger iResCode, NSString *iAlias, NSInteger seq))completion
                seq:(NSInteger)seq {
#if TARGET_IPHONE_SIMULATOR  //模拟器
    
    
#elif TARGET_OS_IPHONE
    
    [JPUSHService setAlias:alias completion:completion seq:seq];
#endif
    
}

- (void)jp_deleteAlias:(void (^)(NSInteger iResCode, NSString *iAlias, NSInteger seq))completion
                   seq:(NSInteger)seq {
#if TARGET_IPHONE_SIMULATOR  //模拟器
    
    
#elif TARGET_OS_IPHONE
    
    [JPUSHService deleteAlias:completion seq:seq];
#endif
    
}

- (void)jp_getAlias:(void (^)(NSInteger iResCode, NSString *iAlias, NSInteger seq))completion
                seq:(NSInteger)seq {
    
#if TARGET_IPHONE_SIMULATOR  //模拟器
    
    
#elif TARGET_OS_IPHONE
    
    [JPUSHService getAlias:completion seq:seq];
#endif
    
}

@end
