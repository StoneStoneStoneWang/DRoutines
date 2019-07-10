//
//  WLCircleBaseViewController.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/7.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxDataSources
import WLBaseTableView
import WLToolsKit
import WLThirdUtil.WLHudUtil
import SnapKit
import ObjectMapper
import DPrepare
import DLogin

@objc (WLCircleBaseViewController)
open class WLCircleBaseViewController: WLLoadingDisposeF1ViewController ,WLCircleBaseTableViewCellDelegate{
    
    
    public var config: WLCircleConfig!
    
    public var style: WLCircleStyle = .one
    
    public var tag: String = ""
    
    public var loginConfig: WLLoginConfig!
    
    public var loginStyle: WLLoginStyle = .one
    
    public var mDelegate: WLCircleDelegate!
    
    public required init(_ tag: String,isMy: Bool,style: WLCircleStyle,config: WLCircleConfig ,loginStyle: WLLoginStyle,loginConfig: WLLoginConfig,delegate: WLCircleDelegate!) {
        super.init(nibName: nil, bundle: nil)
        
        self.tag = tag
        
        self.config = config
        
        self.style = style
        
        self.loginStyle = loginStyle
        
        self.loginConfig = loginConfig
        
        self.mDelegate = delegate
        
        self.isMy = isMy
    }
    
    var isMy: Bool = false
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public final let tableView: WLCircleTableView = WLCircleTableView.baseTableView()
    
    override open func addOwnSubViews() {
        
        view.addSubview(tableView)
    }
    
    override open func configOwnSubViews() {
        
        tableView.snp.makeConstraints { (make) in
            
            make.right.left.bottom.equalToSuperview()
            
            make.top.equalTo(WL_TOP_LAYOUT_GUARD)
        }
        
        tableView.separatorStyle = .none
        
        tableView.register(WLCircle1TableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    open func configCell(_ tv: UITableView,ip: IndexPath,item: WLCircleBean) -> UITableViewCell {
        
        let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! WLCircle1TableViewCell
        
        cell.type = (item,config)
        
        cell.mDelegate = self
        
        return cell
    }
    
    open func caculateHeight(_ ip: IndexPath,item: WLCircleBean) -> CGFloat {
        
        if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
            
            if version > "1.1.0" {
                
                return 120 + 40
            }
        }
        
        return 120
    }
    
    typealias Section = MySection<WLCircleBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: WLCircleViewModel!
    
    @objc (insertCircle:)
    public func insertCircle(_ circleJson: [String: Any]) {
        
        //        printLog(message: Thread.current)
        
        var value = viewModel.output.tableData.value
        
        if value.isEmpty {
            
            self.tableView.emptyViewHidden()
        }
        
        value.insert(WLCircleBean(JSON: circleJson)!, at: 0)
        
        viewModel.output.tableData.accept(value)
        
    }
    
    override open func configViewModel() {
        
        self.tableView.mj_header.beginRefreshing()
        
        self.tableView.mj_footer.isHidden = true
        
        let input = WLCircleViewModel.WLInput(isMy: isMy,
                                              modelSelect: tableView.rx.modelSelected(WLCircleBean.self),
                                              itemSelect: tableView.rx.itemSelected,
                                              headerRefresh: tableView.mj_header.rx.refreshing.asDriver(),
                                              footerRefresh: tableView.mj_footer.rx.refreshing.asDriver(),
                                              tag: tag)
        
        viewModel = WLCircleViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .left),
            decideViewTransition: { _,_,_  in return .reload },
            configureCell: { [unowned self] ds, tv, ip, item in return self.configCell(tv, ip: ip, item: item) })
        
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
                    
                    self.tableView.emptyViewShow(WLCircle1Empty())
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
        
        let endFooterRefreshing = viewModel.output.endFooterRefreshing
        
