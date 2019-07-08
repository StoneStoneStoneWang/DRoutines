//
//  WLBlackListBaseViewController.swift
//  SBlackListDemo
//
//  Created by three stone 王 on 2019/6/1.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DPrepare
import WLBaseTableView
import WLThirdUtil.WLHudUtil
import RxDataSources
import WLToolsKit

@objc (WLBlackListBaseViewController)
open class WLBlackListBaseViewController: WLLoadingDisposeF1ViewController {
    
    public var config: WLBlackListConfig!
    
    public var style: WLBlackListStyle = .one
    
    public required init(_ style: WLBlackListStyle,config: WLBlackListConfig) {
        super.init(nibName: nil, bundle: nil)
        
        self.config = config
        
        self.style = style
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public final let tableView: WLBlackListTableView = WLBlackListTableView.baseTableView()
    
    override open func addOwnSubViews() {
        
        view.addSubview(tableView)
    }
    
    typealias Section = MySection<WLBlackListBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: WLBlackListViewModel!
    
    override open func configOwnSubViews() {
        
        tableView.snp.makeConstraints { (make) in
            
            make.right.left.bottom.equalToSuperview()
            
            make.top.equalTo(WL_TOP_LAYOUT_GUARD)
        }
        
        tableView.separatorStyle = .none
        
        tableView.register(WLBlackList1TableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    open func configCell(_ tv: UITableView,ip: IndexPath,item: WLBlackListBean) -> UITableViewCell {
        
        let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! WLBlackListBaseTableViewCell
        
        cell.type = (item,config) as? (WLBlackListBean, WLBlackListConfig)
        
        return cell
    }
    
    open func caculateHeight(_ ip: IndexPath,item: WLBlackListBean) -> CGFloat {
        
        return 80
    }
    
    override open func configViewModel() {
        
        self.tableView.mj_footer.isHidden = true
        
        let input = WLBlackListViewModel.WLInput(modelSelect: tableView.rx.modelSelected(WLBlackListBean.self),
                                                 itemSelect: tableView.rx.itemSelected,
                                                 headerRefresh: tableView.mj_header.rx.refreshing.asDriver())
        
        viewModel = WLBlackListViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .top, reloadAnimation: .fade, deleteAnimation: .left),
            decideViewTransition: { _,_,_  in return .reload },
            configureCell: { [unowned self] ds, tv, ip, item in return self.configCell(tv, ip: ip, item: item) }
            ,canEditRowAtIndexPath: {_,_ in return true })
        
        viewModel
            .output
            .tableData
            .asDriver()
            .map({ $0.map({ Section(header: $0.encoded, items: [$0]) }) })
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        let endHeaderRefreshing = viewModel.output.endHeaderRefreshing
        
        endHeaderRefreshing
            .map({ _ in return true })
            .drive(tableView.mj_header.rx.endRefreshing)
            .disposed(by: disposed)
        
        endHeaderRefreshing
            .drive(onNext: { [weak self] (res) in
                guard let `self` = self else { return }
                switch res {
                case .fetchList:
                    self.loadingView.onLoadingStatusChanged(.succ)
                    self.tableView.emptyViewHidden()
                    
                case let .failed(msg):
                    WLHudUtil.showInfo(msg)
                    self.loadingView.onLoadingStatusChanged(.fail)
                case .empty:
                    self.loadingView.onLoadingStatusChanged(.succ)
                    
                    self.emptyViewShow()
                    
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { (type,ip) in })
            .disposed(by: disposed)
        
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
    }
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let dataSource = dataSource else { return 0}
        
        return caculateHeight(indexPath, item: dataSource[indexPath])
    }
    
    open func emptyViewShow() {
        
        tableView.emptyViewShow(WLBlackList1Empty())
    }
    override open func configNaviItem() {
        
        title = "黑名单"
    }
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "删除") { [weak self] (a, ip) in
            
            guard let `self` = self else { return }
            
            let type = self.dataSource[ip]
            
            let alert = UIAlertController(title: "黑名单信息", message: "是否取消\(type.users.nickname)拉黑？", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "取消", style: .cancel) { (a) in }
            
            let confirm = UIAlertAction(title: "确定", style: .default) { [weak self] (a) in
                
                guard let `self` = self else { return }
                
                WLHudUtil.show(withStatus: "移除\(type.users.nickname)中...")
                
                WLBlackListViewModel
                    .removeBlack(type.identity)
                    .drive(onNext: { [weak self] (result) in
                        
                        guard let `self` = self else { return }
                        switch result {
                        case .ok:
                            
                            WLHudUtil.pop()
                            
                            WLHudUtil.showInfo("移除\(type.users.nickname)成功")
                            
                            var value = self.viewModel.output.tableData.value
                            
                            value.remove(at: ip.section)
                            
                            self.viewModel.output.tableData.accept(value)
                            
                            if value.isEmpty {
                                
                                self.emptyViewShow()
                            }
                        case .failed:
                            
                            WLHudUtil.pop()
                            
                            WLHudUtil.showInfo("移除\(type.users.nickname)失败")
                        default: break;
                            
                        }
                    })
                    .disposed(by: self.disposed)
            }
            
            alert.addAction(cancel)
            
            alert.addAction(confirm)
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
        return [delete]
    }
}
extension WLBlackListBaseViewController: UITableViewDelegate { }
