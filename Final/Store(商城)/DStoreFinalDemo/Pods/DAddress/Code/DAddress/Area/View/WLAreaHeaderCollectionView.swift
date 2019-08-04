//
//  WLAreaNaviCollectionView.swift
//  DAddressDemo
//
//  Created by three stone 王 on 2019/7/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit

let WL_Area_Width: CGFloat = 80

let WL_Area_Height: CGFloat = 44

class WLAreaHeaderLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        
        scrollDirection = .horizontal
        minimumLineSpacing = 0.01
        sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        itemSize = CGSize(width: WL_Area_Width, height: WL_Area_Height)
        super.prepare()
    }
}

class WLAreaHeaderCollectionView: UICollectionView {
    
    public static func createAreaHeader() -> Self {
        
        let layout = WLAreaHeaderLayout()
        
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

extension WLAreaHeaderCollectionView {
    
    func commitInit() {
        
        showsVerticalScrollIndicator = false
        
        showsHorizontalScrollIndicator = false
        
        backgroundColor = .white
        
        bounces = false
        
    }
}
