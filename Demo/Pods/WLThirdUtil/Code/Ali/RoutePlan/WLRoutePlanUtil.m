//
//  WLRoutePlanUtil.m
//  WLThirdUtilDemo
//
//  Created by 张丽 on 2019/6/12.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLRoutePlanUtil.h"
#import <UIKit/UIKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>



@interface WLRoutePlanUtil () <AMapSearchDelegate>

@property (nonatomic ,strong ,readwrite) AMapSearchAPI *search;

@property (nonatomic, strong) AMapRoute *route;

//@property (nonatomic) AMapRoutePlanningType routePlanningType;

@end

@implementation WLRoutePlanUtil

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.search = [AMapSearchAPI new];
        
        self.search.delegate = self;
    }
    return self;
}

#pragma mark - do search

/**
 * @brief 规划路线
 * @param routePlanningType 交通方式
 * @param origin 出发点
 * @param destination 目的地
 * @param city 城市,
 * @param destinationCity 目的城市, 跨城时需要填写，否则会出错
 */
- (void)searchRoutePlanningWithRoutePlanningType:(AMapRoutePlanningType)routePlanningType andOrigin:(AMapGeoPoint *)origin andDestination:(AMapGeoPoint *)destination andCity:(NSString *)city andDestinationCity:(NSString *)destinationCity NS_SWIFT_NAME(searchRoutePlanning(WithRoutePlanningType:andOrigin:andDestination:andCity:andDestinationCity:)) {

    switch (routePlanningType) {
        case AMapRoutePlanningTypeDrive: {
            AMapDrivingRouteSearchRequest *navi = [[AMapDrivingRouteSearchRequest alloc] init];
            navi.waypoints = @[[AMapGeoPoint locationWithLatitude:45.780563 longitude:126.651764]];
            navi.requireExtension = YES;
//                navi.strategy = 0;
            /* 出发点. */
            navi.origin = origin;
            /* 目的地. */
            navi.destination = destination;
            [self.search AMapDrivingRouteSearch:navi];
        }
            break;
            
        case AMapRoutePlanningTypeWalk:{
            AMapWalkingRouteSearchRequest *navi = [[AMapWalkingRouteSearchRequest alloc] init];

            /* 提供备选方案*/
            navi.multipath = 1;
            /* 出发点. */
            navi.origin = origin;
            /* 目的地. */
            navi.destination = destination;
            [self.search AMapWalkingRouteSearch:navi];
        }
            break;
            
        case AMapRoutePlanningTypeBus:
        {
            AMapTransitRouteSearchRequest *navi = [[AMapTransitRouteSearchRequest alloc] init];
            
            navi.requireExtension = YES;
            navi.city = city;
            /* 出发点. */
            navi.origin = origin;
            /* 目的地. */
            navi.destination = destination;
            
            [self.search AMapTransitRouteSearch:navi];
        }
            break;
            
        case AMapRoutePlanningTypeBusCrossCity:{
            AMapTransitRouteSearchRequest *navi = [[AMapTransitRouteSearchRequest alloc] init];
            
            navi.requireExtension = YES;
            navi.city = city;
            navi.destinationCity  = destinationCity;
            
            /* 出发点. */
            navi.origin = origin;
            /* 目的地. */
            navi.destination = destination;
            
            [self.search AMapTransitRouteSearch:navi];
        }
            break;
            
        case AMapRoutePlanningTypeRiding:{
            AMapRidingRouteSearchRequest *navi = [[AMapRidingRouteSearchRequest alloc] init];
            
            /* 出发点. */
            navi.origin = origin;
            /* 目的地. */
            navi.destination = destination;
            
            [self.search AMapRidingRouteSearch:navi];
        }            break;
            
        default:
            break;
    }
}

#pragma mark - AMapSearchDelegate

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    
    NSLog(@"Error: %@", error);
}

/* 路径规划搜索回调. */
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response {
    
    if (response.route == nil)
    {
        return;
    }
    
    // 解析response获取路径信息，
    self.route = response.route;
    
    if (response.count > 0) {
        
        // 展示当前路线
        //        [self presentCurrentCourse];
    }
}


@end