        endFooterRefreshing
            .map({ _ in return true })
            .drive(tableView.mj_footer.rx.endRefreshing)
            .disposed(by: disposed)
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { [unowned self] (type,ip) in
                
                guard let delegate = self.mDelegate else { return }
                
                delegate.onCircleClick(self, circlJson: type.toJSON(),uid: type.users.encoded,encoded: type.encoded)
                
            })
            .disposed(by: disposed)
        
        
        viewModel
            .output
            .footerHidden
            .bind(to: tableView.mj_footer.rx.isHidden)
            .disposed(by: disposed)
        
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
    }
    
    public func onWatchItemClick(_ cirleBean: WLCircleBean) {
        
        guard let delegate = self.mDelegate else { return }
        
        delegate.onCircleClick(self, circlJson: cirleBean.toJSON(),uid: cirleBean.users.encoded,encoded: cirleBean.encoded)
    }
    
    public func onCommentItemClick(_ cirleBean: WLCircleBean) {
        
        guard let delegate = self.mDelegate else { return }
        
        delegate.onCircleClick(self, circlJson: cirleBean.toJSON(),uid: cirleBean.users.encoded,encoded: cirleBean.encoded)
    }
    
    public func onFunItemClick(_ cirleBean: WLCircleBean) {
        
        let isLogin = checkLoginAndIsGoLogin(loginStyle, config: loginConfig)
        
        if isLogin {
            
            if cirleBean.isLaud {
                
                let alert = UIAlertController(title: "取消点赞？", message: "", preferredStyle: .alert)
                
                let cancel = UIAlertAction(title: "取消", style: .cancel) { (a) in
                    
                    
                }
                
                let confirm = UIAlertAction(title: "确定", style: .default) { [weak self] (a) in
                    
                    guard let `self` = self else { return }
                    
                    WLHudUtil.show(withStatus: "取消点赞中...")
                    
                    WLCircleViewModel
                        .like(cirleBean.encoded, isLike: false)
                        .drive(onNext: { [weak self] (result) in
                            
                            guard let `self` = self else { return }
                            
                            WLHudUtil.pop()
                            
                            switch result {
                            case let .ok(msg):
                                
                                cirleBean.countLaud -= 1
                                
                                cirleBean.isLaud = false
                                
                                let value = self.viewModel.output.tableData.value
                                
                                self.viewModel.output.tableData.accept(value)
                                
                                WLHudUtil.showInfo(msg)
                            case let .failed(msg): WLHudUtil.showInfo(msg)
                            default: break
                                
                            }
                            
                        })
                        .disposed(by: self.disposed)
                    
                }
                
                alert.addAction(cancel)
                
                alert.addAction(confirm)
                
                present(alert, animated: true, completion: nil)
                
            } else {
                
                WLHudUtil.show(withStatus: "点赞中...")
                
                WLCircleViewModel
                    .like(cirleBean.encoded, isLike: true)
                    .drive(onNext: { [weak self] (result) in
                        
                        guard let `self` = self else { return }
                        
                        WLHudUtil.pop()
                        
                        switch result {
                        case let .ok(msg):
                            
                            cirleBean.isLaud = true
                            
                            cirleBean.countLaud += 1
                            
                            let value = self.viewModel.output.tableData.value
                            
                            self.viewModel.output.tableData.accept(value)
                            
                            WLHudUtil.showInfo(msg)
                            
                        case let .failed(msg): WLHudUtil.showInfo(msg)
                        default: break
                            
                        }
                        
                    })
                    .disposed(by: self.disposed)
            }
        }
    }
    
    open func onMoreItemClick(_ cell: UITableViewCell, item: WLCircleBean) {
        
        let login = checkLoginAndIsGoLogin(loginStyle, config: loginConfig)
        
        if login {
            
            let delegate = mDelegate
            
            let action = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let cancel = UIAlertAction(title: "取消", style: .cancel) { (a) in
                
                
            }
            
            let report = UIAlertAction(title: "举报", style: .default) { [weak self] (a) in
                
                guard let `self` = self ,let delegate = delegate else { return }
                
                delegate.onReportClick(self, uid: item.users.encoded,encoded: item.encoded)
            }
            
            let black = UIAlertAction(title: "拉黑(谨慎使用)", style: .default) { [weak self] (a) in
                
                guard let `self` = self else { return }
                
                WLHudUtil.show(withStatus: "拉黑中...")
                
                WLCircleViewModel
                    .addBlack(item.users.encoded, targetEncoded: item.encoded, content: "")
                    .drive(onNext: { (res) in
                        
                        WLHudUtil.pop()
                        switch res {
                        case .ok(let msg):
                            
                            self.tableView.mj_header.beginRefreshing()
                            
                            WLHudUtil.showInfo(msg)
                        case .failed(let msg): WLHudUtil.showInfo(msg)
                        default: break
                            
                        }
                    })
                    .disposed(by: self.disposed)
            }
            
            let focus = UIAlertAction(title: "关注", style: .default) { [weak self] (a) in
                
                guard let `self` = self else { return }
                
                WLCircleViewModel
                    .focus(item.users.encoded, encode: item.encoded)
                    .drive(onNext: { (res) in
                        
                        WLHudUtil.pop()
                        
                        switch res {
                        case .ok(let msg): WLHudUtil.showInfo(msg)
                        case .failed(let msg): WLHudUtil.showInfo(msg)
                        default: break
                            
                        }
                    })
                    .disposed(by: self.disposed)
            }
            
            if item.users.encoded != WLAccountCache.default.uid {
                
                action.addAction(black)
                
                if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
                    
                    if version > "1.1.0" && !isMy {
                        
                        action.addAction(focus)
                    }
                }
            }
            
            if let info = Bundle.main.infoDictionary  {
                
                let displayname = info["CFBundleDisplayName"] as? String ?? ""
                
                let share = UIAlertAction(title: "分享", style: .default) { [weak self] (a) in
                    
                    guard let `self` = self ,let delegate = self.mDelegate else { return }
                    
                    delegate.onShareClick(self, webUrl: "https://zhih.ecsoi.com/mob/circleFriends_wexCircleFriendsInfo?cfs.encoded=\(item.encoded)",title: displayname, desc: "\(displayname)欢迎您")
                }
                
                action.addAction(share)
            }
            
            if !isMy {
                
                action.addAction(report)
            }
            
            action.addAction(cancel)
            
            present(action, animated: true, completion: nil)
        }
    }
    open override func onReload() {
        
        tableView.mj_header.beginRefreshing()
    }
}

extension WLCircleBaseViewController: UITableViewDelegate {
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return caculateHeight(indexPath, item: datasource[indexPath])
    }
}
