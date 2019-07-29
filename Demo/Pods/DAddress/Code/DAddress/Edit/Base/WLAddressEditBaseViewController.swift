//
//  WLAddressEditBaseViewController.swift
//  DAddressDemo
//
//  Created by three stone 王 on 2019/7/17.
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

extension Reactive where Base: WLAddressEditBaseViewController {
    
    public var complete: Observable<WLAddressBean> {
        
        return base.addItem.rx.tap.withLatestFrom(base.addressBean)
    }
}

@objc (WLAddressEditBaseViewController)
open class WLAddressEditBaseViewController: WLF1DisposeViewController {
    
    public var config: WLAddressConfig!
    
    public var isEdit: Bool = false
    
    let addressBean: BehaviorRelay<WLAddressBean> = BehaviorRelay<WLAddressBean>(value: WLAddressBean())
    
    public required init(_ config: WLAddressConfig ,isEdit: Bool ,addressBean: WLAddressBean) {
        super.init(nibName: nil, bundle: nil)
        
        self.addressBean.accept(addressBean)
        
        self.config = config
        
        self.isEdit = isEdit
    }
    
    public final let tableView: WLAddressEditTableView = WLAddressEditTableView.baseTableView()
    
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
        
        addItem.setTitle(isEdit ? "编辑收货地址" : "新增收货地址", for: .normal)
        
        addItem.setTitle(isEdit ? "编辑收货地址" : "新增收货地址", for: .highlighted)
        
        //        tableView.register(WLAddressBaseTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    open override func configNaviItem() {
        
        title = isEdit ? "编辑收货地址" : "新增收货地址"
    }
    
    public final let addItem: UIButton = UIButton(type: .custom)
    
    typealias Section = MySection<WLAddressEditBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: WLAddressEditViewModel!
    
    override open func configViewModel() {
        
        let input = WLAddressEditViewModel.WLInput(addressBean: addressBean,
                                                   modelSelect: tableView.rx.modelSelected(WLAddressEditBean.self),
                                                   itemSelect: tableView.rx.itemSelected,
                                                   addTaps: addItem.rx.tap.asSignal())
        
        viewModel = WLAddressEditViewModel(input, disposed: disposed)
        
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
                
                switch type.type {
                case .area:
                    
                    let area = WLAreaBaseViewController.createArea(self.config, addressEditBean: type)
                    
                    self.present(area, animated: true, completion: nil)
                    
                    area
                        .rx
                        .formData
                        .subscribe(onNext: { [unowned self] (bean) in
                            
                            self.tableView.reloadRows(at: [ip], with: .fade)
                        })
                        .disposed(by: area.disposed)
                    
                default: break
                    
                }
            })
            .disposed(by: disposed)
        
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
        
        // MARK: 登录点击中序列
        viewModel
            .output
            .adding
            .drive(onNext: { [weak self] _ in
                
                guard let `self` = self else { return }
                
                self.view.endEditing(true)
                
                WLHudUtil.show(withStatus: "收货人提交中...")
            })
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
                    
                case let .operation(bean):
                    
                    self.addressBean.accept(bean as! WLAddressBean)
                    
                    WLHudUtil.showInfo("收货人提交成功")
                    
                    self.navigationController?.popViewController(animated: true)
                    
                default: break
                }
            })
            .disposed(by: disposed)
        
    }
    open func configCell(_ tv: UITableView, ip: IndexPath, item: WLAddressEditBean) -> UITableViewCell {
        
        return UITableViewCell()
    }
}
extension WLAddressEditBaseViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return datasource[indexPath].type.cellHeight
    }
}
