//
//  WLStoreCatagoryViewController.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DPrepare
import WLToolsKit
import WLThirdUtil.WLHudUtil
import WLBaseTableView
import RxDataSources
import WLReqKit
import RxCocoa
import RxSwift

open class WLStoreCatagoryBaseViewController: WLF1DisposeViewController {
    @objc (currentIdx)
    public var currentIdx: Int = 0
    
    var config: WLStoreConfig!
    
    var headers: [[String: Any]] = []
    
    var delegate: WLStoreDelegate!
    
    public required init(_ config: WLStoreConfig ,headers: [[String: Any]],delegate: WLStoreDelegate) {
        
        self.config = config
        
        self.headers += headers
        
        self.delegate = delegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @objc (moreItem)
    public var moreItem = UIButton(type: .custom).then {
        
        $0.sizeToFit()
    }
    open override func configNaviItem() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moreItem)
        
        moreItem.setTitle("发布", for: .normal)
        
        moreItem.setTitle("发布", for: .highlighted)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    final let collectionView = WLStoreHeaderCollectionView.createStoreHeader()
    
    override open func addOwnSubViews() {
        
        view.addSubview(collectionView)
    }
    
    override open func configOwnSubViews() {
        
        collectionView.snp.makeConstraints { (make) in
            
            make.left.right.equalToSuperview()
            
            make.height.equalTo(WL_Store_Height)
            
            make.top.equalTo(WL_TOP_LAYOUT_GUARD)
            
        }
    }
    
    open func configCell(_ cv: UICollectionView,ip: IndexPath,item: WLStoreHeaderBean) -> UICollectionViewCell {
        
        return UICollectionViewCell()
    }
    
    var viewModel: WLStoreCatagoryViewModel!
    
    typealias Section = WLSectionModel<(), WLStoreHeaderBean>
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<Section>!
    
    open override func configViewModel() {
        
        let input = WLStoreCatagoryViewModel.WLInput(headers: headers,
                                                     modelSelect: collectionView.rx.modelSelected(WLStoreHeaderBean.self),
                                                     itemSelect: collectionView.rx.itemSelected)
        
        viewModel = WLStoreCatagoryViewModel(input, disposed: disposed)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<Section>(
            configureCell: { [unowned self] ds, cv, ip, item in return self.configCell(cv, ip: ip, item: item) })
        
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
            .subscribe(onNext: { [unowned self] (header,ip) in
                
                self.onHeaderClick(header, ip: ip)
            })
            .disposed(by: disposed)
        
    }
    
    open func onHeaderClick(_ area: WLStoreHeaderBean ,ip: IndexPath) {
        
        
    }
}
