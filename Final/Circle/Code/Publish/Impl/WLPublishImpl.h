//
//  WLPublishImpl.h
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLProjectConfig.h"
#import "Mixed.h"
@import SCircle;
NS_ASSUME_NONNULL_BEGIN

@interface WLPublishImpl : NSObject <WLPublishConfig>

+ (instancetype)createPublishImpl;

@end

NS_ASSUME_NONNULL_END
