//
//  WLCircleDetailImpl.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/13.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLCircleDetailImpl.h"

@implementation WLCircleDetailImpl

@synthesize moreIcon;

+ (instancetype)createCircleDetailImpl {
    
    return [self new];
}
- (NSString *)moreIcon {
    
    return @DetailMoreIcon;
}
@synthesize backIcon;
- (NSString *)backIcon {
    
    return @BackIcon;
}
@end
