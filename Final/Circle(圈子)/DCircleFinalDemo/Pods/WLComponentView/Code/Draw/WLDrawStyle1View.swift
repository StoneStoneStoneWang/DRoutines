//
//  WLDrawStyle1View.swift
//  WLCompoentViewDemo
//
//  Created by three stone 王 on 2019/4/17.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
@objc (WLLoginStyle1View)
public final class WLLoginStyle1View: UIView {
    @objc (fillColor)
    public var fillColor: UIColor = .white {
        
        willSet {
            
            setNeedsDisplay()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension WLLoginStyle1View {
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let pi:CGFloat = CGFloat(Double.pi)
        
        let radius: CGFloat = 30
        
        fillColor.setFill()
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // MARK: draw highlighted
        // 0 开始的点
        context.move(to: CGPoint(x: bounds.minX, y: bounds.minY + radius))
        // 1  左线
        context.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY * 3 / 4 - radius ))
        // 2  左下圆角
        context.addArc(center: CGPoint(x: bounds.minX + radius, y: bounds.maxY * 2 / 3 ), radius: radius, startAngle: pi, endAngle: pi / 2 + pi / 10, clockwise: true)
        // 3 下线
        context.addLine(to: CGPoint(x: bounds.maxX - radius, y: bounds.maxY))
        // 4 右下圆角
        context.addArc(center: CGPoint(x: bounds.maxX - radius, y: bounds.maxY - radius), radius: radius, startAngle: pi / 2, endAngle: 0, clockwise: true)
        // 5 右线
        context.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY + radius))
        // 5 右上圆角
        context.addArc(center: CGPoint(x: bounds.maxX - radius, y: bounds.minY + radius), radius: radius, startAngle: 0.0, endAngle: -pi / 2, clockwise: true)
        // 6 上线
        context.addLine(to: CGPoint(x: bounds.minX + radius, y:bounds.minY))
        // 7 左上圆角
        context.addArc(center: CGPoint(x: bounds.minX + radius, y: bounds.minY + radius), radius: radius, startAngle: -pi / 2, endAngle: pi, clockwise: true)
        
        context.fillPath()
        
    }
}
