//
//  WLAMapView.m
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/5/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLAMapView.h"

@implementation WLAMapView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    CGPoint convertPoint = [self convertPoint:point toView: self.window];
    
    if (convertPoint.x <= self.respLeft) {
        
        [self setScrollEnabled:false];
    } else {
        
        [self setScrollEnabled:true];
    }
    
    return [super hitTest:point withEvent:event];
}

@end
