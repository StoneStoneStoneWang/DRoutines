//
//  WLJPushUtil.h
//  WLJPushDemo
//
//  Created by three stone 王 on 2019/4/2.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>
// iOS10 注册 APNs 所需头文件
#import <UserNotifications/UserNotifications.h>
NS_ASSUME_NONNULL_BEGIN

@interface WLJPushUtil : NSObject

@property (nonatomic ,assign) UNNotificationPresentationOptions jp_options;
//
+ (instancetype)shared;

- (void)jp_setupWithOption:(NSDictionary *)launchingOption
                    appKey:(NSString *)appKey
                   channel:(NSString *)channel;

- (void)jp_setupWithOption:(NSDictionary *)launchingOption
                    appKey:(NSString *)appKey
                   channel:(NSString *)channel
     advertisingIdentifier:(NSString *)advertisingId;

- (void)jp_registerForRemoteNotificationConfig;

- (void)jp_registerDeviceToken:(NSData *)deviceToken;

@end

@interface WLJPushUtil(WLNoti)

extern NSNotificationName const WLDidReceivePush;

extern NSNotificationName const WLDidHandlePush;

@end

@interface WLJPushUtil(WLTag)

- (void)jp_addTag:(NSSet<NSString *> *)tags
       completion:(void (^)(NSInteger iResCode, NSSet *iTags, NSInteger seq) )completion
              seq:(NSInteger)seq;

- (void)jp_deleteTags:(NSSet<NSString *> *)tags
           completion:(void (^)(NSInteger iResCode, NSSet *iTags, NSInteger seq) )completion
                  seq:(NSInteger)seq;

- (void)jp_cleanTags:(void (^)(NSInteger iResCode, NSSet *iTags, NSInteger seq))completion
                 seq:(NSInteger)seq;

- (void)jp_getAllTags:(void (^)(NSInteger iResCode, NSSet *iTags, NSInteger seq))completion
                  seq:(NSInteger)seq;
@end
@interface WLJPushUtil(WLAlias)

- (void)jp_setAlias:(NSString *)alias
         completion:(void (^)(NSInteger iResCode, NSString *iAlias, NSInteger seq))completion
                seq:(NSInteger)seq;

- (void)jp_deleteAlias:(void (^)(NSInteger iResCode, NSString *iAlias, NSInteger seq))completion
                   seq:(NSInteger)seq;

- (void)jp_getAlias:(void (^)(NSInteger iResCode, NSString *iAlias, NSInteger seq))completion
                seq:(NSInteger)seq;

@end

NS_ASSUME_NONNULL_END
