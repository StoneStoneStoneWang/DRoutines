//
//  WLLocationUtil.m
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/5/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLLocationUtil.h"
#import <UIKit/UIKit.h>
@import WLToolsKit;
@interface WLLocationUtil() <AMapLocationManagerDelegate>

@property (nonatomic ,strong ,readwrite) AMapLocationManager *amlocation;

@property (nonatomic ,strong ,readwrite) CLLocationManager *cllocation;

@property (nonatomic ,assign) BOOL isAlertShow;

@property (nonatomic ,copy) WLLocationResponse locaitonResp;
@end

@implementation WLLocationUtil

- (instancetype)init {
    
    if (self = [super init]) {
        
        if ([CLLocationManager locationServicesEnabled]) {
            
            self.cllocation = [CLLocationManager new];
            
            [self.cllocation requestWhenInUseAuthorization];
            
            self.authStatus = [CLLocationManager authorizationStatus];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
            
            self.isAlertShow = false;
        }
        else { }
    }
    return self;
}

- (void)setAuthStatus:(CLAuthorizationStatus)authStatus {
    _authStatus = authStatus;
    
    switch (authStatus) {
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
        {
            
            if (!self.isAlertShow) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"检测到您未开启定位权限" message:@"点击确定前往开启权限" preferredStyle:(UIAlertControllerStyleAlert)];
                
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                    [WLOpenUrl openSetting];
                }];
                
                [alert addAction:cancel];
                
                [alert addAction:confirm];
                
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:true completion:nil];
                
                self.isAlertShow = true;
                
                return;
            }
        }
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways:
            
            if (!self.amlocation) {
                
                self.amlocation = [[AMapLocationManager alloc] init];
                
                self.amlocation.delegate = self;
                
                //iOS 9（包含iOS 9）之后新特性：将允许出现这种场景，同一app中多个locationmanager：一些只能在前台定位，另一些可在后台定位，并可随时禁止其后台定位。
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
                    self.amlocation.allowsBackgroundLocationUpdates = YES;
                }
                
                [self.amlocation setLocatingWithReGeocode:YES];
                
            }
            
            break;
        default:
            break;
    }
}

- (void)applicationDidBecomeActive {
    
    self.authStatus = [CLLocationManager authorizationStatus];
}

- (void)startLocation:(WLLocationResponse)location {
    
    if (self.amlocation) {
        
        [self.amlocation startUpdatingLocation];
    }
    self.locaitonResp = location;
}

// 停止定位
- (void)stopLocation {
    
    if (self.amlocation) {
        [self.amlocation stopUpdatingLocation];
    }
}


- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}
- (void)requestLocationWithReGeocodeWithCompletionBlock:(AMapLocatingCompletionBlock)completionBlock {
    
    [self.amlocation requestLocationWithReGeocode:true completionBlock:completionBlock];
}

- (void)amapLocationManager:(AMapLocationManager *)manager doRequireLocationAuth:(CLLocationManager *)locationManager {
    
    if ([CLLocationManager locationServicesEnabled]) {
        
        NSLog(@"可用");
        
    } else {
        
        NSLog(@"不可用");
    }
}

// 定位错误
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    //定位错误
    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}

// 定位结果
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location {
    
    NSLog(@"%@",location);
    
    if (self.amlocation) {
        
        [self.amlocation stopUpdatingLocation];
    }
    
    self.locaitonResp(location);
}

@end
