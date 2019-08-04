//
//  WLNaviImpl.h
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/4/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

@import Foundation;
@import WLBaseViewController;
#import "WLProjectConfig.h"
#import "Mixed.h"

NS_ASSUME_NONNULL_BEGIN

@interface WLNaviImpl : NSObject <WLNaviControllerConfig>

+ (instancetype)createNaviImpl;

@end

NS_ASSUME_NONNULL_END
