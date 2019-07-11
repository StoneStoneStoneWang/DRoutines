//
//  WLCircle5TableViewCell.swift
//  WLCircleKitDemo
//
//  Created by three stone 王 on 2019/5/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import SnapKit
import Kingfisher
import WLToolsKit

public final class WLCircle5TableViewCell: WLCircleBaseTableViewCell {
    
    var funcView: WLCircleFuncView = WLCircleFuncView.circleFuncView()
    
    public override var type: (WLCircleBean, WLCircleConfig)! {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            let title = newValue.0.contentMap.first!
            
            titleLabel.text = title.value
            
            var media: WLPublishBean!
            
            for item in newValue.0.contentMap {
                
                if item.type == "image" {
                    
                    media = item
                    
                    break
                } else if item.type == "video"{
                    
                    media = item
                    
                    break
                }
            }
            
            if let media = media {
                
                var processor: ImageProcessor!
                
                if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
                    
                    if version > "1.1.0" {
                        
                        processor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 0)
                    } else {
                        
                        processor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 5)
                    }
                } else {
                    
                    processor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 5)
                }
                
                iconImageView.kf.indicatorType = .activity
                
                if media.type == "image" {
                    
                    let icon: String = media.value + "?x-oss-process=image/resize,w_1600,h_700"
                    
                    self.iconImageView.kf.setImage(with: URL(string: icon), placeholder: UIImage(named: newValue.1.defaultIcon), options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(0.3)),
                        .fromMemoryCacheOrRefresh
                        ])
                } else {
                    
                    let icon: String = media.value + "?x-oss-process=video/snapshot,t_7000,f_jpg,w_1600,h_700,m_fast"
                    
                    self.iconImageView.kf.setImage(with: URL(string: icon), placeholder: UIImage(named: newValue.1.defaultIcon), options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(0.3)),
                        .fromMemoryCacheOrRefresh
                        ])
                }
            }
            
            if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
                
                if version > "1.1.0" {
                    
                    funcView.isHidden = false
                    
                    funcView.type = newValue
                    
                    layer.masksToBounds = true
                    
                    subtitleLabel.text = newValue.0.users.nickname
                    
                    return
                }
            } else {
                
                funcView.isHidden = true
                
            }
            subtitleLabel.text = newValue.0.users.nickname + "    " + "评论:\(newValue.0.countComment)人" + "    " + "观看:\(newValue.0.countLaud)人"
        }
    }
    public final let subtitleLabel: UILabel = UILabel().then {
        
        $0.tag = 2003
        
        $0.font = UIFont.systemFont(ofSize: 12)
        
        $0.textAlignment = .left
        
        $0.textColor = WLHEXCOLOR(hexColor: "#666666")
        
        $0.numberOfLines = 2
    }
    public override func commitInit() {
        super.commitInit()
        
        iconImageView.layer.masksToBounds = true
        
        titleLabel.numberOfLines = 2
        
        contentView.addSubview(subtitleLabel)
        
        contentView.addSubview(funcView)
        
        funcView.mDelegate = self
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(15)
            
            make.top.equalTo(15)
            
            make.right.equalTo(-80)
        }
        
        moreItem.sizeToFit()
        
        moreItem.snp.makeConstraints { (make) in
            
            make.centerY.equalTo(titleLabel.snp.centerY)
            
            make.width.height.equalTo(30)
            
            make.right.equalTo(-15)
        }
        
        let w = bounds.width - 30
        
        let h = w * 7 / 16
        
        iconImageView.snp.makeConstraints { (make) in
            
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            
            make.right.equalTo(-15)
            
            make.left.equalTo(15)
            
            make.height.equalTo(h)
        }
        
        if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
            
            if version > "1.1.0" {
                
                subtitleLabel.snp.makeConstraints { (make) in
                    
                    make.left.equalTo(15)
                    
                    make.height.equalTo(20)
                    
                    make.top.equalTo(iconImageView.snp.bottom).offset(5)
                }
                
                funcView.snp.makeConstraints { (make) in
                    
                    make.centerY.equalTo(subtitleLabel.snp.centerY)
                    
                    make.right.equalTo(-15)
                    
                    make.height.equalTo(40)
                    
                    make.width.equalTo(200)
                }
                return
            }
        }
        
        subtitleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(15)
            
            make.height.equalTo(20)
            
            make.top.equalTo(iconImageView.snp.bottom).offset(5)
        }
    }
}
extension WLCircle5TableViewCell: WLCircleFuncCellDelegate {
    func onWatchItemClick() {
        
        guard let delegate = mDelegate else { return }
        
        delegate.onWatchItemClick(type.0)
    }
    
    func onCommentItemClick() {
        
        guard let delegate = mDelegate else { return }
        
        delegate.onCommentItemClick(type.0)
    }
    
    func onFunItemClick() {
        
        guard let delegate = mDelegate else { return }
        
        delegate.onFunItemClick(type.0)
    }
}
