//
//  WLAddressBaseViewController.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DPrepare
import WLBaseTableView
import WLThirdUtil.WLHudUtil
import RxDataSources
import WLToolsKit
import RxCocoa
import RxSwift

public final class WLAddressEmpty: WLTableViewEmptyViewSource {
    public var emptyAText: NSAttributedString {
        let blackListStyle = NSMutableParagraphStyle()
        
        blackListStyle.alignment = .center
        
        return NSAttributedString(string: "暂无地址", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: WLHEXCOLOR(hexColor: "#666666") ,NSAttributedString.Key.paragraphStyle: blackListStyle])
    }
    
    public var emptyIcon: String { return "暂无数据" }
    
    public var emptyIconFrame: CGRect { return UIScreen.main.bounds }
    
    public var emptyTextFrame: CGRect { return UIScreen.main.bounds }
    
    public var emptyFrame: CGRect { return UIScreen.main.bounds }
    
    public var canResponse: Bool { return true }
    
    public var emptyBackgroundHex: String { return "#f1f1f1"}
}

extension Reactive where Base :WLAddressBaseViewController {
    
    public var complete: Observable<WLAddressBean> {
        
        return self.base.tableView.rx.modelSelected(WLAddressBean.self).asObservable()
    }
}

@objc (WLAddressBaseViewController)
open class WLAddressBaseViewController: WLLoadingDisposeF1ViewController {
    
    public var config: WLAddressConfig!
    
    public required init(_ config: WLAddressConfig) {
        super.init(nibName: nil, bundle: nil)
        
        self.config = config
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public final let tableView: WLAddressTableView = WLAddressTableView.baseTableView()
    
    override open func addOwnSubViews() {
        
        view.addSubview(tableView)
        
        view.addSubview(addItem)
    }
    
    typealias Section = MySection<WLAddressBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: WLAddressViewModel!
    
    public final let addItem: UIButton = UIButton(type: .custom)
    
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
        
        addItem.setTitle("新增收货地址", for: .normal)
        
        addItem.setTitle("新增收货地址", for: .highlighted)
    }
    
    open func configCell(_ tv: UITableView,ip: IndexPath,item: WLAddressBean) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    open func caculateHeight(_ ip: IndexPath,item: WLAddressBean) -> CGFloat {
        
        return 80
    }
    
    override open func configViewModel() {
        
        self.tableView.mj_footer.isHidden = true
        
        let input = WLAddressViewModel.WLInput(modelSelect: tableView.rx.modelSelected(WLAddressBean.self),
                                               itemSelect: tableView.rx.itemSelected,
                                               headerRefresh: tableView.mj_header.rx.refreshing.asDriver(),
                                               addItemTaps: addItem.rx.tap.asSignal())
        
        viewModel = WLAddressViewModel(input, disposed: disposed)
        
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
                
                self.onAddressClick(type)
            })
            .disposed(by: disposed)
        
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
        
        viewModel
            .output
            .addItemed
            .drive(onNext: { [unowned self] (_) in
                
                let edit = WLAddressEditBaseViewController.createAddressEdit(self.config, isEdit: false, addressBean: WLAddressBean())
                
                self.navigationController?.pushViewController(edit, animated: true)
                
                edit
                    .rx
                    .complete
                    .subscribe(onNext: { [unowned self] (address) in
                        
                        var value = self.viewModel.output.tableData.value
                        
                        value += [address]
                        
                        self.viewModel.output.tableData.accept(value)
                    })
                    .disposed(by: edit.disposed)
            })
            .disposed(by: disposed)
    }
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let dataSource = dataSource else { return 0}
        
        return caculateHeight(indexPath, item: dataSource[indexPath])
    }
    
    open func emptyViewShow() {
        
        tableView.emptyViewShow(WLAddressEmpty())
    }
    
    open func onAddressClick(_ address: WLAddressBean) {
        
        
    }
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "删除") { [weak self] (a, ip) in
            
            guard let `self` = self else { return }
            
            let type = self.dataSource[ip]
            
            let alert = UIAlertController(title: "地址信息", message: "是否删除当前地址？", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "取消", style: .cancel) { (a) in }
            
            let confirm = UIAlertAction(title: "确定", style: .default) { [weak self] (a) in
                
                guard let `self` = self else { return }
                
                WLHudUtil.show(withStatus: "移除地址中...")
                
                WLAddressViewModel
                    .removeAddress(type.encoded)
                    .drive(onNext: { [weak self] (result) in
                        
                        guard let `self` = self else { return }
                        switch result {
                        case .ok:
                            
                            WLHudUtil.pop()
                            
                            WLHudUtil.showInfo("移除当前地址成功")
                            
                            var value = self.viewModel.output.tableData.value
                            
                            value.remove(at: ip.section)
                            
                            self.viewModel.output.tableData.accept(value)
                            
                            if value.isEmpty {
                                
                                self.emptyViewShow()
                            }
                        case .failed:
                            
                            WLHudUtil.pop()
                            
                            WLHudUtil.showInfo("移除当前地址失败")
                        default: break;
                            
                        }
                    })
                    .disposed(by: self.disposed)
            }
            
            alert.addAction(cancel)
            
            alert.addAction(confirm)
            
            self.present(alert, animated: true, completion: nil)
            //
        }
        
        return [delete]
    }
    
    override open func configNaviItem() {
        
        title = "我的地址"
    }
}
extension WLAddressBaseViewController: UITableViewDelegate { }
