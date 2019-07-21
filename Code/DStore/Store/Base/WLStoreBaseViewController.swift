//
//  WLStoreBaseViewController.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxDataSources
import WLBaseTableView
import WLToolsKit
import WLThirdUtil.WLHudUtil
import SnapKit
import ObjectMapper
import DPrepare
import DLogin

@objc (WLStoreBaseViewController)
open class WLStoreBaseViewController: WLLoadingDisposeF1ViewController {
    
    public var config: WLStoreConfig!
    
    public var style: WLStoreStyle = .one
    
    public var tag: String = ""
    
    public var loginConfig: WLLoginConfig!
    
    public var loginStyle: WLLoginStyle = .one
    
    public var mDelegate: WLStoreDelegate!
    
    public required init(_ tag: String,style: WLStoreStyle,config: WLStoreConfig ,loginStyle: WLLoginStyle,loginConfig: WLLoginConfig,delegate: WLStoreDelegate!) {
        super.init(nibName: nil, bundle: nil)
        
        self.tag = tag
        
        self.config = config
        
        self.style = style
        
        self.loginStyle = loginStyle
        
        self.loginConfig = loginConfig
        
        self.mDelegate = delegate
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public final let collectionView: WLStoreCollectionView = WLStoreCollectionView.createStore()
    
    override open func addOwnSubViews() {
        
        view.addSubview(collectionView)
    }
    
    override open func configOwnSubViews() {
        
        collectionView.snp.makeConstraints { (make) in
            
            make.right.left.bottom.equalToSuperview()
            
            make.top.equalTo(WL_TOP_LAYOUT_GUARD )
        }
    }
    
    open func configCell(_ cv: UICollectionView,ip: IndexPath,item: WLCommodityBean) -> UICollectionViewCell {
        
        return UICollectionViewCell()
    }
    
    typealias Section = MySection<WLCommodityBean>
    
    var dataSource: RxCollectionViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: WLStoreViewModel!
    
    override open func configViewModel() {
        
        self.collectionView.mj_header.beginRefreshing()
        
        self.collectionView.mj_footer.isHidden = true
        
        let input = WLStoreViewModel.WLInput(modelSelect: collectionView.rx.modelSelected(WLCommodityBean.self),
                                              itemSelect: collectionView.rx.itemSelected,
                                              headerRefresh: collectionView.mj_header.rx.refreshing.asDriver(),
                                              footerRefresh: collectionView.mj_footer.rx.refreshing.asDriver(),
                                              tag: tag)
        
        viewModel = WLStoreViewModel(input, disposed: disposed)
        
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .left),
            decideViewTransition: { _,_,_  in return .reload },
            configureCell: { [unowned self] ds, tv, ip, item in return self.configCell(tv, ip: ip, item: item) })
        
        viewModel
            .output
            .tableData
            .asDriver()
            .map({ [Section(header: "", items: $0)] })
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        let endHeaderRefreshing = viewModel.output.endHeaderRefreshing
        
        endHeaderRefreshing
            .map({ _ in return true })
            .drive(collectionView.mj_header.rx.endRefreshing)
            .disposed(by: disposed)
        
        endHeaderRefreshing
            .drive(onNext: { [weak self] (res) in
                guard let `self` = self else { return }
                switch res {
                case .fetchList:
                    self.loadingView.onLoadingStatusChanged(.succ)
                    
                case let .failed(msg):
                    WLHudUtil.showInfo(msg)
                    self.loadingView.onLoadingStatusChanged(.fail)
                case .empty:
                    self.loadingView.onLoadingStatusChanged(.succ)
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
        let endFooterRefreshing = viewModel.output.endFooterRefreshing
        
        endFooterRefreshing
            .map({ _ in return true })
            .drive(collectionView.mj_footer.rx.endRefreshing)
            .disposed(by: disposed)
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { [unowned self] (type,ip) in
                
                guard let delegate = self.mDelegate else { return }
                
                delegate.onCommodityClick(self, storeJson: type.toJSON())

            })
            .disposed(by: disposed)
        
        viewModel
            .output
            .footerHidden
            .bind(to: collectionView.mj_footer.rx.isHidden)
            .disposed(by: disposed)
    }
}
