//
//  WLAboutViewController.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxCocoa
import WLBaseTableView
import WLToolsKit
import RxDataSources
import DPrepare

@objc (WLAboutViewController)
public final class WLAboutViewController: WLF1DisposeViewController {
    
    public var config: WLAboutConfig!
    
    public required init(_ config: WLAboutConfig) {
        super.init(nibName: nil, bundle: nil)
        
        self.config = config
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    final let tableView: WLAboutTableView = WLAboutTableView.baseTableView()
    
    final let aboutHeader: WLAboutHeaderView = WLAboutHeaderView(frame: .zero)
    
    override public func addOwnSubViews() {
        
        view.addSubview(tableView)
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override public func configOwnSubViews() {
        
        tableView.snp.makeConstraints { (make) in
            
            make.right.left.bottom.equalToSuperview()
            
            make.top.equalTo(WL_TOP_LAYOUT_GUARD)
        }
        
        aboutHeader.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 120)
        
        tableView.tableHeaderView = aboutHeader
        
        tableView.separatorStyle = .none
        
        tableView.register(WLAboutTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    typealias Section = WLSectionModel<(), WLAboutType>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: WLAboutViewModel!
    
    override public func configViewModel() {
        
        aboutHeader.config = config
        
        let input = WLAboutViewModel.WLInput(modelSelect: tableView.rx.modelSelected(WLAboutType.self),
                                             itemSelect: tableView.rx.itemSelected)
        
        viewModel = WLAboutViewModel(input)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in
                
                let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! WLAboutTableViewCell
                
                cell.type = item
                
                return cell
        })
        
        viewModel
            .output
            .tableData
            .asDriver()
            .map({ [Section(model: (), items: $0)]  })
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { [weak self] (type,ip) in
                
                guard let `self` = self else { return }
                
                self.tableView.deselectRow(at: ip, animated: true)
            })
            .disposed(by: disposed)
        
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
        
    }
}
extension WLAboutViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return datasource[indexPath].cellHeight
    }
    
    override public func configNaviItem() {
        
        title = "关于我们"
    }
}
