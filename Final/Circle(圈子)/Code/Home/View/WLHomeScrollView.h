//
//  WLHomeScrollView.h
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/14.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLItemTypeBean.h"
@import DCircle;
@import DProfile;
@import DLogin;

#import "Mixed.h"
#define kHome_Width CGRectGetWidth([UIScreen mainScreen].bounds)

#define kBanner_Height kHome_Width / 2

#define kItems_Height 110

#define kRectangle_Height 10

NS_ASSUME_NONNULL_BEGIN

@protocol WLHomeScrollViewDelegate <NSObject>

- (void)onScrollViewScroll:(CGFloat )contentoffsetY;

- (void)onNaviTitleViewShow:(BOOL )show ;

- (void)onItemClick:(WLItemTypeBean *)item;

@end

@interface WLHomeScrollView : UIScrollView

+ (instancetype)homeScrollViewWithCircleStyle:(WLCircleStyle)circleStyle andLoginStyle:(WLLoginStyle )loginStyle;

- (void)addChildViewController:(UIViewController *)home;

@property (nonatomic ,weak) id<WLHomeScrollViewDelegate> mDelegate;

- (void)commitInit;

@property (nonatomic , assign,readonly) CGFloat contentOffsetY;

@end

NS_ASSUME_NONNULL_END
