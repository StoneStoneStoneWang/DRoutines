//
//  WLCommentBaseViewController.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxDataSources
import WLBaseTableView
import WLToolsKit
import WLThirdUtil.WLHudUtil
import RxCocoa
import RxSwift
import SnapKit
import ObjectMapper
import DPrepare

@objc (WLCommentBaseViewController)
open class WLCommentBaseViewController: WLF1DisposeViewController ,WLCommentNormalTableViewCellDelegate{
    
    public var config: WLCommentConfig!
    
    public var style: WLCommentStyle = .one
    
    public var moreItem: UIButton = UIButton(type: .custom)
    
    var uid: String = ""
    
    var encoded: String = ""
    
    var mDelegate: WLCommentDelegate!
    
    public required init(_ style: WLCommentStyle,config: WLCommentConfig ,uid: String,encoded: String ,delegate: WLCommentDelegate) {
        super.init(nibName: nil, bundle: nil)
        
        self.config = config
        
        self.style = style
        
        self.uid = uid
        
        self.encoded = encoded
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public final let tableView: WLCommentTableView = WLCommentTableView.baseTableView()
    
    override open func addOwnSubViews() {
        
        view.addSubview(tableView)
    }
    
    override open func configOwnSubViews() {
        
        tableView.snp.makeConstraints { (make) in
            
            make.right.left.bottom.equalToSuperview()
            
            make.top.equalTo(WL_TOP_LAYOUT_GUARD)
        }
        
        tableView.separatorStyle = .none
        
        tableView.register(WLCommentEmptyTableViewCell.self, forCellReuseIdentifier: "empty")
        
        tableView.register(WLCommentNormalTableViewCell.self, forCellReuseIdentifier: "normal")
        
        tableView.register(WLCommentNoMoreTableViewCell.self, forCellReuseIdentifier: "noMore")
        
        tableView.register(WLCommentTotalTableViewCell.self, forCellReuseIdentifier: "total")
        
        tableView.register(WLCommentRectangleTableViewCell.self, forCellReuseIdentifier: "rectangle")
        
        tableView.register(WLCommentFailedTableViewCell.self, forCellReuseIdentifier: "failed")
        
    }
    
    open func configCell(_ tv: UITableView,ip: IndexPath,item: WLCommentBean) -> UITableViewCell {
        
        if item.type == .normal {
            
            let cell = tv.dequeueReusableCell(withIdentifier: "normal") as! WLCommentNormalTableViewCell
            
            cell.type = (item,config)
            
            cell.mDelegate = self
            
            return cell
        } else if item.type == .empty {
            
            let cell = tv.dequeueReusableCell(withIdentifier: "empty") as! WLCommentEmptyTableViewCell
            
            cell.type = (item,config)
            
            return cell
        } else if item.type == .noMore{
            
            let cell = tv.dequeueReusableCell(withIdentifier: "noMore") as! WLCommentNoMoreTableViewCell
            
            cell.type = (item,config)
            
            return cell
        } else if item.type == .rectangle {
            
            let cell = tv.dequeueReusableCell(withIdentifier: "rectangle") as! WLCommentRectangleTableViewCell
            
            cell.type = (item,config)
            
            return cell
            
        } else if item.type == .failed {
            
            let cell = tv.dequeueReusableCell(withIdentifier: "failed") as! WLCommentFailedTableViewCell
            
            cell.type = (item,config)
            
            return cell
            
        }  else if item.type == .total {
            
            let cell = tv.dequeueReusableCell(withIdentifier: "total") as! WLCommentTotalTableViewCell
            
            cell.type = (item,config)
            
            return cell
            
        } else {
            
            let cell = tv.dequeueReusableCell(withIdentifier: "total") as! WLCommentTotalTableViewCell
            
            cell.type = (item,config)
            
            return cell
        }
    }
    
    open func caculateHeight(_ ip: IndexPath,item: WLCommentBean) -> CGFloat {
        
        if item.type == .empty { return 100 }
            
        else if item.type == .normal {
            
            return item.content.caculateHeight(CGSize(width: view.bounds.width - 120 + 20 , height: 999), fontSize: 15) + 70
        }
            
        else if item.type == .total { return 55 }
            
        else if item.type == .rectangle { return 10 }
            
        else if item.type == .noMore { return 60 }
            
        else { return 120 }
    }
    
    typealias Section = MySection<WLCommentBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: WLCommentViewModel!
    
    override open func configViewModel() {
        
        let input = WLCommentViewModel.WLInput(modelSelect: tableView.rx.modelSelected(WLCommentBean.self),
                                               itemSelect: tableView.rx.itemSelected,
                                               headerRefresh: tableView.mj_header.rx.refreshing.asDriver(),
                                               footerRefresh: tableView.mj_footer.rx.refreshing.asDriver(),
                                               encoded: encoded)
        
        viewModel = WLCommentViewModel(input, disposed: disposed)
        
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
                guard let _ = self else { return }
                switch res {
                    
                case let .failed(msg): WLHudUtil.showInfo(msg)
                    
                default: break
                }
            })
            .disposed(by: disposed)
        
        let endFooterRefreshing = viewModel.output.endFooterRefreshing
        
        endFooterRefreshing
            .map({ _ in return true })
            .drive(tableView.mj_footer.rx.endRefreshing)
            .disposed(by: disposed)
        
        endFooterRefreshing
            .drive(onNext: { [weak self] (res) in
                guard let _ = self else { return }
                switch res {
                    
                case let .failed(msg): WLHudUtil.showInfo(msg)
                    
                default: break
                }
            })
            .disposed(by: disposed)
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { [unowned self] (type,ip) in
                
                if type.type == .failed {
                    
                    self.tableView.mj_header.beginRefreshing()
                }
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
    
    func commentSucc(_ comment: Mappable) {
        
        var value = viewModel.output.tableData.value
        
        if value.last!.type == .empty {
            
            value.removeLast()
            
            value.insert(comment as! WLCommentBean, at: 2)
            
            viewModel.output.tableData.accept(value)
            
        } else if value.last!.type == .failed{
            
            tableView.mj_header.beginRefreshing()
            
        } else {
            
            value.insert(comment as! WLCommentBean, at: 2)
            
            viewModel.output.tableData.accept(value)
        }
        
        self.tableView.scrollsToTop = true
    }
    func onMoreItemClick() {
        
        guard let delegate = mDelegate else { return }
        
        delegate.onMoreItemClick()
    }
}

extension WLCommentBaseViewController: UITableViewDelegate {
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return caculateHeight(indexPath, item: datasource[indexPath])
    }
}
