//
//  WLFocusBaseViewController.swift
//  SFocusDemo
//
//  Created by three stone 王 on 2019/6/1.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxDataSources
import WLBaseTableView
import WLToolsKit
import WLThirdUtil.WLHudUtil
import SnapKit
import DPrepare
import DNotification

@objc (WLFocusBaseViewController)
open class WLFocusBaseViewController: WLLoadingDisposeF1ViewController {
    
    public var config: WLFocusListConfig!
    
    public required init(_ config: WLFocusListConfig) {
        super.init(nibName: nil, bundle: nil)
        
        self.config = config
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public final let tableView: WLFocusListTableView = WLFocusListTableView.baseTableView()
    
    override open func addOwnSubViews() {
        
        view.addSubview(tableView)
    }
    
    override open func configOwnSubViews() {
        
        tableView.separatorStyle = .none
        
        tableView.register(WLFocusListBaseTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    typealias Section = MySection<WLFocusBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: WLFocusViewModel!
    
    open func configCell(_ tv: UITableView,ip: IndexPath,item: WLFocusBean) -> UITableViewCell {
        
        let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! WLFocusList1TableViewCell
        
        cell.type = (item,config) as? (WLFocusBean, WLFocusListConfig)
        
        return cell
    }
    
    open func caculateHeight(_ ip: IndexPath,item: WLFocusBean) -> CGFloat {
        
        return 80
    }
    open func emptyViewShow() {
        
        tableView.emptyViewShow(WLFocusList1Empty())
    }
    
    override open func configViewModel() {
        
        //        self.tableView.mj_header.beginRefreshing()
        
        self.tableView.mj_footer.isHidden = true
        
        let input = WLFocusViewModel.WLInput(modelSelect: tableView.rx.modelSelected(WLFocusBean.self),
                                             itemSelect: tableView.rx.itemSelected,
                                             headerRefresh: tableView.mj_header.rx.refreshing.asDriver())
        
        viewModel = WLFocusViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .top, reloadAnimation: .fade, deleteAnimation: .left),
            decideViewTransition: { _,_,_  in return .reload },
            configureCell: { [unowned self] ds, tv, ip, item in return self.configCell(tv, ip: ip, item: item) }
            ,canEditRowAtIndexPath: { _,_ in return true })
        
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
}

extension WLFocusBaseViewController: UITableViewDelegate {
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let dataSource = dataSource else { return 0}
        
        return caculateHeight(indexPath, item: dataSource[indexPath])
    }
    
    override open func configNaviItem() {
        
        title = "我的关注"
    }
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "删除") { [weak self] (a, ip) in
            
            guard let `self` = self else { return }
            
            let type = self.dataSource[ip]
            
            let alert = UIAlertController(title: "关注信息", message: "是否取消\(type.users.nickname)拉黑？", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "取消", style: .cancel) { (a) in }
            
            let confirm = UIAlertAction(title: "确定", style: .default) { [weak self] (a) in
                
                guard let `self` = self else { return }
                
                WLHudUtil.show(withStatus: "移除\(type.users.nickname)中...")
                
                WLFocusViewModel
                    .removeFocus(type.users.encoded, encode: type.encoded)
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
                            DNotificationConfigration.postNotification(withName: NSNotification.Name(rawValue: DNotificationRemoveFocus), andValue: nil, andFrom: self)
                            
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
