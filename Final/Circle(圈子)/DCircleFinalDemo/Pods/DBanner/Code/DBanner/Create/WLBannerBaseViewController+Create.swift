//
//  WLBannerBaseViewController+Create.swift
//  DBannerDemo
//
//  Created by three stone 王 on 2019/7/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

extension WLBannerBaseViewController {
    @objc (createBannerWithBanners:andStyle:)
    public static func createBanner(_ banners: [String] ,style: WLBannerStyle) -> WLBannerBaseViewController {
        
        return WLBannerBaseViewController(banners, style: style)
    }
}
