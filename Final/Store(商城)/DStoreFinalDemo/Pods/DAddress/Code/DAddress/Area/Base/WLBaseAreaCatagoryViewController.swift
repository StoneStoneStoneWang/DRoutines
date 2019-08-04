//
//  WLBaseAreaCatagoryViewController.swift
//  DAddressDemo
//
//  Created by three stone 王 on 2019/7/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DPrepare
import WLBaseTableView
import RxDataSources
import RxCocoa
import RxSwift

extension Reactive where Base: WLBaseAreaCatagoryViewController {
    
    public var complete: Observable<WLAreaBean> {
        
        return self.base.tableView.rx.modelSelected(WLAreaBean.self).asObservable()
    }
}

@objc (WLBaseAreaCatagoryViewController)
open class WLBaseAreaCatagoryViewController: WLF1DisposeViewController {
    
    var viewModel: WLAreaCatagoryViewModel!
    
    var areas: [WLAreaBean] = []
    
    var config: WLAddressConfig!
    
    var selectArea: BehaviorRelay<WLAreaBean> = BehaviorRelay<WLAreaBean>(value: WLAreaBean())
    
    public final let tableView = WLAreaCatagoryTableView.baseTableView()
    
    var addressEditBean: BehaviorRelay<WLAddressEditBean> = BehaviorRelay<WLAddressEditBean>(value: WLAddressEditBean())
    
    public required init(_ areas: [WLAreaBean] ,config: WLAddressConfig,selectedAreaId: Int) {
        
        let fetchArea = WLAreaManager.default.fetchSomeArea(selectedAreaId, areas: areas)
        
        fetchArea.isSelected = true
        
        self.selectArea.accept(fetchArea)
        
        self.config = config
        
        self.areas += areas
        
        super.init(nibName: nil, bundle: nil)
    }
    
    public func updateDatas(_ areas: [WLAreaBean] ,selectedAreaId: Int) {
        
        for item in areas {
            
            item.isSelected = false
        }
        
        let fetchArea = WLAreaManager.default.fetchSomeArea(selectedAreaId, areas: areas)
        
        fetchArea.isSelected = true
        
        self.selectArea.accept(fetchArea)
        
        self.areas.removeAll()
        
        self.areas += areas
        
        self.viewModel.output.tableData.accept(areas)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func addOwnSubViews() {
        
        view.addSubview(tableView)
    }
    override open func configOwnSubViews() {
        
        tableView.snp.makeConstraints { (make) in
            
            make.right.left.bottom.equalToSuperview()
            
            make.top.equalToSuperview()
        }
        
        tableView.separatorStyle = .none
    }
    
    typealias Section = MySection<WLAreaBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    open override func configViewModel() {
        
        let input = WLAreaCatagoryViewModel.WLInput(areas: areas,
                                                    modelSelect: tableView.rx.modelSelected(WLAreaBean.self),
                                                    itemSelect: tableView.rx.itemSelected)
        
        viewModel = WLAreaCatagoryViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .top, reloadAnimation: .fade, deleteAnimation: .left),
            decideViewTransition: { _,_,_  in return .reload },
            configureCell: { [unowned self] ds, tv, ip, item in return self.configCell(tv, ip: ip, item: item) })
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .tableData
            .asDriver()
            .map({ $0.map({ Section(header: "\($0.id)", items: [$0]) }) })
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { [unowned self] (area,ip) in
                
                self.onAreaClick(area, ip: ip)
            })
            .disposed(by: disposed)
        
        tableView.rx.setDelegate(self).disposed(by: disposed)
    }
    
    func updateAreas(_ areas: [WLAreaBean]) {
        
        viewModel.output.tableData.accept(areas)
        
        self.selectArea.accept(WLAreaBean())
    }
    
    open func onAreaClick(_ area: WLAreaBean ,ip: IndexPath) {
        
        
    }
    
    open func configCell(_ tv: UITableView,ip: IndexPath,item: WLAreaBean) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    open func caculateHeight(_ ip: IndexPath,item: WLAreaBean) -> CGFloat {
        
        return 30
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return caculateHeight(indexPath, item: datasource[indexPath])
    }
}
extension WLBaseAreaCatagoryViewController: UITableViewDelegate {}
