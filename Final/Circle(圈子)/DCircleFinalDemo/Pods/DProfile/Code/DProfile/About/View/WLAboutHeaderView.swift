//
//  WLAboutHeaderView.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit
import SnapKit

@objc (WLAboutHeaderView)
public final class WLAboutHeaderView: UIView {
    
    final var iconImageView: UIImageView = UIImageView().then {
        
        $0.layer.cornerRadius = 5
        
        $0.layer.masksToBounds = true
        
        $0.layer.borderWidth = 1
    }
    
    final let topLine: UIView = UIView().then {
        
        $0.backgroundColor = WLHEXCOLOR(hexColor: "#f1f1f1")
    }
    
    final let versionLabel: UILabel = UILabel().then {
        
        $0.textAlignment = .center
        
        $0.font = UIFont.systemFont(ofSize: 15)
        
        $0.text = "当前版本: \(Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String)"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commitInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var config: WLAboutConfig! {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            iconImageView.layer.borderColor = WLHEXCOLOR(hexColor: newValue.itemColor).cgColor
            
            iconImageView.image = UIImage(named: newValue.logo)
            
            versionLabel.textColor = WLHEXCOLOR(hexColor: newValue.itemColor)

        }
    }
}
extension WLAboutHeaderView {
    
    func commitInit() {
        
        addSubview(topLine)
        
        addSubview(iconImageView)
        
        addSubview(versionLabel)
        
        backgroundColor = .white
        
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        topLine.snp.makeConstraints { (make) in
            
            make.left.top.right.equalToSuperview()
            
            make.height.equalTo(1)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            
            make.centerX.equalToSuperview()
            
            make.width.equalTo(70)
            
            make.height.equalTo(70)
            
            make.top.equalTo(15)
        }
        
        versionLabel.snp.remakeConstraints { (make) in
            
            make.centerY.equalTo(85 + (bounds.height - 85) / 2)
            
            make.centerX.equalToSuperview()
        }
    }
}
