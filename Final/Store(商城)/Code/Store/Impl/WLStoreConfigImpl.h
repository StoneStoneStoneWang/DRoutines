//
//  WLStoreConfigImpl.h
//  DStoreFinalDemo
//
//  Created by three stone 王 on 2019/8/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>
@import DStore;
NS_ASSUME_NONNULL_BEGIN

@interface WLStoreConfigImpl : NSObject <WLStoreConfig>

+ (instancetype)createStoreConfigImpl;

@end

NS_ASSUME_NONNULL_END
