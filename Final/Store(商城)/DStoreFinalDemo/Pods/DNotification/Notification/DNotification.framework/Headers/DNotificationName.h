//
//  DNotificationName.h
//  DNotification
//
//  Created by three stone 王 on 2019/7/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

@import Foundation;
@import UIKit;
NS_ASSUME_NONNULL_BEGIN

#pragma mark ---- 欢迎界面
FOUNDATION_EXPORT NSString * const DNotificationWelcomeSkip;

#pragma mark ---- 登陆相关

FOUNDATION_EXPORT NSString * const DNotificationLoginSucc;

FOUNDATION_EXPORT NSString * const DNotificationGotoReg;

FOUNDATION_EXPORT NSString * const DNotificationGotoFindPwd;

FOUNDATION_EXPORT NSString * const DNotificationRegSucc;

FOUNDATION_EXPORT NSString * const DNotificationBackLogin;

FOUNDATION_EXPORT NSString * const DNotificationFindPwdSucc;

FOUNDATION_EXPORT NSString * const DNotificationGotoProtocol;

#pragma mark ---- setting

FOUNDATION_EXPORT NSString * const DNotificationGotoModifyPwd;

FOUNDATION_EXPORT NSString * const DNotificationModifyPwdSucc;

FOUNDATION_EXPORT NSString * const DNotificationGotoBlack;

FOUNDATION_EXPORT NSString * const DNotificationLogout;

#pragma mark ---- 个人中心点击
FOUNDATION_EXPORT NSString * const DNotificationUserInfo;

FOUNDATION_EXPORT NSString * const DNotificationAboutUs;

FOUNDATION_EXPORT NSString * const DNotificationSetting;

FOUNDATION_EXPORT NSString * const DNotificationFocus;

FOUNDATION_EXPORT NSString * const DNotificationPrivacy;

FOUNDATION_EXPORT NSString * const DNotificationMyAddress;

FOUNDATION_EXPORT NSString * const DNotificationMyCircle;

FOUNDATION_EXPORT NSString * const DNotificationMyOrder;

FOUNDATION_EXPORT NSString * const DNotificationAvatar;

#pragma mark ---- person

FOUNDATION_EXPORT NSString * const DNotificationAddBlack;

FOUNDATION_EXPORT NSString * const DNotificationRemoveBlack;

FOUNDATION_EXPORT NSString * const DNotificationAddFocus;

FOUNDATION_EXPORT NSString * const DNotificationRemoveFocus;

#pragma mark ---- 圈子

FOUNDATION_EXPORT NSString * const DNotificationCircleClick;

FOUNDATION_EXPORT NSString * const DNotificationCircleShare;

FOUNDATION_EXPORT NSString * const DNotificationCirclePublishSucc;

FOUNDATION_EXPORT NSString * const DNotificationCircleGotoReport;

FOUNDATION_EXPORT NSString * const DNotificationCircleImageClick;

FOUNDATION_EXPORT NSString * const DNotificationCircleVideoClick;

FOUNDATION_EXPORT NSString * const DNotificationCircleAudioClick;

#pragma mark ---- 商城

FOUNDATION_EXPORT NSString * const DNotificationStoreClick;

FOUNDATION_EXPORT NSString * const DNotificationStoreDetailBuy;

FOUNDATION_EXPORT NSString * const DNotificationStoreBuy;

FOUNDATION_EXPORT NSString * const DNotificationStoreCart;

FOUNDATION_EXPORT NSString * const DNotificationStoreAddress;

FOUNDATION_EXPORT NSString * const DNotificationStoreOrder;

#pragma mark ---- 地址

FOUNDATION_EXPORT NSString * const DNotificationAddressSelect;

FOUNDATION_EXPORT NSString * const DNotificationAreaSelect;

#pragma mark ---- banner

FOUNDATION_EXPORT NSString * const DNotificationBannerClick;

#pragma mark ---- item


FOUNDATION_EXPORT NSString * const DNotificationItemClick;

@interface DNotificationConfigration: NSObject

+ (void)postNotificationWithName:(_Nonnull NSNotificationName) name
                        andValue:(nullable id)value
                         andFrom:(nullable UIViewController *)from;

@end

NS_ASSUME_NONNULL_END
