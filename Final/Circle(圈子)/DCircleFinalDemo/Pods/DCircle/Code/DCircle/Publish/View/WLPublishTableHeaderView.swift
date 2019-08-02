//
//  WLPublishTableHeaderView.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/6.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLComponentView
import SnapKit
public final class WLPublishTableHeaderView: UIView {
    
    public var tf: WLNickNameTextField = WLNickNameTextField(frame: .zero).then {
        
        $0.placeholder = "请输入标题"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commitInit()
    }
    
    public func commitInit() {
        
        addSubview(tf)
        
        backgroundColor = .clear
        
        tf.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WLPublishTableHeaderView {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    
        tf.snp.makeConstraints { (make) in
            
            make.left.right.equalToSuperview()
            make.top.equalTo(1)
            make.bottom.equalTo(-1)
        }
    }
}
