//
//  WLMapFooterView.swift
//  WLMapkitDemo
//
//  Created by three stone 王 on 2019/5/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLToolsKit

public final class WLMapFooterView: UIView {
    
    final let completeItem: UIButton = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commitInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var config: WLMapConfig! {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            completeItem.setTitleColor(.white, for: .normal)
            
            completeItem.setTitleColor(.white, for: .highlighted)
            
            completeItem.setTitle(newValue.itemTitle, for: .normal)
            
            completeItem.setTitle(newValue.itemTitle, for: .highlighted)
            
            completeItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR(hexColor: newValue.itemColor)), for: .normal)
            
            completeItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR_ALPHA(hexColor: newValue.itemColor + "60")), for: .highlighted)
        }
    }
}

extension WLMapFooterView {
    
    func commitInit() {
        
        addSubview(completeItem)
        
        backgroundColor = .white
        
        completeItem.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        completeItem.layer.cornerRadius = 22
        
        completeItem.layer.masksToBounds = true
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        completeItem.snp.remakeConstraints { (make) in
            
            make.center.equalToSuperview()
            
            make.height.equalTo(44)
            
            make.width.equalTo(bounds.width - 30)
        }
    }
}
