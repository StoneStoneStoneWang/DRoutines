//
//  WLCircleDetailScrollView.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit

public final class WLCircleDetailScrollView: UIScrollView {
    
    var contentVC: WLContentBaseViewController!
    
    var commentVC: WLCommentBaseViewController!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        commitInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commitInit() {
        
        showsVerticalScrollIndicator = false
        
        showsHorizontalScrollIndicator = false
        
        if let gestureRecognizers = gestureRecognizers {
            
            for item in gestureRecognizers {
                
                removeGestureRecognizer(item)
            }
        }
    }
    
//    func configSubviewController(_  from: UIViewController ,style: WLContentStyle ,config: WLContentConfig,style: WLCommentStyle ,config: WLCommentConfig ,uid: String,encoded: String,circleJson: [String : Any]) {
//        
//        contentVC = WLContentBaseViewController.createContent(.one, config: <#T##WLContentConfig#>, circleJson: circleJson)
//        
//        commentVC = WLCommentBaseViewController.createComment(<#T##style: WLCommentStyle##WLCommentStyle#>, config: <#T##WLCommentConfig#>, uid: <#T##String#>, encoded: <#T##String#>)
//        
//        from.addChild(contentVC)
//        
//        from.addChild(commentVC)
//    }
    
}
