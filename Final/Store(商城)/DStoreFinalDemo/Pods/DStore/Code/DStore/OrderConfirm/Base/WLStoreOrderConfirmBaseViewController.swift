//
//  WLStoreOrderConfirmBaseViewController.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DPrepare
import WLBaseTableView
import RxDataSources
import RxCocoa
import RxSwift
import WLToolsKit
import WLThirdUtil.WLHudUtil
import DAddress
//extension Reactive where Base: WLStoreOrderConfirmBaseViewController {
//
//    public var complete: Observable<WLAddressBean> {
//
//        return base.addItem.rx.tap.withLatestFrom(base.addressBean)
//    }
//}

@objc (WLStoreOrderConfirmBaseViewController)
open class WLStoreOrderConfirmBaseViewController: WLF1DisposeViewController {
    
    public var config: WLStoreConfig!
    
    public var addressConfig: WLAddressConfig!
    
    var commodityBean: WLCommodityBean!
    
    var addressBean: WLAddressBean!
    
    public required init(_ config: WLStoreConfig ,addressConfig: WLAddressConfig ,commodity: WLCommodityBean) {
        super.init(nibName: nil, bundle: nil)
        
        self.config = config
        
        self.commodityBean = commodity
        
        self.addressConfig = addressConfig
    }
    
    public final let tableView: WLStoreOrderConfirmTableView = WLStoreOrderConfirmTableView.baseTableView()
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func addOwnSubViews() {
        
        view.addSubview(tableView)
        
        view.addSubview(addItem)
    }
    
    override open func configOwnSubViews() {
        
        tableView.snp.makeConstraints { (make) in
            
            make.right.left.bottom.equalToSuperview()
            
            make.top.equalTo(WL_TOP_LAYOUT_GUARD)
        }
        
        tableView.separatorStyle = .none
        
        addItem.snp.makeConstraints { (make) in
            
            make.centerX.equalToSuperview()
            
            make.width.equalTo(200)
            
            make.height.equalTo(40)
            
            make.bottom.equalTo(-6)
        }
        
        addItem.layer.cornerRadius = 20
        
        addItem.layer.masksToBounds = true
        
        addItem.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        addItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR(hexColor: config.itemColor)), for: .normal)
        
        addItem.setBackgroundImage(UIImage.colorTransformToImage(color: WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60")), for: .highlighted)
        
        addItem.setTitle("购买", for: .normal)
        
        addItem.setTitle("购买", for: .highlighted)
    }
    
    public final let addItem: UIButton = UIButton(type: .custom)
    
    typealias Section = MySection<WLStoreOrderConfirmBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: WLStoreOrderConfirmViewModel!
    
    override open func configViewModel() {
        
        let input = WLStoreOrderConfirmViewModel.WLInput(address: addressBean,
                                                         commodity: commodityBean,
                                                         modelSelect: tableView.rx.modelSelected(WLStoreOrderConfirmBean.self),
                                                         itemSelect: tableView.rx.itemSelected,
                                                         addTaps: addItem.rx.tap.asSignal())
        
        viewModel = WLStoreOrderConfirmViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .top, reloadAnimation: .fade, deleteAnimation: .left),
            decideViewTransition: { _,_,_  in return .reload },
            configureCell: { [unowned self] ds, tv, ip, item in return self.configCell(tv, ip: ip, item: item) })
        
        viewModel
            .input
            .tableData
            .asDriver()
            .map({ $0.map({ Section(header: "\($0.identity)", items: [$0]) }) })
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { [weak self] (type,ip) in
                
                guard let `self` = self else { return }
                
                self.tableView.deselectRow(at: ip, animated: true)
                
                self.onStoreOrderConfirmClick(type, ip: ip)
                
            })
            .disposed(by: disposed)
        
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
        // MARK: 登录事件返回序列
        viewModel
            .output
            .added
            .drive(onNext: { [weak self] in
                guard let `self` = self else { return }
                
                WLHudUtil.pop()
                
                switch $0 {
                    
                case let .failed(msg): WLHudUtil.showInfo(msg)
                    
                case let .ok(msg):
                    
                    WLHudUtil.showInfo(msg)
                    
                    self.navigationController?.popToRootViewController(animated: true)
                    
                default: break
                }
            })
            .disposed(by: disposed)
        
    }
    open func configCell(_ tv: UITableView, ip: IndexPath, item: WLStoreOrderConfirmBean) -> UITableViewCell {
        
        return UITableViewCell()
    }
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return datasource[indexPath].cellHeight
        
    }
    open func onStoreOrderConfirmClick(_ OrderConfirmBean: WLStoreOrderConfirmBean,ip: IndexPath) {
        
        
    }
}

extension WLStoreOrderConfirmBaseViewController: UITableViewDelegate {
    
    
}
