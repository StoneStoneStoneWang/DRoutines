//
//  WLRootManager.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/13.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLRootManager.h"

@interface WLRootManager() 

@end

static WLRootManager *manager = nil;
@implementation WLRootManager
+ (instancetype)shared {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [self new];
    });
    return manager;
}

@end

