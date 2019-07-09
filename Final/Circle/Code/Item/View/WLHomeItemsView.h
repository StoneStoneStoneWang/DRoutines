//
//  WLHomeItemsView.h
//  JiuTouZhu
//
//  Created by three stone 王 on 2018/8/15.
//  Copyright © 2018年 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLItemTypeBean.h"
#define kItem_Size_W 60

#define kItem_Size_H 80

#define k_Item_Inset 15

@protocol WLHomeItemsViewDelegate <NSObject>

- (void)onItemClick:(WLItemTypeBean *)item;

@end

@interface WLHomeItemsView : UICollectionView

+ (instancetype)homeItemsView;

@property (nonatomic ,weak) id<WLHomeItemsViewDelegate> mDelegate;

@end
