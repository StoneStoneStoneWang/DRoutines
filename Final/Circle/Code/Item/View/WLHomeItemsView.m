//
//  WLHomeItemsView.m
//  JiuTouZhu
//
//  Created by three stone 王 on 2018/8/15.
//  Copyright © 2018年 three stone 王. All rights reserved.
//

#import "WLHomeItemsView.h"
#import "WLHomeItemCell.h"
@interface WLHomeItemsView() <UICollectionViewDelegate ,UICollectionViewDataSource>

@property (nonatomic ,strong) NSMutableArray *ts_dataArray;

@property (nonatomic ,strong ) UICollectionViewFlowLayout *flowlayout;

@end
@implementation WLHomeItemsView

+ (instancetype)homeItemsView {
    
    UICollectionViewFlowLayout *flowlayout = [UICollectionViewFlowLayout new];
    
    flowlayout.itemSize = CGSizeMake(kItem_Size_W, kItem_Size_H + k_Item_Inset);
    
    flowlayout.sectionInset = UIEdgeInsetsMake(k_Item_Inset, k_Item_Inset, 0, k_Item_Inset);
    
    return [[self alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout];
}
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        self.flowlayout = (UICollectionViewFlowLayout *)layout;
        
        [self commitInit];
    }
    return self;
}
- (NSMutableArray *)ts_dataArray {
    
    if (!_ts_dataArray) {
        
        _ts_dataArray = [NSMutableArray arrayWithArray:WLItemTypeBean.itemTypes];
    }
    return _ts_dataArray;
}
- (void)commitInit {
    
    self.showsVerticalScrollIndicator = false;
    
    self.showsHorizontalScrollIndicator = false;
    
    self.bounces = false;
    
    [self registerClass:[WLHomeItemCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.dataSource = self;
    
    self.delegate = self;
    
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat w = CGRectGetWidth([UIScreen mainScreen].bounds);
    
    CGFloat space = (w - k_Item_Inset * 2 - WLItemTypeBean.itemTypes.count * kItem_Size_W) / ( WLItemTypeBean.itemTypes.count - 1);
    
    self.flowlayout.minimumInteritemSpacing = space;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (void)updateViewData:(NSArray *)data {
    
    [self.ts_dataArray removeAllObjects];
    
    [self.ts_dataArray addObjectsFromArray:data];
    
    [self reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.ts_dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WLHomeItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell updateViewData:self.ts_dataArray[indexPath.row]];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_mDelegate && [_mDelegate respondsToSelector:@selector(onItemClick:)]) {
        
        [_mDelegate onItemClick:self.ts_dataArray[indexPath.row] ];
    }
}

@end
