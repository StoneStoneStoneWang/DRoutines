//
//  WLHomeScrollView.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/14.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLHomeScrollView.h"

#import "WLLoginImpl.h"
#import "WLCircleImpl.h"
#import "WLItemsViewController.h"
@import MJRefresh;
@import DBanner;
#define HScreenH [UIScreen mainScreen].bounds.size.height
#define HScreenW [UIScreen mainScreen].bounds.size.width
#define IS_IPHONE_X ((HScreenH >= 812)?YES:NO)
#define Navigation_Bar_Height (IS_IPHONE_X ? 88.0f : 64.0f)
#define Tab_height (IS_IPHONE_X ? 73 : 49)
@interface WLHomeScrollView()
    
    @property (nonatomic ,assign) WLCircleStyle circleStyle;
    
    @property (nonatomic ,assign) WLLoginStyle loginStyle;
    
    @property (nonatomic ,weak) id <WLCircleDelegate> circleDelegate ;
    
    @property (nonatomic ,strong) UITableView *listView;
    
    @property (nonatomic , assign, readwrite) CGFloat contentOffsetY;
    
    @end

@implementation WLHomeScrollView
    {
        WLBannerBaseViewController *_banerVC;
        
        WLItemsViewController *_itemsVC;
        
        WLCircleBaseViewController *_listVC;
        
        UIView *_rectangle;
    }
+ (instancetype)homeScrollViewWithCircleStyle:(WLCircleStyle)circleStyle andLoginStyle:(WLLoginStyle )loginStyle andDelegate:(id <WLCircleDelegate>)circleDelegate {
    
    return [[self alloc] initWithCircleStyle:circleStyle andLoginStyle:loginStyle andDelegate:circleDelegate];
}
- (instancetype)initWithCircleStyle:(WLCircleStyle)circleStyle andLoginStyle:(WLLoginStyle )loginStyle andDelegate:(id <WLCircleDelegate>)circleDelegate {
    
    if (self = [super init]) {
        
        self.circleStyle = circleStyle;
        
        self.loginStyle = loginStyle;
        
        self.circleDelegate = circleDelegate;
        
        [self commitInit];
    }
    return self;
}
    
- (void)commitInit {
    
#pragma mark --- _listVC
    _listVC = [WLCircleBaseViewController createCircleWithTag:@"" andIsMy:false andStyle:self.circleStyle andConfig:[WLCircleImpl createCircleImpl] andLoginStyle:self.loginStyle andLoginConfig:[WLLoginImpl createLoginImpl]  andDelegate:self.circleDelegate ];
    
    [self addSubview:_listVC.view];
    
    for (UITableView *view in _listVC.view.subviews) {
        
        if ([view isKindOfClass:[UITableView class ]]) {
            
            ((UITableView *)view).clipsToBounds = false;
            
            self.listView = (UITableView *)view;
            
            break;
        }
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HScreenW, Tab_height)];
    
    self.listView.tableFooterView = view;
    
    //    self.listView.mj_insetT = kItems_Height + kRectangle_Height + kBanner_Height;
#pragma mark --- 自己的属性
    self.backgroundColor = [UIColor clearColor];
    
    self.showsVerticalScrollIndicator = false;
    
    self.showsHorizontalScrollIndicator = false;
    
    self.bounces = false;
#pragma mark --- banner
    
    _banerVC = [WLBannerBaseViewController createBanner:@[@"banner1",@"banner1"] style:WLBannerStyleOne];
    
    [self addSubview:_banerVC.view];
#pragma mark --- _itemsView 标题view
    _itemsVC = [WLItemsViewController new];
    
    [self addSubview:_itemsVC.view];
    
    //    _itemsView.mDelegate = self;
    
#pragma mark --- _rectangle
    //
    _rectangle = [UIView new];
    
    [self addSubview:_rectangle];
    //
    //#pragma mark --- 手势添加与移除
    //    //移除base原有手势操作
    NSMutableArray *list = [NSMutableArray arrayWithArray:self.gestureRecognizers];
    
    for (UIGestureRecognizer *gestureRecognizer in list) {
        
        [self removeGestureRecognizer:gestureRecognizer];
    }
    
    //将tableview的手势操作加到base中
    for (UIGestureRecognizer *gestureRecognizer in self.listView.gestureRecognizers) {
        
        [self addGestureRecognizer:gestureRecognizer];
    }
    //
#pragma mark --- 添加 kvo contentOffset 监听
    [self.listView addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionNew) context:nil];
}
    
- (void)addChildViewController:(UIViewController *)home {
    
    [home addChildViewController:_banerVC];
    
    [home addChildViewController:_listVC];
    
    [home addChildViewController: _itemsVC];
}
    
#pragma mark  ----- layoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _banerVC.view.frame = CGRectMake(0, 0, kHome_Width, kBanner_Height);
    //
    _itemsVC.view.frame = CGRectMake(0, kBanner_Height + Navigation_Bar_Height, kHome_Width, kItems_Height);
    //
    _rectangle.frame = CGRectMake(0, kBanner_Height + kItems_Height + Navigation_Bar_Height,  kHome_Width, kRectangle_Height);
    
    _listVC.view.frame = self.bounds;
    
    self.listView.mj_insetT = kItems_Height + kRectangle_Height + kBanner_Height;
    
}
#pragma mark  ----- hitTest
    
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
    {
        for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
            
            CGPoint convertedPoint = [subview convertPoint:point fromView:self];
            
            UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
            
            if (hitTestView) {
                
                return hitTestView;
            }
        }
        
        return [super hitTest:point withEvent:event];
    }
    
#pragma mark  ----- observeValueFor contentOffset
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
        
        self.contentOffsetY = offset.y;
        
        CGFloat h = kItems_Height + kRectangle_Height + kBanner_Height;
        
        if (_mDelegate && [_mDelegate respondsToSelector:@selector(onNaviTitleViewShow:)]) {
            
            [_mDelegate onNaviTitleViewShow:offset.y >= -kRectangle_Height ];
        }
        
        if (offset.y >= -h) {
            
            if (offset.y <= 0) {
                
                _itemsVC.view.frame = CGRectMake(0,-(offset.y + h - kBanner_Height), kHome_Width, kItems_Height);
                
                _rectangle.frame = CGRectMake(0,-(offset.y  + kRectangle_Height), kHome_Width, kRectangle_Height);
                
                _itemsVC.view.alpha = -offset.y / kItems_Height;
                
                _rectangle.alpha = -offset.y / kRectangle_Height;
                
            } else {
                
                return;
            }
        } else {
            
            _itemsVC.view.frame = CGRectMake(0, kBanner_Height, kHome_Width, kItems_Height);
            
            _rectangle.frame = CGRectMake(0, kBanner_Height + kItems_Height, kHome_Width, kRectangle_Height);
            
            return;
        }
    }
}
    
    @end
