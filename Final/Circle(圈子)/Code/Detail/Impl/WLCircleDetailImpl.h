//
//  WLCircleDetailImpl.h
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/13.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>
@import DCircle;
#import "WLProjectConfig.h"
#import "Mixed.h"
NS_ASSUME_NONNULL_BEGIN

@interface WLCircleDetailImpl : NSObject <WLCommentConfig,WLContentConfig>

+ (instancetype)createCircleDetailImpl;

@end

NS_ASSUME_NONNULL_END
