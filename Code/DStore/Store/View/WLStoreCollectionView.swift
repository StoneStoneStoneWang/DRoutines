//
//  WLStoreCollectionView.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLToolsKit
import MJRefresh

class WLStoreLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        
        scrollDirection = .vertical
        
        sectionInset = UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
        
        let w = (WL_SCREEN_WIDTH - 5) / 2
        
        minimumInteritemSpacing = 1
        minimumLineSpacing = 1
        
        itemSize = CGSize(width: w, height: w + 65)
        
        super.prepare()
    }
}

public class WLStoreCollectionView: UICollectionView {
    
    public static func createStore() -> Self {
        
        let layout = WLStoreLayout()
        
        return self.init(frame: .zero ,collectionViewLayout: layout)
    }
    
    required override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        commitInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WLStoreCollectionView {
    
    func commitInit() {
        
        showsVerticalScrollIndicator = false
        
        showsHorizontalScrollIndicator = false
        
        backgroundColor = .clear
        
        bounces = true
        
        let mj_header = MJRefreshNormalHeader()
        
        self.mj_header = mj_header
        
        mj_header.lastUpdatedTimeLabel.isHidden = true
        
        //初始化数据
        let mj_footer = MJRefreshBackNormalFooter()
        
        self.mj_footer = mj_footer
    }
}
