//
//  WLStoreViewController.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import UIKit

class WLStoreViewController: WLStoreBaseViewController {
    
    override func configOwnSubViews() {
        super.configOwnSubViews()
        
        collectionView.register(WLStoreCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    override func configCell(_ cv: UICollectionView, ip: IndexPath, item: WLCommodityBean) -> UICollectionViewCell {
        
        let cell = cv.dequeueReusableCell(withReuseIdentifier: "cell", for: ip) as! WLStoreCollectionViewCell
        
        cell.commodity = item
        
        return cell
    }
}
