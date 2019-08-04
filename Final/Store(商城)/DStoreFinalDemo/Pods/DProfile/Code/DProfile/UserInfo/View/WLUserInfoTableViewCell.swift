//
//  WLUserInfoTableViewCell.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseTableView
import WLToolsKit
import Kingfisher
import SnapKit

@objc (WLUserInfoTableViewCell)
public final class WLUserInfoTableViewCell: WLBaseTableViewCell {
    
    public var subtitleLabel: UILabel = UILabel().then {
        
        $0.tag = 2002
        
        $0.font = UIFont.systemFont(ofSize: 15)
        
        $0.textAlignment = .right
        
        $0.textColor = WLHEXCOLOR(hexColor: "#666666")
    }
    
    public var type: (WLUserInfoBean,WLUserInfoConfig)? {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            titleLabel.text = newValue.0.type.title
            
            accessoryType = .disclosureIndicator
            
            backgroundColor = .white
            
            accessoryType = newValue.0.type == .space ? .none : .disclosureIndicator
            
            backgroundColor = newValue.0.type == .space ? .clear : .white
            
            selectionStyle = newValue.0.type == .space ? .none : .default
            
            subtitleLabel.text = newValue.0.subtitle
            
            iconImageView.isHidden = true
            
            subtitleLabel.isHidden = true
            
            switch newValue.0.type {
            case .header:
                
                accessoryType = .none
                
                selectionStyle = .none
                
                iconImageView.isHidden = false
                
                let processor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 30)
                
                iconImageView.kf.indicatorType = .activity
                
                let icon = newValue.0.subtitle + "?x-oss-process=image/resize,w_500,h_500"
                
                iconImageView.contentMode = .scaleAspectFill
                
                iconImageView.kf.setImage(with: URL(string: icon), placeholder: UIImage(named: newValue.1.defaultIcon), options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.3)),
                    .forceRefresh
                    ])
                
                iconImageView.layer.borderColor = WLHEXCOLOR(hexColor: newValue.1.itemColor).cgColor
                
            case .phone:
                
                var phone = newValue.0.subtitle
                
                if !phone.isEmpty {
                    
                    phone = (phone as NSString).replacingCharacters(in: NSMakeRange(3, 4), with: "****")
                }
                
                subtitleLabel.text = phone
                
                subtitleLabel.isHidden = false
                
            case .name:
                
                var nickname = newValue.0.subtitle
                
                if String.validPhone(phone: nickname) {
                    
                    nickname = (nickname as NSString).replacingCharacters(in: NSMakeRange(3, 4), with: "****")
                }
                
                subtitleLabel.text = nickname
                
                subtitleLabel.isHidden = false
                
            case .birth:
                
                let birth = newValue.0.subtitle.components(separatedBy: " ")
                
                subtitleLabel.text = birth.first!
                
                subtitleLabel.isHidden = false
                
            case .space: break
            default:
                
                subtitleLabel.isHidden = false
            }
        }
    }
    
    override public func commitInit() {
        super.commitInit()
        
        iconImageView.layer.masksToBounds = true
        
        iconImageView.contentMode = .center
        
        iconImageView.layer.cornerRadius = 5
        
        iconImageView.layer.borderWidth = 1
        
        contentView.addSubview(subtitleLabel)
    }
}

extension WLUserInfoTableViewCell {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(15)
            
            make.centerY.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { (make) in
            
            make.right.equalTo(-15)
            
            make.centerY.equalToSuperview()
            
            make.left.equalTo(bounds.width / 2)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            
            make.right.equalTo(-15)
            
            make.centerY.equalToSuperview()
            
            make.width.height.equalTo(50)
        }
    }
}
