//
//  WLCircle1TableViewCell.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/7.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseTableView

public protocol WLCircleBaseTableViewCellDelegate {
    
    func onMoreItemClick(_ cell: UITableViewCell ,item: WLCircleBean)
    
    func onWatchItemClick(_ cirleBean: WLCircleBean)
    
    func onCommentItemClick(_ cirleBean: WLCircleBean)
    
    func onFunItemClick(_ cirleBean: WLCircleBean)
}

open class WLCircleBaseTableViewCell: WLBaseTableViewCell {
    
    var mDelegate: WLCircleBaseTableViewCellDelegate!
    
    open var type: (WLCircleBean ,WLCircleConfig)!{
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            moreItem.setImage(UIImage(named: newValue.1.moreIcon), for: .normal)
        }
    }
    
    open var moreItem: UIButton = UIButton(type: .custom)
    
    open override func commitInit() {
        super.commitInit()
        
        contentView.addSubview(moreItem)
        
        moreItem.addTarget(self, action: #selector(onMoreItemClick), for: .touchUpInside)
    }
    @objc func onMoreItemClick() {
        
        guard let delegate = mDelegate,let type = type else { return }
        
        delegate.onMoreItemClick(self,item: type.0)
    }
}

