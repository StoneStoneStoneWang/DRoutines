//
//  WLProfileImpl.h
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/4/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//
@import Foundation;
@import DProfile;
#import "Mixed.h"
#import "WLProjectConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface WLProfileImpl : NSObject <WLProfileConfig>

+ (instancetype)createProfileImpl;

@end

NS_ASSUME_NONNULL_END
