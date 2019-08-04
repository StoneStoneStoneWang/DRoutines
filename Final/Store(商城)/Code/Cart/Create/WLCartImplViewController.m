//
//  WLCartImplViewController.m
//  DStoreFinalDemo
//
//  Created by three stone 王 on 2019/8/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLCartImplViewController.h"
#import "WLStoreConfigImpl.h"
#import "WLAddressConfigImpl.h"
@import DStore;
#define HScreenH [UIScreen mainScreen].bounds.size.height
#define HScreenW [UIScreen mainScreen].bounds.size.width
#define IS_IPHONE_X ((HScreenH >= 812)?YES:NO)
#define Navigation_Bar_Height (IS_IPHONE_X ? 88.0f : 64.0f)
#define Tab_height (IS_IPHONE_X ? 73 : 49)

@interface WLCartImplViewController ()

@end

@implementation WLCartImplViewController

+ (instancetype)createCartImpl {
    
    return [self new];
}
- (void)s_addOwnSubViewController {
    
    WLCartBaseViewController *impl = [WLCartBaseViewController createOrder:@"购物车" config:[WLStoreConfigImpl createStoreConfigImpl] addressConfig:[WLAddressConfigImpl createAddress]];
    
    [self.view addSubview:impl.view];
    
    [self addChildViewController:impl];
    
    impl.view.frame = self.view.bounds;
    
    NSString *version = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    if ([version compare:@"1.1.0"] == NSOrderedDescending) {
        
        UITableView *tableView;
        
        for (UIView *view in impl.view.subviews) {
            
            if ([view isKindOfClass:[UITableView class ]]) {
                
                ((UITableView *)view).clipsToBounds = false;
                
                tableView = (UITableView *)view;
                
                break;
            }
        }
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HScreenW, Tab_height)];
        
        tableView.tableFooterView = view;
    }
}

- (void)s_configNaviItem {
    
    self.title = @"购物车";
}


@end
