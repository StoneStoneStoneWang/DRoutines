//
//  WLWelComeBaseViewController.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseTableView
import RxDataSources
import WLToolsKit
import RxSwift
import DPrepare
import DNotification

@objc (WLWelComeBaseViewController)
open class WLWelComeBaseViewController: WLBaseDisposeViewController {
    
    public var config: WLWelComeConfig!
    
    public var style: WLWelcomeStyle = .one
    
    public required init(_ style: WLWelcomeStyle,config: WLWelComeConfig) {
        super.init(nibName: nil, bundle: nil)
        
        self.config = config
        
        self.style = style
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel: WLWelcomViewModel!
    
    typealias Section = WLSectionModel<(), String>
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<Section>!
    
    public final let collectionView: WLPageCollectionView = WLPageCollectionView.pageCollection(WL_SCREEN_SIZE)
    
    public final let skipItem: UIButton = UIButton(type: .custom)
    
    public final let pageControl: UIPageControl = UIPageControl(frame: .zero).then {
        
        $0.currentPage = 0
    }
    
    override open func addOwnSubViews() {
        
        view.addSubview(collectionView)
        
        view.addSubview(pageControl)
        
        view.addSubview(skipItem)
    }
    
    override open func configOwnSubViews() {
        collectionView.snp.makeConstraints { (make) in
            
            make.left.right.top.bottom.equalToSuperview()
        }
        
        collectionView.register(WLPageCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        pageControl.snp.makeConstraints { (make) in
            
            make.left.right.equalToSuperview()
            
            make.height.equalTo(20)
            
            make.bottom.equalTo(-60)
        }
        
        if let config = config {
            
            pageControl.pageIndicatorTintColor = WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)50")
            
            pageControl.currentPageIndicatorTintColor = WLHEXCOLOR(hexColor: config.itemColor)
        }
    }
}

extension WLWelComeBaseViewController {
    
    override open func configViewModel() {
        
        let input = WLWelcomViewModel.WLInput(contentoffSetX: collectionView.rx.contentOffset.map({ $0.x }),
                                              skipTap: skipItem.rx.tap.asSignal(),
                                              style: Observable<WLWelcomeStyle>.just(style),
                                              welcomeImgs: config == nil ? [] : config.welcomeImgs )
        
        viewModel = WLWelcomViewModel(input, disposed: disposed)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<Section>(
            configureCell: { ds, cv, ip, item in
                
                let cell = cv.dequeueReusableCell(withReuseIdentifier: "cell", for: ip) as! WLPageCollectionViewCell
                
                cell.icon = item
                
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
            .currentpage
            .bind(to: pageControl.rx.currentPage)
            .disposed(by: disposed)
        
        viewModel
            .output
            .numofpage
            .bind(to: pageControl.rx.numberOfPages)
            .disposed(by: disposed)
        
        viewModel
            .output
            .skipHidden
            .asObservable()
            .bind(to: skipItem.rx.isHidden)
            .disposed(by: disposed)
        
        switch style {
        case .one:
            
            viewModel
                .output
                .pageHidden
                .bind(to: pageControl.rx.isHidden)
                .disposed(by: disposed)
            
        case .two:
            
            viewModel
                .output
                .timered
                .bind(to: skipItem.rx.skipTitle)
                .disposed(by: disposed)
        }
        
        viewModel
            .output
            .skiped
            .drive(onNext: { [weak self] (_) in
                
                guard let `self` = self else { return }
                
                DNotificationConfigration.postNotification(withName: NSNotification.Name(rawValue: DNotificationWelcomeSkip), andValue: nil, andFrom: self)
            })
            .disposed(by: disposed)
    }
}
