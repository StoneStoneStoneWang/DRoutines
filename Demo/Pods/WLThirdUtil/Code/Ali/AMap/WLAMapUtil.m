//
//  WLMapUtil.m
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/5/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLAMapUtil.h"

@implementation WLAMapUtil

+ (instancetype)shared {
    static WLAMapUtil *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [WLAMapUtil new];
    });
    return manager;
}
- (void)registerApiKey:(NSString *)apiKey {
    
    [AMapServices sharedServices].apiKey = apiKey;
}
@end
