//
//  WLReportFooterView.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit

public final class WLReportFooterView: UIView {
    
    final let texttv: UITextView = UITextView(frame: .zero).then {
        
        $0.font = UIFont.systemFont(ofSize: 15)
        
        $0.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        commitInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commitInit() {
        
        addSubview(texttv)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        texttv.frame = CGRect(x: 0, y: 10, width: bounds.width, height: bounds.height - 10)
    }
}
