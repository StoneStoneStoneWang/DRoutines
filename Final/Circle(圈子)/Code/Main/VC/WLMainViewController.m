//
//  WLMainViewController.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/10.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLMainViewController.h"

@interface WLMainViewController () 

@property (nonatomic ,strong) NSMutableArray *tabs;
@end

@implementation WLMainViewController


- (BOOL)prefersStatusBarHidden {
    return false;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleDefault;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}
@end
