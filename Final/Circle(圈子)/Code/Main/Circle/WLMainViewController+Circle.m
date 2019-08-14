//
//  WLMainViewController+Circle.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLMainViewController+Circle.h"
//#import "WLReportImplViewController.h"
#import "WLProjectConfig.h"
#import "WLMainBean.h"
#import "WLProfileImplViewController.h"
#import "WLHomeViewController.h"
#import "WLCircleImplViewController.h"
#import "WLRootManager+RootManager.h"
@import WLBaseViewController;
@import WLToolsKit;
#import <WXApi.h>

@implementation WLMainViewController (Circle)

+ (WLMainViewController *)createCircleTab {
    
    if ([[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:[WLMainViewController class]]) {
        
        return (WLMainViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    } else {
        
        return [[WLMainViewController alloc] init];
    }
}

//- (instancetype)initWithTabs:(NSArray *)tabs {
//
//    if (self = [super init]) {
//

//    }
//    return self;
//}
//- (void)onCircleClick:(UIViewController *)vc circlJson:(NSDictionary<NSString *,id> *)circlJson uid:(NSString *)uid encoded:(NSString *)encoded {
//
//    WLCircleDetailImplViewController *circleDetail = [WLCircleDetailImplViewController createCircleDetailImplWithStyle:WLCircleDetailStyleOne andContentStyle:WLContentStyleOne andCommentStyle:WLCommentStyleOne andLoginStyle:WLLoginStyle_Global andUid:uid andEncoded:encoded andCircleJson:circlJson andDelegate:self];
//
//    [vc.navigationController pushViewController:circleDetail animated:true];
//}
//
//- (void)onReportClick:(UIViewController *)vc uid:(NSString *)uid encoded:(NSString *)encoded {
//
//    WLReportImplViewController *report = [WLReportImplViewController createReportWithEncoded:encoded andUid:uid andStyle:WLReportStyleOne];
//
//    [vc.navigationController pushViewController:report animated:true];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"isFirstLogin"];
    
    for (WLMainBean *bean in [WLRootManager shared].tabs) {
        
        if (bean.type == WLMainTypeProfile) {
            
            WLProfileImplViewController *profile = [WLProfileImplViewController createProfile];
            
            [self addChildWithChild:profile andTitle:bean.title andFontSize:12 andTitleColor:[UIColor colorWithHexString:@"#666666"] andHighColor:[UIColor colorWithHexString:@WL_P_Color] andImgName:bean.normalIcon andSelectedImgName:bean.selectedIcon];
            
        } else if (bean.type == WLMainTypeHome){
            
            WLHomeViewController *home = [WLHomeViewController new];

            [self addChildWithChild:home andTitle:bean.title andFontSize:12 andTitleColor:[UIColor colorWithHexString:@"#666666"] andHighColor:[UIColor colorWithHexString:@WL_P_Color] andImgName:bean.normalIcon andSelectedImgName:bean.selectedIcon];
            
        } else {
            
            WLCircleImplViewController *circle1 = [WLCircleImplViewController createCircleImplWithTag:bean.tag andStyle:WLCircleStyle_Global andLoginStyle:WLLoginStyle_Global andIsMy:false];
            ;

            [self addChildWithChild:circle1 andTitle:bean.title andFontSize:12 andTitleColor:[UIColor colorWithHexString:@"#666666"] andHighColor:[UIColor colorWithHexString:@WL_P_Color] andImgName:bean.normalIcon andSelectedImgName:bean.selectedIcon];
        }
    }
    
}
- (void)onShareClick:(UIViewController * _Nonnull)vc webUrl:(NSString * _Nonnull)webUrl title:(NSString * _Nonnull)title desc:(NSString * _Nonnull)desc {
    
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

- (void)onCircleTap:(UIViewController * _Nonnull)vc {
    
//    WLCircleImplViewController *circle1 = [WLCircleImplViewController createCircleImplWithTag:@"" andStyle:WLCircleStyle_Global andLoginStyle:WLLoginStyle_Global andDelegate:self andIsMy:true];
//
//    [vc.navigationController pushViewController:circle1 animated:true];
}

@end
