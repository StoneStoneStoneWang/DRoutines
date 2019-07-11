//
//  WLCircle1Empty.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseTableView
import WLToolsKit

public final class WLCircle1Empty: WLTableViewEmptyViewSource {
    public var emptyAText: NSAttributedString {
        let blackListStyle = NSMutableParagraphStyle()
        
        blackListStyle.alignment = .center
        
        return NSAttributedString(string: "暂无内容", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: WLHEXCOLOR(hexColor: "#666666") ,NSAttributedString.Key.paragraphStyle: blackListStyle])
    }
    
    public var emptyIcon: String { return ""}
    
    public var emptyIconFrame: CGRect { return .zero }
    
    public var emptyTextFrame: CGRect { return UIScreen.main.bounds }
    
    public var emptyFrame: CGRect { return UIScreen.main.bounds }
    
    public var canResponse: Bool { return true }
    
    public var emptyBackgroundHex: String { return "#f1f1f1"}
}