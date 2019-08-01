//
//  WLMainBean.h
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/13.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mixed.h"
typedef NS_ENUM(NSInteger ,WLMainType) {
    
    WLMainTypeHome,
    
    WLMainTypeImage,
    
    WLMainTypeVideo,
    
    WLMainTypeList,
    
    WLMainTypeCustom,
    
    WLMainTypeProfile,
    
    WLMainTypeTranslate
};

NS_ASSUME_NONNULL_BEGIN

@interface WLMainBean : NSObject

@property (nonatomic ,assign) WLMainType type;

@property (nonatomic ,copy) NSString *title;

@property (nonatomic ,copy) NSString *tag;

@property (nonatomic ,copy) NSString *normalIcon;

@property (nonatomic ,copy) NSString *selectedIcon;


+ (instancetype)mainBeanWithType:(WLMainType )type andTitle:(NSString *)title andTag:(NSString *)tag andNormalIcon:(NSString *)normalIcon andSelectedIcon:(NSString *)selectedIcon;

@end

NS_ASSUME_NONNULL_END
