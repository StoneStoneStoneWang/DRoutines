//
//  WLReportImpl.h
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/13.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLProjectConfig.h"
#import "Mixed.h"
@import SCircle;
NS_ASSUME_NONNULL_BEGIN

@interface WLReportImpl : NSObject <WLReportConfig>

+ (instancetype)createReportImpl;

@end

NS_ASSUME_NONNULL_END
