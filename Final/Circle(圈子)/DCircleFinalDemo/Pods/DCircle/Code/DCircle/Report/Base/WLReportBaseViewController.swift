//
//  WLReportBaseViewController.swift
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
import DPrepare


@objc (WLReportBaseViewController)
open class WLReportBaseViewController: WLF1DisposeViewController{
    
    public var config: WLReportConfig!
    
    public var style: WLReportStyle = .one
    
    @objc (completeItem)
    public var completeItem: UIButton = UIButton(type: .custom).then {
        
        $0.setTitle("完成", for: .normal)
        
        $0.setTitle("完成", for: .highlighted)
        
        $0.setTitle("完成", for: .disabled)
        
        $0.sizeToFit()
        
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    var uid: String = ""
    
    var encoded: String = ""
    
    public required init(_ style: WLReportStyle,config: WLReportConfig ,uid: String,encoded: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.config = config
        
        self.style = style
        
        self.uid = uid
        
        self.encoded = encoded
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public final let tableView: WLReportTableView = WLReportTableView.baseTableView()
    
    override open func addOwnSubViews() {
        
        view.addSubview(tableView)
    }
    
    public final let footerView: WLReportFooterView = WLReportFooterView(frame: .zero)
    
    override open func configOwnSubViews() {
        
        tableView.snp.makeConstraints { (make) in
            
            make.right.left.bottom.equalToSuperview()
            
            make.top.equalTo(WL_TOP_LAYOUT_GUARD)
        }
        
        tableView.separatorStyle = .none
        
        tableView.register(WLReport1TableViewCell.self, forCellReuseIdentifier: "cell")
        
        footerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 120)
        
        tableView.tableFooterView = footerView
    }
    
    open func configCell(_ tv: UITableView,ip: IndexPath,item: WLReportBean) -> UITableViewCell {
        
        let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! WLReport1TableViewCell
        
        cell.type = (item,config)
        
        return cell
    }
    
    typealias Section = MySection<WLReportBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: WLReportViewModel!
    
    var selectedReport: BehaviorRelay<String> = BehaviorRelay<String>(value: "1")
    
    override open func configViewModel() {
        
        let input = WLReportViewModel.WLInput(modelSelect: tableView.rx.modelSelected(WLReportBean.self),
                                              itemSelect: tableView.rx.itemSelected,
                                              completeTaps: completeItem.rx.tap.asSignal(),
                                              uid: uid,
                                              encode: encoded,
                                              report: selectedReport.asDriver(),
                                              content: footerView.texttv.rx.text.orEmpty.asDriver())
        
        viewModel = WLReportViewModel(input, disposed: disposed)
        
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
            .subscribe(onNext: { [unowned self] (type,ip) in
                
                var result: [WLReportBean] = []
                
                let value = self.viewModel.output.tableData.value
                
                for item in value {
                    
                    var i = item
                    
                    i.isSelected = false
                    
                    result += [i]
                }
                
                var t = type
                
                t.isSelected = true
                
                result.replaceSubrange(ip.section..<ip.section+1, with: [t])
                
                self.viewModel.output.tableData.accept(result)
                
                self.selectedReport.accept(t.type)
            })
            .disposed(by: disposed)
        
        // MARK: 举报点击中序列
        viewModel
            .output
            .completing
            .drive(onNext: { [weak self] _ in
                
                guard let `self` = self else { return }
                
                self.view.endEditing(true)
                
                WLHudUtil.show(withStatus: "举报中...")
                
            })
            .disposed(by: disposed)
        
        // MARK: 举报事件返回序列
        viewModel
            .output
            .completed
            .drive(onNext: { [weak self] in
                guard let `self` = self else { return }
                
                WLHudUtil.pop()
                
                switch $0 {
                    
                case let .failed(msg): WLHudUtil.showInfo(msg)
                    
                case .ok:
                    
                    let alert = UIAlertController(title: "举报成功", message: "您的举报非常成功,我们会尽快审核.", preferredStyle: .alert)
                    
                    
                    let cancel = UIAlertAction(title: "取消", style: .cancel) { (a) in
                        
                        
                    }
                    
                    let confirm = UIAlertAction(title: "确认", style: .default) { [weak self] (a) in
                        
                        guard let `self` = self else { return }
                        
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                    alert.addAction(cancel)
                    
                    alert.addAction(confirm)
                    
                    self.present(alert, animated: true, completion: nil)
                    
                default: break
                }
            })
            .disposed(by: disposed)
        
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
    }
    
    
}

extension WLReportBaseViewController: UITableViewDelegate {
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 55
    }
}
