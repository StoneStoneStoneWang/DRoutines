//
//  WLCacheUtil.m
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/4/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLCacheUtil.h"
#import <YYCache/YYCache.h>

static WLCacheUtil *manager = nil;

@interface WLCacheUtil()

@property (nonatomic ,strong , readwrite)YYCache *cache;
@end

@implementation WLCacheUtil

+ (instancetype)shared {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [self new];
    });
    return manager;
}

- (void)createCache:(NSString *)name {
    
    self.cache = [YYCache cacheWithName:name ];
}

- (void)saveObj:(id<NSCoding>)obj withKey:(NSString *)key {
    
    if ([self checkEnv]) [self.cache setObject:obj forKey:key];
}

- (nullable id<NSCoding>)fetchObj:(NSString *)key {
    
    if ([self checkEnv]) return [self.cache objectForKey:key];
    
    return nil;
}
- (BOOL)checkEnv {
    
    return self.cache;
}

@end
