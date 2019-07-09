//
//  WLItemsViewController.m
//  JiuTouZhu
//
//  Created by three stone 王 on 2018/8/16.
//  Copyright © 2018年 three stone 王. All rights reserved.
//

#import "WLItemsViewController.h"
#import "WLHomeItemsView.h"
#import "WLCircleImplViewController.h"
#import "WLReportImplViewController.h"
#import "WLCircleDetailImplViewController.h"
#import "WLProjectConfig.h"
//#import <WLThirdUtil/WLJShareUtil.h>
#import <WLThirdUtil/WLHudUtil.h>
#import <WXApi.h>
#define HScreenH [UIScreen mainScreen].bounds.size.height
#define HScreenW [UIScreen mainScreen].bounds.size.width
#define IS_IPHONE_X ((HScreenH >= 812)?YES:NO)
#define Navigation_Bar_Height (IS_IPHONE_X ? 88.0f : 64.0f)
#define Tab_height (IS_IPHONE_X ? 73 : 49)

@interface WLItemsViewController () <WLHomeItemsViewDelegate ,WLCircleDelegate ,WLCircleDetailDelegate>

{
    
    WLHomeItemsView *_itemsView;
}

@end

@implementation WLItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _itemsView  = [WLHomeItemsView homeItemsView];
    
    _itemsView.frame = CGRectMake(0, 1, CGRectGetWidth([UIScreen mainScreen].bounds), 110);
    
    [self.view addSubview:_itemsView];
    
    _itemsView.backgroundColor = [UIColor whiteColor];
    
    _itemsView.mDelegate = self;
}

- (void)onItemClick:(WLItemTypeBean *)item {
    
    WLCircleImplViewController * vc = [WLCircleImplViewController createCircleImplWithTag: item.title andStyle:WLCircleStyle_Global andLoginStyle:WLLoginStyle_Global andDelegate:self andIsMy:false];
    
    [self.navigationController pushViewController:vc animated:true];
}

- (void)onCircleClick:(UIViewController *)vc circlJson:(NSDictionary<NSString *,id> *)circlJson uid:(NSString *)uid encoded:(NSString *)encoded {
    
    WLCircleDetailImplViewController *circleDetail = [WLCircleDetailImplViewController createCircleDetailImplWithStyle:WLCircleDetailStyleOne andContentStyle:WLContentStyleOne andCommentStyle:WLCommentStyleOne andLoginStyle:WLLoginStyle_Global andUid:uid andEncoded:encoded andCircleJson:circlJson andDelegate:self];
    
    [vc.navigationController pushViewController:circleDetail animated:true];
}

- (void)onReportClick:(UIViewController *)vc uid:(NSString *)uid encoded:(NSString *)encoded {
    
    WLReportImplViewController *report = [WLReportImplViewController createReportWithEncoded:encoded andUid:uid andStyle:WLReportStyleOne];
    
    [vc.navigationController pushViewController:report animated:true];
}
- (void)onShareClick:(UIViewController *)vc webUrl:(NSString *)webUrl title:(NSString *)title desc:(NSString *)desc {
    
    NSString *version = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    if ([version compare:@"1.1.0"] == NSOrderedDescending) {
        
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
        // 是否是文档
        req.bText =  NO;
        //    WXSceneSession  = 0,        /**< 聊天界面    */
        //    WXSceneTimeline = 1,        /**< 朋友圈      */
        //    WXSceneFavorite = 2,
        // 好友列表
        req.scene = WXSceneSession;
        //创建分享内容对象
        WXMediaMessage *urlMsg = [WXMediaMessage message];
        urlMsg.title = title;//分享标题
        urlMsg.description = desc;//分享描述
        [urlMsg setThumbImage:[UIImage imageNamed:@Logo]];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
        //创建多媒体对象
        WXWebpageObject *obj = [WXWebpageObject object];
        obj.webpageUrl = webUrl;//分享链接
        //完成发送对象实例
        urlMsg.mediaObject = obj;
        req.message = urlMsg;
        //发送分享信息
        [WXApi sendReq:req];
    }
}

@end
