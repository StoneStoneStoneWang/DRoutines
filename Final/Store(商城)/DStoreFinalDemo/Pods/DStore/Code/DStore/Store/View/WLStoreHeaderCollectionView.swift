//
//  WLStoreHeaderCollectionView.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit

let WL_Store_Width: CGFloat = 60

let WL_Store_Height: CGFloat = 44

class WLStoreHeaderLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        
        scrollDirection = .horizontal
        minimumLineSpacing = 0.01
        sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        itemSize = CGSize(width: WL_Store_Width, height: WL_Store_Height)
        super.prepare()
    }
}

class WLStoreHeaderCollectionView: UICollectionView {
    
    public static func createStoreHeader() -> Self {
        
        let layout = WLStoreHeaderLayout()
        
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

extension WLStoreHeaderCollectionView {
    
    func commitInit() {
        
        showsVerticalScrollIndicator = false
        
        showsHorizontalScrollIndicator = false
        
        backgroundColor = .white
        
        bounces = false
        
    }
}
