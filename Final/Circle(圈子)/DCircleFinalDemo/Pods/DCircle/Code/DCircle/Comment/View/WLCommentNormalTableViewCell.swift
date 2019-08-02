//
//  WLCommentNormalTableViewCell.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit
import SnapKit
import Kingfisher
import WLBaseTableView

protocol WLCommentNormalTableViewCellDelegate {
    
    func onMoreItemClick()
}

open class WLCommentNormalTableViewCell: WLCommentTableViewCell {
    
    open var moreItem: UIButton = UIButton(type: .custom)
    
    public final var subtitleLabel: UILabel = UILabel().then {
        
        $0.tag = 2003
        
        $0.font = UIFont.systemFont(ofSize: 15)
        
        $0.textAlignment = .right
        
        $0.textColor = WLHEXCOLOR(hexColor: "#666666")
    }
    
    public final var contentLabel: UILabel = UILabel().then {
        
        $0.tag = 2004
        
        $0.font = UIFont.systemFont(ofSize: 15)
        
        $0.textAlignment = .left
        
        $0.textColor = WLHEXCOLOR(hexColor: "#666666")
    }
    override var type: (WLCommentBean, WLCommentConfig)? {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            moreItem.setImage(UIImage(named: newValue.1.moreIcon), for: .normal)
            
            titleLabel.text = newValue.0.users.nickname
            
            let res = newValue.0.intime.components(separatedBy: ".")
            
            subtitleLabel.text = res.first!
            
            let processor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 30)
            
            iconImageView.kf.indicatorType = .activity
            
            let icon = newValue.0.users.headImg + "?x-oss-process=image/resize,w_200,h_200"
            
            iconImageView.kf.setImage(with: URL(string: icon), placeholder: UIImage(named: ""), options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.3)),
                .fromMemoryCacheOrRefresh
                ])
            
            contentLabel.text = newValue.0.content
        }
    }
    override open func commitInit() {
        super.commitInit()
        
        iconImageView.layer.masksToBounds = true
        
        iconImageView.isUserInteractionEnabled = true
        
        iconImageView.contentMode = .center
        
        iconImageView.layer.cornerRadius = 15
        
        iconImageView.layer.borderWidth = 1
        
        contentView.addSubview(subtitleLabel)
        
        contentView.addSubview(contentLabel)
        
        contentView.addSubview(moreItem)
        
        moreItem.addTarget(self, action: #selector(onMoreItemClick), for: .touchUpInside)
    }
    
    var mDelegate: WLCommentNormalTableViewCellDelegate!
    
    @objc func onMoreItemClick() {
        
        guard let delegate = mDelegate else { return }
        
        delegate.onMoreItemClick()
    }
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        iconImageView.snp.makeConstraints { (make) in
            
            make.left.equalTo(15)
            
            make.top.equalTo(15)
            
            make.width.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(iconImageView.snp.right).offset(15)
            
            make.bottom.equalTo(iconImageView.snp.centerY)
        }
        
        subtitleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(iconImageView.snp.right).offset(15)
            
            make.top.equalTo(iconImageView.snp.centerY)
        }
        
        moreItem.sizeToFit()
        
        moreItem.snp.makeConstraints { (make) in
            
            make.right.equalTo(-15)
            
            make.width.height.equalTo(30)
            
            make.centerY.equalTo(iconImageView.snp.centerY)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(iconImageView.snp.right).offset(15)
            
            make.top.equalTo(iconImageView.snp.bottom).offset(10)
            
            make.right.equalTo(moreItem.snp.left).offset(-15)
        }
        
    }
}
