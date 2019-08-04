//
//  WLNaviImpl.m
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/4/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "WLNaviImpl.h"

@implementation WLNaviImpl

+ (instancetype)createNaviImpl {
    
    return [self new];
}

@synthesize Back_Image;

- (NSString *)Back_Image {
    
    return @BackIcon;
}

@synthesize Background_HEXColor;

- (NSString *)Background_HEXColor {
    
    return @SBackground_HEXColor;
}

@synthesize NaviBackground_HEXColor;

- (NSString *)NaviBackground_HEXColor {
    
    return @WL_P_Color;
}
@synthesize Title_FontSize;

- (CGFloat)Title_FontSize {
    
    return 20;
}

@synthesize Title_HEXColor;

- (NSString *)Title_HEXColor {
    
    return @STitle_HEXColor;
}

@end
