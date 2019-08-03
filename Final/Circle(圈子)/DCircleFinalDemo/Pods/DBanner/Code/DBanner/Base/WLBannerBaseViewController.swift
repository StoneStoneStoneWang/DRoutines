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
import RxCocoa
import DNotification
import WLThirdUtil.WLHudUtil
@objc (WLBannerBaseViewController)
open class WLBannerBaseViewController: WLBaseDisposeViewController {
    
    var style: WLBannerStyle = .one
    
    public required init(_ style: WLBannerStyle) {
        
        self.style = style
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel: WLBannerViewModel!
    
    typealias Section = WLSectionModel<(), WLBannerBean>
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<Section>!
    
    public lazy var collectionView: WLBannerView = {
        
        switch style {
        case .one:
            
            let layout = WLBannerViewLayout()
            
            return WLBannerView.banner(layout)
            
        case .two:
            
            let layout = WLBannerViewNormalLayout()
            
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
        
        
        let input = WLBannerViewModel.WLInput(contentoffSetX: collectionView.rx.contentOffset.map({ $0.x }),
                                              modelSelect: collectionView.rx.modelSelected(WLBannerBean.self),
                                              itemSelect: collectionView.rx.itemSelected,
                                              currentPage: BehaviorRelay<Int>(value: 0),
                                              style: style)
        
        viewModel = WLBannerViewModel(input, disposed: disposed)
        
        WLBannerViewModel
            .fetchBanners()
            .drive(onNext: { [unowned self] (result) in
                
                switch result {
                case .fetchList(let list):
                    
                    var mutable: [WLBannerBean] = []
                    
                    if list.count > 1 {
                        
                        let temp = list as! [WLBannerBean]
                        
                        for _ in 0..<999 {
                            
                            mutable += [temp[4]]
                            
                            mutable += [temp[5]]
                            
//                            mutable += [temp[6]]

//                            mutable += [temp[7]]
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                            
                            self.collectionView.selectItem(at: IndexPath(item: mutable.count / 5, section:0), animated: false, scrollPosition: .centeredHorizontally)
                        }
                    }

                    self.viewModel.output.tableData.accept(mutable)
                case .failed(let msg):
                    
                    WLHudUtil.showInfo(msg)
                default: break
                    
                }
            })
            .disposed(by: disposed)
        
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
                
                DNotificationConfigration.postNotification(withName: NSNotification.Name(DNotificationBannerClick), andValue: banner.toJSON(), andFrom: self)
            })
            .disposed(by: disposed)
        
        viewModel
            .output
            .timered
            .subscribe(onNext: { [unowned self] (index) in
                
                self.collectionView.selectItem(at: IndexPath(item: index, section:0), animated: true, scrollPosition: .centeredHorizontally)
            })
            .disposed(by: disposed)
        
        collectionView.rx.setDelegate(self).disposed(by: disposed)
    }
}
extension WLBannerBaseViewController: UIScrollViewDelegate {
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        DispatchQueue.main.async {
            
            let width = self.style == .one ? (WL_SCREEN_WIDTH - 60 ) : WL_SCREEN_WIDTH
            
            let floatx = scrollView.contentOffset.x / width
            
            let intx = floor(floatx)
            
            if floatx + 0.5 >= intx {
                
                self.collectionView.selectItem(at: IndexPath(item: Int(scrollView.contentOffset.x / width) + 1, section:0), animated: true, scrollPosition: .centeredHorizontally)
            } else {
                
                self.collectionView.selectItem(at: IndexPath(item: Int(scrollView.contentOffset.x / width), section:0), animated: true, scrollPosition: .centeredHorizontally)
            }
        }
    }
}
