//
//  WLItemTypeBean.h
//  奥迪车友会
//
//  Created by three stone 王 on 2019/3/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mixed.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger ,WLItemType) {
    
    WLItemTypeTip = 1, // 同城爆料
    
    WLItemTypeJob1 = 2, // 求职
    
    WLItemTypeJob2 = 3, // 应聘
    
    WLItemTypeJob3 = 4 //  招聘
};

@interface WLItemTypeBean : NSObject

@property (nonatomic ,assign) WLItemType type;

@property (nonatomic ,copy) NSString *title;

@property (nonatomic ,copy) NSString *icon;

+ (instancetype)itemBeanWithType:(WLItemType) type andTitle:(NSString *)title andIcon:(NSString *)icon;

- (instancetype)initWithType:(WLItemType) type andTitle:(NSString *)title andIcon:(NSString *)icon;


@end

NS_ASSUME_NONNULL_END
