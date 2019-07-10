//
//  WLProfile3HeaderView.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/24.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Kingfisher
import WLToolsKit
import WLBaseTableView
import SnapKit
import DPrepare

@objc (WLProfile3HeaderView)
public final class WLProfile3HeaderView: WLProfileHeaderView {
    
    public final let backgroundImageView: UIImageView = UIImageView()
    
    lazy var effectView: UIVisualEffectView = {
        
        let blur = UIBlurEffect(style: .dark)
        
        let res = UIVisualEffectView(effect: blur)
        
        return res
    }()
    
    public override var user: WLUserBean? {
        
        willSet {
            
            guard let newValue = newValue else { return  }
            
            nameLabel.textColor = WLHEXCOLOR(hexColor: WLProfileConfigManager.default.config.itemColor)
            
            if WLAccountCache.default.isLogin() {
                
                var nickname = newValue.nickname
                
                if String.validPhone(phone: nickname) {
                    
                    nickname = (nickname as NSString).replacingCharacters(in: NSMakeRange(3, 4), with: "****")
                }
                
                nameLabel.text = nickname
                
                let processor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 30)
                
                iconImageView.kf.indicatorType = .activity
                
                if newValue.headImg.isEmpty {
                    
                    self.iconImageView.image = UIImage(named: WLProfileConfigManager.default.config.defaultIcon)
                    
                } else {
                    
                    let icon: String = newValue.headImg + "?x-oss-process=image/resize,w_1600,h_800"
                    
                    iconImageView.kf.setImage(with: URL(string: icon), placeholder: UIImage(named: WLProfileConfigManager.default.config.defaultIcon), options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(0.3)),
                        .forceRefresh
                        ])
                    
                    backgroundImageView.kf.setImage(with: URL(string: icon), placeholder: UIImage.colorTransformToImage(color: WLHEXCOLOR(hexColor: "#e1e1e1")), options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(0.3)),
                        .forceRefresh
                        ])
                }
                
            } else {
                
                newValue.nickname = "未登录"
                
                iconImageView.image = UIImage(named: WLProfileConfigManager.default.config.defaultIcon)
                
                nameLabel.text = newValue.nickname
                
                backgroundImageView.image = UIImage.colorTransformToImage(color: WLHEXCOLOR(hexColor: "#e1e1e1"))
                
            }
            
            iconImageView.layer.borderColor = WLHEXCOLOR(hexColor: WLProfileConfigManager.default.config.itemColor).cgColor
        }
    }
    
    public override var style: WLProfileStyle! {
        
        willSet {
            
            nameLabel.textAlignment = .center
            
            setNeedsDisplay()
        }
    }
}

extension WLProfile3HeaderView {
    
    override public func commitInit() {
        
        contentView.addSubview(backgroundImageView)
        
        backgroundImageView.addSubview(effectView)
        
        backgroundImageView.contentMode = .scaleAspectFill
        
        backgroundImageView.layer.masksToBounds = true
        
        super.commitInit()
        

    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        topLine.snp.makeConstraints { (make) in
            
            make.left.top.right.equalToSuperview()
            
            make.height.equalTo(1)
        }
        
        iconImageView.snp.remakeConstraints { (make) in
            
            make.left.equalTo(15)
            
            make.centerY.equalToSuperview()
            
            make.width.equalTo(70)
            
            make.height.equalTo(70)
        }
        
        nameLabel.snp.remakeConstraints { (make) in
            
            make.left.equalTo(iconImageView.snp.right).offset(15)
            
            make.right.equalTo(0)
            
            make.centerY.equalToSuperview()
        }
        
        backgroundImageView.frame = bounds
        
        effectView.frame = bounds
    }
    
}
