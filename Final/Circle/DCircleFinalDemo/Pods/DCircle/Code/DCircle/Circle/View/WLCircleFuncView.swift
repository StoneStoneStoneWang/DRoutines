//
//  WLCircleFuncView.swift
//  WLCircleKitDemo
//
//  Created by three stone 王 on 2019/5/23.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLToolsKit
import SnapKit

struct WLCircleFuncBean {
    
    let type: WLCircleFuncType
    
    let count: String
    
    let nIcon: String
    
    let sIcon: String
    
    let isSelected: Bool
}

enum WLCircleFuncType {
    case watch
    
    case comment
    
    case fun
}

class WLCircleFuncView: UICollectionView {
    
    var mDelegate: WLCircleFuncCellDelegate!
    
    public var funcItems: [WLCircleFuncBean] = []
    
    public static func circleFuncView() -> Self {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 10
        
        layout.minimumInteritemSpacing = 10
        
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        
        layout.itemSize = CGSize(width: 60, height: 30)
        
        return self.init(frame: .zero, collectionViewLayout: layout)
    }
    
    public var layout: UICollectionViewFlowLayout!
    
    public required override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.layout = layout as? UICollectionViewFlowLayout
        
        commitInit()
    }
    
    var type: (WLCircleBean ,WLCircleConfig)? {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            let watch = WLCircleFuncBean(type: .watch, count: "\(newValue.0.countComment)", nIcon: newValue.1.watchIcon, sIcon: newValue.1.watchIcon, isSelected: false)
            let comment = WLCircleFuncBean(type: .comment, count: "\(newValue.0.countComment)", nIcon: newValue.1.commentIcon, sIcon: newValue.1.commentIcon, isSelected: false)
            let fuc = WLCircleFuncBean(type: .fun, count: "\(newValue.0.countLaud)", nIcon: newValue.1.funNIcon, sIcon: newValue.1.funSIcon, isSelected: newValue.0.isLaud)
            
            funcItems.removeAll()
            
            funcItems += [watch,comment,fuc]
            
            reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc public func commitInit() {
        
        showsVerticalScrollIndicator = false
        
        showsHorizontalScrollIndicator = false
        
        bounces = false
        
        register(WLCircleFuncCell.self, forCellWithReuseIdentifier: "cell")
        
        dataSource = self
        
        delegate = self
        
        backgroundColor = .clear
        
    }
}
extension WLCircleFuncView: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return funcItems.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WLCircleFuncCell
        
        cell.funcBean = funcItems[indexPath.row]
        
        if let type = type {
            
            cell.selectedColor = type.1.itemColor
        }
        
        cell.mDelegate = self.mDelegate
        
        return cell
        
    }
}
extension WLCircleFuncView: UICollectionViewDelegate { }

protocol WLCircleFuncCellDelegate {
    
    func onWatchItemClick()
    
    func onCommentItemClick()
    
    func onFunItemClick()
}

public final class WLCircleFuncCell: UICollectionViewCell {
    
    var mDelegate: WLCircleFuncCellDelegate!
    
    public final let funcItem: UIButton = UIButton(type: .custom).then {
        
        $0.setTitleColor(WLHEXCOLOR(hexColor: "#999999"), for: .normal)
        
        $0.setTitleColor(WLHEXCOLOR(hexColor: "#666666"), for: .highlighted)
        
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    @objc public override init(frame: CGRect) {
        super.init(frame: frame)
        
        commitInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var funcBean: WLCircleFuncBean? {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            funcItem.setImage(UIImage(named: newValue.nIcon), for: .normal)
            
            funcItem.setImage(UIImage(named: newValue.sIcon), for: .highlighted)
            
            funcItem.setTitle("  \(newValue.count)", for: .normal)
            
            funcItem.setTitle("  \(newValue.count)", for: .highlighted)
            
            if newValue.type == .fun {
                
                funcItem.setTitle("  \(newValue.count)", for: .selected)
                
                funcItem.setImage(UIImage(named: newValue.sIcon), for: .selected)
                
                funcItem.isSelected = newValue.isSelected
            } else {
                
                funcItem.isSelected = false
            }
        }
    }
    
    var selectedColor: String = "" {
        
        willSet {
            
            funcItem.setTitleColor(WLHEXCOLOR(hexColor: newValue), for: .selected)
        }
    }
}

extension WLCircleFuncCell {
    
    public func commitInit() {
        
        addSubview(funcItem)
        
        funcItem.addTarget(self, action: #selector(onFuncItemClick), for: .touchUpInside)
    }
    @objc func onFuncItemClick() {
        
        guard let delegate = mDelegate ,let funcBean = funcBean else { return }
        
        switch funcBean.type {
        case .fun: delegate.onFunItemClick()
            
        case .comment: delegate.onCommentItemClick()
            
        case .watch: delegate.onWatchItemClick()
        }
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        funcItem.snp.makeConstraints { (make) in
            
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}
