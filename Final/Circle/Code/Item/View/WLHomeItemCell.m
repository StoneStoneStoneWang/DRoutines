//
//  WLHomeItemCell.m
//  JiuTouZhu
//
//  Created by three stone 王 on 2018/8/15.
//  Copyright © 2018年 three stone 王. All rights reserved.
//

#import "WLHomeItemCell.h"
#import "WLHomeItemsView.h"
@import WLToolsKit;
#define k_margin 5
@interface WLHomeItemCell()

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *titleLabel;

@end

@implementation WLHomeItemCell
- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [UIImageView new];
    }
    return _iconImageView;
}
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.font = [UIFont systemFontOfSize:14];
        
        _titleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self commitInit];
    }
    return self;
}
- (void)commitInit {
    
    [self addSubview:self.iconImageView];
    
    [self addSubview:self.titleLabel];
    
}
- (void)updateViewData:(WLItemTypeBean *)data {
    
    self.iconImageView.image = [UIImage imageNamed:data.icon];
    
    self.titleLabel.text = data.title;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iconImageView.frame = CGRectMake(k_margin, 0, kItem_Size_W - k_margin * 2, kItem_Size_W - k_margin * 2);
    
    self.titleLabel.frame = CGRectMake(0, kItem_Size_W - k_margin, kItem_Size_W, kItem_Size_H - kItem_Size_W + k_margin * 3);
}

@end
