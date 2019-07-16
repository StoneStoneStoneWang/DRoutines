//
//  WLWLBubbleView.swift
//  WLMapkitDemo
//
//  Created by three stone 王 on 2019/5/28.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit
import SnapKit

class WLBubbleView: UIView {
    
    var iconImageView: UIImageView = UIImageView(frame: .zero)
    
    var label: UILabel = UILabel().then {
        
        $0.backgroundColor = .white
        
        $0.numberOfLines = 3
        
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    var whiteView: UIView = UIView().then {
        
        $0.backgroundColor = .white
        
        $0.layer.cornerRadius = 2
        
        $0.layer.masksToBounds = true
        
        $0.layer.borderWidth = 1
        
        $0.layer.borderColor = WLHEXCOLOR(hexColor: "#e1e1e1").cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addOwnSubviews()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension WLBubbleView {
    
    func addOwnSubviews() {
        
        addSubview(iconImageView)
        
        addSubview(whiteView)
        
        addSubview(label)
    }
    public func updateViewData(data: AnyObject) {
        
        let text = data as! String
        
        label.text = text
    }
}
extension WLBubbleView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImageView.snp.makeConstraints { (make) in
            
            make.top.equalTo(bounds.height - 2)
            
            make.centerX.equalTo(bounds.width / 2)
            
            make.width.equalTo(22)
            
            make.height.equalTo(12)
        }
        whiteView.snp.makeConstraints { (make) in
            
            make.left.right.top.equalToSuperview()
            
            make.bottom.equalTo(-12)
        }
        
        label.snp.makeConstraints { (make) in
            
            make.left.equalTo(10)
            
            make.right.equalTo(-10)
            
            make.top.equalTo(5)
        }
    }
}
