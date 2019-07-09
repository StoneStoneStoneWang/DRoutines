//
//  WLCircleImpl.h
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/13.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mixed.h"
#import "WLProjectConfig.h"

@import SCircle;

NS_ASSUME_NONNULL_BEGIN

@interface WLCircleImpl : NSObject<WLCircleConfig>

+ (instancetype)createCircleImpl;

@end

NS_ASSUME_NONNULL_END
