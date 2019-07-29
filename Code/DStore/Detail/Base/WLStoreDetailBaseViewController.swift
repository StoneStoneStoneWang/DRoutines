//
//  WLStoreDetailBaseViewController.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxDataSources
import WLBaseTableView
import WLToolsKit
import ObjectMapper
import DPrepare
import WLThirdUtil.WLHudUtil
import DAddress

@objc (WLStoreDetailBaseViewController)
open class WLStoreDetailBaseViewController: WLF1DisposeViewController{
    
    public var config: WLStoreConfig!
    
    public var style: WLStoreDetailStyle = .one
    
    public var moreItem: UIButton = UIButton(type: .custom)
    
    var commodityBean: WLCommodityBean!
    
    public required init(_ style: WLStoreDetailStyle,config: WLStoreConfig,storeJson: [String: Any]) {
        super.init(nibName: nil, bundle: nil)
        
        self.config = config
        
        self.style = style
        
        commodityBean = WLCommodityBean(JSON: storeJson)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public final let tableView: WLStoreDetailTableView = WLStoreDetailTableView.baseTableView()
    
    override open func addOwnSubViews() {
        
        view.addSubview(tableView)
        
        view.addSubview(addItem)
    }
    
    public final let addItem: UIButton = UIButton(type: .custom)
    
    override open func configOwnSubViews() {
        
        tableView.separatorStyle = .none
        
        tableView.register(WLStoreDetailImageTableViewCell.self, forCellReuseIdentifier: "image")
        
        tableView.snp.makeConstraints { (make) in
            
            make.left.right.bottom.equalToSuperview()
            
            make.top.equalTo(WL_TOP_LAYOUT_GUARD)
        }
        
        tableView.mj_insetB = WL_TOP_LAYOUT_GUARD + 40
        
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
    
    open func configCell(_ tv: UITableView,ip: IndexPath,item: WLKeyValueBean) -> UITableViewCell {
        
        let cell = tv.dequeueReusableCell(withIdentifier: "image") as! WLStoreDetailImageTableViewCell
        
        cell.icon = item.value
        
        return cell
    }
    
    open func caculateHeight(_ ip: IndexPath,item: WLKeyValueBean) -> CGFloat {
        
        return (view.bounds.width - 30) * 3 / 4 + 5
    }
    
    typealias Section = MySection<WLKeyValueBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: WLStoreDetailViewModel!
    
    override open func configViewModel() {
        
        let input = WLStoreDetailViewModel.WLInput(modelSelect: tableView.rx.modelSelected(WLKeyValueBean.self),
                                                   itemSelect: tableView.rx.itemSelected,
                                                   commodity: commodityBean,
                                                   addTaps: addItem.rx.tap.asSignal())
        
        viewModel = WLStoreDetailViewModel(input)
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .left),
            decideViewTransition: { _,_,_  in return .reload },
            configureCell: { [unowned self] ds, tv, ip, item in return self.configCell(tv, ip: ip, item: item) })
        
        viewModel
            .output
            .tableData
            .asDriver()
            .map({ $0.map({ Section(header: $0.identity, items: [$0]) }) })
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { [weak self] (type,ip) in
                
                guard let `self` = self ,let config = self.config else { return }
                
                let imageShow = WLImageShowViewController(type.value, back: config.backIcon)
                
                self.present(imageShow, animated: true, completion: nil)
                
            })
            .disposed(by: disposed)
        
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
        
        viewModel
            .output
            .added
            .drive(onNext: { [unowned self] (_) in
                
                let buy = WLBuyBaseViewController.createBuy(self.config, commodity: self.commodityBean)
                
                self.present(buy, animated: true, completion: nil)
                
                buy
                    .rx
                    .goBuy
                    .subscribe(onNext: { [unowned self](isFinished) in
                        
                        if isFinished {
                            
//                            let confirm = WLStoreOrderConfirmBaseViewController.createStoreOrder(self.config, addressConfig:self.addressConfig , commodity: self.commodityBean)
//                            
//                            self.navigationController?.pushViewController(confirm, animated: true)
                        }
                    })
                    .disposed(by: self.disposed)
                
                buy
                    .rx
                    .cart
                    .subscribe(onNext: { [unowned self](isFinished) in
                        
                        if isFinished {
                            
                            let alert = UIAlertController(title: "购物车信息", message: "您确认将此商品加入购物车", preferredStyle: .alert)
                            
                            let cancle = UIAlertAction(title: "取消", style: .cancel, handler: { (c) in
                                
                                
                            })
                            let confirm = UIAlertAction(title: "确定", style: .default, handler: { (c) in
                                
                                WLHudUtil.show(withStatus: "加入购物车中...")
                                
                                WLStoreDetailViewModel
                                    .addToCart(self.commodityBean)
                                    .drive(onNext: { [weak self] (result) in
                                        
                                        guard let `self` = self else { return }
                                        
                                        WLHudUtil.pop()
                                        
                                        switch result {
                                            
                                        case let .failed(msg): WLHudUtil.showInfo(msg)
                                            
                                        case let .ok(msg):
                                            
                                            WLHudUtil.showInfo(msg)
                                            
                                            self.navigationController?.popViewController(animated: true)
                                        default: break
                                        }
                                    })
                                    .disposed(by: self.disposed)
                                
                            })
                            
                            alert.addAction(cancle)
                            
                            alert.addAction(confirm)
                            
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    })
                    .disposed(by: self.disposed)
            })
            .disposed(by: disposed)
    }
    
    open override func configNaviItem() {
        
        title = "商品详情"
    }
}

extension WLStoreDetailBaseViewController: UITableViewDelegate {
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return caculateHeight(indexPath, item: datasource[indexPath])
    }
}
