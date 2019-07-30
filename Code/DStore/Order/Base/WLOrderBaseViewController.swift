//
//  WLOrderViewController.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DPrepare
import WLBaseTableView
import WLThirdUtil.WLHudUtil
import RxDataSources
import WLToolsKit

public final class WLOrderEmpty: WLTableViewEmptyViewSource {
    public var emptyAText: NSAttributedString {
        let blackListStyle = NSMutableParagraphStyle()
        
        blackListStyle.alignment = .center
        
        return NSAttributedString(string: "暂无订单", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: WLHEXCOLOR(hexColor: "#666666") ,NSAttributedString.Key.paragraphStyle: blackListStyle])
    }
    
    public var emptyIcon: String { return ""}
    
    public var emptyIconFrame: CGRect { return .zero }
    
    public var emptyTextFrame: CGRect { return UIScreen.main.bounds }
    
    public var emptyFrame: CGRect { return UIScreen.main.bounds }
    
    public var canResponse: Bool { return true }
    
    public var emptyBackgroundHex: String { return "#f1f1f1"}
}


@objc (WLOrderBaseViewController)
open class WLOrderBaseViewController: WLLoadingDisposeF1ViewController {
    
    public var tag: String = ""
    
    public required init(_ tag: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.tag = tag
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public final let tableView: WLOrderTableView = WLOrderTableView.baseTableView()
    
    override open func addOwnSubViews() {
        
        view.addSubview(tableView)
    }
    
    typealias Section = MySection<WLCommodityBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: WLOrderViewModel!
    
    override open func configOwnSubViews() {
        
        tableView.snp.makeConstraints { (make) in
            
            make.right.left.bottom.equalToSuperview()
            
            make.top.equalTo(WL_TOP_LAYOUT_GUARD)
        }
        
        tableView.separatorStyle = .none
        
    }
    
    open func configCell(_ tv: UITableView,ip: IndexPath,item: WLCommodityBean) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    open func caculateHeight(_ ip: IndexPath,item: WLCommodityBean) -> CGFloat {
        
        return 100
    }
    
    override open func configViewModel() {
        
        self.tableView.mj_footer.isHidden = true
        
        let input = WLOrderViewModel.WLInput(tag: tag,
                                             modelSelect: tableView.rx.modelSelected(WLCommodityBean.self),
                                             itemSelect: tableView.rx.itemSelected,
                                             headerRefresh: tableView.mj_header.rx.refreshing.asDriver())
        
        viewModel = WLOrderViewModel(input, disposed: disposed)
        
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
            .subscribe(onNext: { [unowned self] (type,ip) in
                
                self.onOrderClick(type, ip: ip)
                
            })
            .disposed(by: disposed)
        
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
    }
    open func onOrderClick(_ type: WLCommodityBean,ip: IndexPath) {
        
        
    }
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let dataSource = dataSource else { return 0}
        
        return caculateHeight(indexPath, item: dataSource[indexPath])
    }
    
    open func emptyViewShow() {
        
        tableView.emptyViewShow(WLOrderEmpty())
    }
    override open func configNaviItem() {
        
        title = "我的订单"
    }
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "删除") { [weak self] (a, ip) in
            
            guard let `self` = self else { return }
            
            let type = self.dataSource[ip]
            
            let alert = UIAlertController(title: "订单信息", message: "是否删除此条数据？", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "取消", style: .cancel) { (a) in }
            
            let confirm = UIAlertAction(title: "确定", style: .default) { [weak self] (a) in
                
                guard let `self` = self else { return }
                
                WLHudUtil.show(withStatus: "移除数据中...")
                
                WLCartViewModel
                    .removeCart(type.identity)
                    .drive(onNext: { [weak self] (result) in
                        
                        guard let `self` = self else { return }
                        switch result {
                        case .ok:
                            
                            WLHudUtil.pop()
                            
                            WLHudUtil.showInfo("移除数据成功")
                            
                            var value = self.viewModel.output.tableData.value
                            
                            value.remove(at: ip.section)
                            
                            self.viewModel.output.tableData.accept(value)
                            
                            if value.isEmpty {
                                
                                self.emptyViewShow()
                            }
                        case .failed:
                            
                            WLHudUtil.pop()
                            
                            WLHudUtil.showInfo("移除数据失败")
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
extension WLOrderBaseViewController: UITableViewDelegate { }
