//
//  WLPublishTableFooterView.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/6.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLToolsKit

public final class WLPublishTableFooterView: UIView {
    
    final let line: UIView = UIView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commitInit()
    }
    
    public func commitInit() {
        
        backgroundColor = .white
        
        addSubview(line)
        
        line.backgroundColor = WLHEXCOLOR(hexColor: "#f1f1f1")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
//        line.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 1)
    }
}
