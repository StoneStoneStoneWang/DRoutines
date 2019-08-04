//
//  WLAddressConfigImpl.h
//  DStoreFinalDemo
//
//  Created by three stone 王 on 2019/8/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>
@import DAddress;
NS_ASSUME_NONNULL_BEGIN

@interface WLAddressConfigImpl : NSObject <WLAddressConfig>

+ (instancetype)createAddress;

@end

NS_ASSUME_NONNULL_END
