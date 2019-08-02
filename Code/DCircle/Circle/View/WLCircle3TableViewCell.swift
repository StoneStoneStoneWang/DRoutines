//
//  WLCircle3TableViewCell.swift
//  WLCircleKitDemo
//
//  Created by three stone 王 on 2019/5/14.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import SnapKit
import Kingfisher
import WLToolsKit

public final class WLCircle3TableViewCell: WLCircleBaseTableViewCell {
    
    var funcView: WLCircleFuncView = WLCircleFuncView.circleFuncView()
    
    var topLine: UIView = UIView(frame: .zero).then {
        
        $0.backgroundColor = WLHEXCOLOR(hexColor: "#eeeeee")
    }
    var cover: UIImageView = UIImageView(frame: .zero).then {
        
        $0.backgroundColor = .black
        
        $0.alpha = 0.5
    }
    var timeLabel: UILabel = UILabel(frame: .zero).then {
        
        $0.backgroundColor = .clear
        
        $0.font = UIFont.systemFont(ofSize: 10)
        
        $0.textAlignment = .right
    }
    public override var type: (WLCircleBean, WLCircleConfig)! {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            let title = newValue.0.contentMap.first!
            
            titleLabel.text = title.value
            
            var subTitle: WLPublishBean!
            
            for item in newValue.0.contentMap {
                
                if item.type == "txt" {
                    
                    subTitle = item
                    
                    break
                }
            }
            
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
            
            if let subTitle = subTitle {
                
                subtitleLabel.text = subTitle.value
            } else {
                
                subtitleLabel.text = title.value
            }
            
            if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
                
                if version > "1.1.0" {
                    
                    funcView.isHidden = false
                    
                    funcView.type = newValue
                    
                    topLine.isHidden = false
                }
            } else {
                
                funcView.isHidden = true
                
                topLine.isHidden = true
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
                
                cover.isHidden = true
                
                timeLabel.isHidden = true
                
                if media.type == "image" {
                    
                    let icon: String = media.value + "?x-oss-process=image/resize,w_500,h_500"
                    
                    self.iconImageView.kf.setImage(with: URL(string: icon), placeholder: UIImage(named: newValue.1.defaultIcon), options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(0.3)),
                        .fromMemoryCacheOrRefresh
                        ])
                } else {
                    
                    let icon: String = media.value + "?x-oss-process=video/snapshot,t_7000,f_jpg,w_500,h_500,m_fast"
                    
                    self.iconImageView.kf.setImage(with: URL(string: icon), placeholder: UIImage(named: newValue.1.defaultIcon), options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(0.3)),
                        .fromMemoryCacheOrRefresh
                        ])
                    
                    cover.isHidden = false
                    
                    timeLabel.isHidden = false
                    
                    DispatchQueue.global().async {
                        
                        self.timeLabel.text = self.fetchVideoTime(media.value)
                        
                    }
                }
            }
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
        
        contentView.addSubview(topLine)
        
        contentView.addSubview(cover)
        
        contentView.addSubview(timeLabel)
        
        funcView.mDelegate = self
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
            
            if version > "1.1.0" {
                
                let h = bounds.height - 30 - 40
                
                let w = h
                
                iconImageView.snp.makeConstraints { (make) in
                    
                    make.top.equalTo(15)
                    
                    make.right.equalTo(-15)
                    
                    make.width.equalTo(w)
                    
                    make.height.equalTo(h)
                }
                cover.snp.makeConstraints { (make) in
                    
                    make.left.top.equalTo(15)
                    
                    make.bottom.equalTo(-15)
                    
                    make.width.equalTo(w)
                }
                
                timeLabel.snp.makeConstraints { (make) in
                    
                    make.right.equalTo(cover.snp.right).offset(-5)
                    
                    make.bottom.equalTo(cover.snp.bottom).offset(-15)
                }
                titleLabel.snp.makeConstraints { (make) in
                    
                    make.left.equalTo(15)
                    
                    make.top.equalTo(iconImageView.snp.top)
                    
                    make.right.equalTo(iconImageView.snp.left).offset(-15)
                }
                
                subtitleLabel.snp.makeConstraints { (make) in
                    
                    make.left.equalTo(15)
                    
                    make.bottom.equalTo(iconImageView.snp.bottom)
                    
                    make.right.equalTo(iconImageView.snp.left).offset(-15)
                }
                topLine.snp.makeConstraints { (make) in
                    
                    make.left.right.equalTo(0)
                    
                    make.bottom.equalTo(funcView.snp.top)
                    
                    make.height.equalTo(1)
                }
                
                funcView.snp.makeConstraints { (make) in
                    
                    make.left.equalTo(15)
                    
                    make.bottom.equalTo(0)
                    
                    make.height.equalTo(40)
                    
                    make.width.equalTo(200)
                }
                
                moreItem.sizeToFit()
                
                moreItem.snp.makeConstraints { (make) in
                    
                    make.right.equalTo(-15)
                    
                    make.width.height.equalTo(30)
                    
                    make.centerY.equalTo(funcView.snp.centerY)
                }
                
                
                return
            }
        }
        
        let h = bounds.height - 30
        
        let w = h
        
        iconImageView.snp.makeConstraints { (make) in
            
            make.top.equalTo(15)
            
            make.bottom.right.equalTo(-15)
            
            make.width.equalTo(w)
        }
        cover.snp.makeConstraints { (make) in
            
            make.left.top.equalTo(15)
            
            make.bottom.equalTo(-15)
            
            make.width.equalTo(w)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            
            make.right.equalTo(cover.snp.right).offset(-5)
            
            make.bottom.equalTo(cover.snp.bottom).offset(-15)
        }
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(15)
            
            make.top.equalTo(iconImageView.snp.top)
            
            make.right.equalTo(iconImageView.snp.left).offset(-15)
        }
        
        moreItem.sizeToFit()
        
        moreItem.snp.makeConstraints { (make) in
            
            make.right.equalTo(iconImageView.snp.left).offset(-15)
            
            make.width.height.equalTo(30)
            
            make.bottom.equalTo(iconImageView.snp.bottom).offset(3)
        }
        
        subtitleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(15)
            
            make.bottom.equalTo(iconImageView.snp.bottom)
            
            make.right.equalTo(moreItem.snp.left).offset(-15)
        }
    }
}
extension WLCircle3TableViewCell: WLCircleFuncCellDelegate {
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
