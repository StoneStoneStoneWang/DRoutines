//
//  WLBannerBaseViewController.swift
//  DBannerDemo
//
//  Created by three stone 王 on 2019/7/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DPrepare
import WLBaseTableView
import RxDataSources
import WLToolsKit
import RxSwift

@objc (WLBannerBaseViewController)
open class WLBannerBaseViewController: WLBaseDisposeViewController {
    
    var banners: [String] = []
    
    var style: WLBannerStyle = .one
    
    public required init(_ banners: [String] ,style: WLBannerStyle) {
        
        self.style = style
        
        super.init(nibName: nil, bundle: nil)
        
        self.banners += banners
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel: WLBannerViewModel!
    
    typealias Section = WLSectionModel<(), String>
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<Section>!
    
    public lazy var collectionView: WLBannerView = {
        
        switch style {
        case .one:
            
            let layout = WLBannerViewLayout()
            
            return WLBannerView.banner(layout)
        default:
            
            let layout = WLBannerViewLayout()
            
            return WLBannerView.banner(layout)
        }
    }()
    
    override open func addOwnSubViews() {
        
        view.addSubview(collectionView)
    }
    
    override open func configOwnSubViews() {
        
        collectionView.frame = CGRect(x: 0, y: 0, width: WL_SCREEN_WIDTH, height: WL_SCREEN_WIDTH / 2)
        
        collectionView.register(WLBannerImageView.self, forCellWithReuseIdentifier: "cell")
    }
    
}
extension WLBannerBaseViewController {
    
    override open func configViewModel() {
        
        if banners.count > 1 {
            
            let temp = banners
            
            for _ in 0..<999 {
                
                banners += temp
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                
                self.collectionView.selectItem(at: IndexPath(item: self.banners.count / 2, section:0), animated: false, scrollPosition: .centeredHorizontally)
                
            }
            
        }
        
        let input = WLBannerViewModel.WLInput(contentoffSetX: collectionView.rx.contentOffset.map({ $0.x }),
                                              banners:  banners,
                                              modelSelect: collectionView.rx.modelSelected(String.self),
                                              itemSelect: collectionView.rx.itemSelected)
        
        viewModel = WLBannerViewModel(input, disposed: disposed)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<Section>(
            configureCell: { ds, cv, ip, item in
                
                let cell = cv.dequeueReusableCell(withReuseIdentifier: "cell", for: ip) as! WLBannerImageView
                
                cell.banner = item
                
                return cell
        })
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .tableData
            .asObservable()
            .map({ [Section(model: (), items: $0)] })
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { [weak self] (banner,ip) in
                
                guard let `self` = self else { return }
                
            })
            .disposed(by: disposed)
        
        viewModel
            .output
            .timered
            .subscribe(onNext: { [unowned self] (index) in
                
                self.collectionView.selectItem(at: IndexPath(item: index, section:0), animated: true, scrollPosition: .centeredHorizontally)
            })
            .disposed(by: disposed)
    }
}
