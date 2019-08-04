//
//  WLBlackListTableViewCell.swift
//  HZTC
//
//  Created by three stone 王 on 2019/3/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseTableView
import WLToolsKit
import Kingfisher
import SnapKit
@objc (WLBlackList1TableViewCell)
public final class WLBlackList1TableViewCell: WLBlackListBaseTableViewCell {
    
    public final var subtitleLabel: UILabel = UILabel().then {
        
        $0.tag = 2003
        
        $0.font = UIFont.systemFont(ofSize: 15)
        
        $0.textAlignment = .right
        
        $0.textColor = WLHEXCOLOR(hexColor: "#666666")
    }
    
    override public var type: (WLBlackListBean ,WLBlackListConfig)! {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            printLog(message: newValue)
            
            titleLabel.text = newValue.0.users.nickname
            
            let processor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 30)
            
            iconImageView.kf.indicatorType = .activity
            
            let icon = newValue.0.users.headImg + "?x-oss-process=image/resize,w_200,h_200"
            
            iconImageView.kf.setImage(with: URL(string: icon), placeholder: UIImage(named: newValue.1.defaultIcon), options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.3)),
                .fromMemoryCacheOrRefresh
                ])
            
            iconImageView.layer.borderColor = WLHEXCOLOR(hexColor: newValue.1.itemColor).cgColor
        }
    }
    
    override public func commitInit() {
        super.commitInit()
        
        iconImageView.layer.masksToBounds = true
        
        iconImageView.isUserInteractionEnabled = true
        
        iconImageView.contentMode = .center
        
        iconImageView.layer.cornerRadius = 25
        
        iconImageView.layer.borderWidth = 1
        
        contentView.addSubview(subtitleLabel)
        
    }
}

extension WLBlackList1TableViewCell {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        subtitleLabel.snp.makeConstraints { (make) in
            
            make.right.equalTo(-15)
            
            make.centerY.equalToSuperview()
            
            make.left.equalTo(bounds.width / 2)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            
            make.left.equalTo(15)
            
            make.centerY.equalToSuperview()
            
            make.width.height.equalTo(50)
        }
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(iconImageView.snp.right).offset(15)
            
            make.centerY.equalToSuperview()
        }
    }
}
