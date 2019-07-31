//
//  WLItemView.swift
//  HOwner-iOS
//
//  Created by three stone 王 on 2019/6/13.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLToolsKit

public let asmargin: CGFloat = 15

public let sasmargin: CGFloat = 30

open class WLItemView: UICollectionView {
    
    public static func createItem(_ itemSize: CGSize ,col: Int ,total: Int) -> Self {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        
        layout.sectionInset = UIEdgeInsets(top: col == 4 ? asmargin : 0, left: col == 4 ? asmargin : sasmargin, bottom: col == 4 ? 0 : 15, right: col == 4 ? asmargin : sasmargin)
        
        layout.itemSize = itemSize
        
        layout.minimumLineSpacing = 1
        
        let space = (WL_SCREEN_WIDTH - (col == 4 ? asmargin : sasmargin) * 2 - CGFloat(col) * itemSize.width) / CGFloat(col - 1)
        
        layout.minimumLineSpacing = space
        
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

extension WLItemView {
    
    func commitInit() {
        
        showsVerticalScrollIndicator = false
        
        showsHorizontalScrollIndicator = false
        
        backgroundColor = .white
        
        bounces = false
        
        isPagingEnabled = true
        
    }
}


