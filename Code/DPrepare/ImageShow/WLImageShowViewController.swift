//
//  WLImageShowViewController.swift
//  SPrepareDemo
//
//  Created by three stone 王 on 2019/6/6.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import WLToolsKit
import SnapKit

public final class WLImageShowViewController: WLBaseDisposeViewController {
    
    @objc public static func createImageShow(_ url: String ,back: String) -> Self {
        
        return self.init( url ,back: back)
    }
    @objc public var iconImageView: UIImageView = UIImageView().then {
        
        $0.contentMode = .scaleAspectFit
        
        $0.tag = 2001
    }
    
    var url: String = ""
    
    @objc func show(_ from: UIViewController) {
        
        from.present(self, animated: false, completion: nil)
    }
    @objc public required init(_ url: String ,back: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.url = url
        
        backIcon.setImage(UIImage(named: back), for: .normal)
        
        backIcon.setImage(UIImage(named: back), for: .highlighted)
        
    }
    
    public final let backIcon: UIButton = UIButton(type: .custom)
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func addOwnSubViews() {
        
        view.addSubview(iconImageView)
        
        view.addSubview(backIcon)
    }
    public override func configOwnSubViews() {
        
        let processor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 30)
        
        iconImageView.kf.indicatorType = .activity
        
        let icon: String = url
        
        self.iconImageView.kf.setImage(with: URL(string: icon), placeholder: UIImage.colorTransformToImage(color: WLHEXCOLOR(hexColor: "#f1f1f1")), options: [
            .processor(processor),
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(0.3)),
            .fromMemoryCacheOrRefresh
            ])
        
        iconImageView.snp.makeConstraints { (make) in
            
            make.left.right.bottom.top.equalToSuperview()
        }
        
        backIcon.snp.makeConstraints { (make) in
            
            make.left.equalTo(15)
            
            make.centerY.equalTo(WL_TOP_LAYOUT_GUARD - 22)
        }
        
        backIcon.sizeToFit()
        
        backIcon.addTarget(self, action: #selector(dismissToSuper), for: .touchUpInside)
    }
    public override func configOwnProperties() {
        
    }
    @objc func dismissToSuper() {
        
        dismiss(animated: false, completion: nil)
    }
}
