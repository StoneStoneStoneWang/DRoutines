//
//  WLPublishTableViewCell.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/6.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseTableView
import SnapKit

public class WLPublishImageTableViewCell: WLBaseTableViewCell {
    
    var img: UIImage? {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            iconImageView.image = newValue
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let h = bounds.height - 30
        
        let w = h * 4 / 3
        
        iconImageView.snp.remakeConstraints { (make) in
            
            make.left.top.equalTo(15)
            
            make.bottom.equalTo(-15)
            
            make.width.equalTo(w)
        }
    }
    
    public override func commitInit() {
        super.commitInit()
        
        iconImageView.layer.masksToBounds = true
    }
}

public class WLPublishTextTableViewCell: WLBaseTableViewCell {
    
    var eText: String = "" {
        
        willSet {
            
            guard !newValue.isEmpty else { return }
            
            titleLabel.text = newValue
        }
    }
    
    public override func commitInit() {
        super.commitInit()
        
        titleLabel.textAlignment = .left
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(15)
            
            make.right.equalTo(-15)
            
            make.centerY.equalToSuperview()
        }
    }
}

public class WLPublishVideoTableViewCell: WLBaseTableViewCell {
    
    var broadItem: UIButton = UIButton(type: .custom)
    
    var img: UIImage? {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            iconImageView.image = newValue
        }
    }
    
    //    var config:
    
    public override func commitInit() {
        super.commitInit()
        
        contentView.addSubview(broadItem)
        
        iconImageView.layer.masksToBounds = true
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let h = bounds.height - 30
        
        let w = h * 4 / 3
        
        iconImageView.snp.remakeConstraints { (make) in
            
            make.left.top.equalTo(15)
            
            make.bottom.equalTo(-15)
            
            make.width.equalTo(w)
        }
        
        broadItem.snp.remakeConstraints { (make) in
            
            make.center.equalTo(iconImageView.snp.center)
        }
    }
}
