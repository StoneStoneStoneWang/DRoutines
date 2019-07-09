//
//  WLCircleStyle.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/7.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
@objc (WLCircleStyle)
public enum WLCircleStyle: Int {
    
    case one // 左侧一张 正方形
    
    case two // 左侧一张 长方形 4 * 3
    
    // 4 * 3 最多九张
    
    case three // 1*1 最多三张
    
    case four // 4 * 3 最多九张
    
    case five // 1*1 最多九张
    
    case six // 右侧一张
    
    case seven // 上有名字和标题，下有更多，中间是大图
}
