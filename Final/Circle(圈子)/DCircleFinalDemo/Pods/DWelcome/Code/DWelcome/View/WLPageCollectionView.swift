//
//  WLPageCollectionView.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import UIKit

open class WLPageCollectionView: UICollectionView {
    
    public static func pageCollection(_ size: CGSize) -> Self {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        
        layout.sectionInset = .zero
        
        layout.itemSize = size
        
        layout.minimumLineSpacing = 0
        
        layout.minimumInteritemSpacing = 0
        
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
extension WLPageCollectionView {
    
    func commitInit() {
        
        showsVerticalScrollIndicator = false
        
        showsHorizontalScrollIndicator = false
        
        backgroundColor = .white
        
        bounces = false
        
        isPagingEnabled = true
        
    }
}
