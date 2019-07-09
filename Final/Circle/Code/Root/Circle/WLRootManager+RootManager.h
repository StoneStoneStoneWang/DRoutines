//
//  WLRootManager+RootManager.h
//  WLProjectKitDemo
//
//  Created by three stone 王 on 2019/5/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//


#import "WLRootManager.h"
@import SWelcome;
@import SProfile;

@interface WLRootManager( RootManager) <WLWelComeBaseDelegate,WLProfileViewControllerMyPubDelegate>

- (void)makeRoot:( UIResponder <UIApplicationDelegate> * _Nullable)appdelegate;

@end
