//
//  WLCircleImpl.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/13.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLCircleImpl.h"

@implementation WLCircleImpl

+ (instancetype)createCircleImpl {
    
    return [self new];
}
- (NSString *)defaultIcon {
    
    return @DefaultIcon;
}
- (NSString *)itemColor {
    
    return @WL_P_Color;
}

- (NSString *)commentIcon {
    
    return @CommentIcon;
}
- (NSString *)watchIcon {
    
    return @WatchIcon;
}
- (NSString *)funNIcon {
    
    return @FunNIcon;
}
- (NSString *)funSIcon {
    
    return @FunSIcon;
}

- (NSString *)moreIcon {
    
    return @CircleMoreIcon;
}

@synthesize broadIcon;

- (NSString *)broadIcon {
    
    return @BroadIcon;
}

@end
