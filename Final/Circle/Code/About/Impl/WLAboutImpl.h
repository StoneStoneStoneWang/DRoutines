//
//  WLAboutImpl.h
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/4/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

@import Foundation;
#import "WLProjectConfig.h"
#import "Mixed.h"
@import SProfile;
NS_ASSUME_NONNULL_BEGIN

@interface WLAboutImpl : NSObject <WLAboutConfig>

+ (instancetype)createAboutImpl;

@end

NS_ASSUME_NONNULL_END
