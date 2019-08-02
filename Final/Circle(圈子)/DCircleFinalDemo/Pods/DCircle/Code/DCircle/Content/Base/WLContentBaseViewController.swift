//
//  WLContentBaseViewController.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxDataSources
import WLBaseTableView
import WLToolsKit
import ObjectMapper
import DPrepare

@objc (WLContentBaseViewController)
open class WLContentBaseViewController: WLF1DisposeViewController{
    
    public var config: WLContentConfig!
    
    public var style: WLContentStyle = .one
    
    public var moreItem: UIButton = UIButton(type: .custom)
    
    var uid: String = ""
    
    var encoded: String = ""
    
    var circleBean: WLCircleBean!
    
    public required init(_ style: WLContentStyle,config: WLContentConfig ,circleJson: [String: Any]) {
        super.init(nibName: nil, bundle: nil)
        
        self.config = config
        
        self.style = style
        
        circleBean = WLCircleBean(JSON: circleJson)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public final let tableView: WLContentTableView = WLContentTableView.baseTableView()
    
    override open func addOwnSubViews() {
        
        view.addSubview(tableView)
        
    }
    
    override open func configOwnSubViews() {
        
        tableView.separatorStyle = .none
        
        tableView.register(WLContentTextTableViewCell.self, forCellReuseIdentifier: "text")
        
        tableView.register(WLContentImageTableViewCell.self, forCellReuseIdentifier: "image")
        
        tableView.register(WLContentVideoTableViewCell.self, forCellReuseIdentifier: "video")
    }
    
    open func configCell(_ tv: UITableView,ip: IndexPath,item: WLPublishBean) -> UITableViewCell {
        
        if item.type == "image" {
            
            let cell = tv.dequeueReusableCell(withIdentifier: "image") as! WLContentImageTableViewCell
            
            cell.icon = item.value
            
            return cell
            
        } else if item.type == "video" {
            
            let cell = tv.dequeueReusableCell(withIdentifier: "video") as! WLContentVideoTableViewCell
            
            cell.icon = item.value
            
            cell.coverImage = config.broadIcon
            
            return cell
        } else {
            
            let cell = tv.dequeueReusableCell(withIdentifier: "text") as! WLContentTextTableViewCell
            
            cell.eText = item.value
            
            return cell
        }
    }
    
    open func caculateHeight(_ ip: IndexPath,item: WLPublishBean) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        let item = datasource[ip]
        
        if item.type == "image" || item.type == "video" {
            
            return (view.bounds.width - 30) * 3 / 4 + 5
        }
        
        if item.value.isEmpty { return 0}
        
        return item.value.caculateHeight(CGSize(width: view.bounds.width - 30, height: 999), fontSize: 15) + 30
    }
    
    typealias Section = MySection<WLPublishBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: WLContentViewModel!
    
    override open func configViewModel() {
        
        let input = WLContentViewModel.WLInput(modelSelect: tableView.rx.modelSelected(WLPublishBean.self),
                                               itemSelect: tableView.rx.itemSelected,
                                               circle: circleBean)
        
        viewModel = WLContentViewModel(input)
        
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
            .subscribe(onNext: { [weak self] (type,ip) in
                
                guard let `self` = self ,let config = self.config else { return }
                
                switch type.type {
                case "image":
                    
                    let imageShow = WLImageShowViewController(type.value, back: config.backIcon)
                    
                    self.present(imageShow, animated: true, completion: nil)
                    
                case "video":
                    let video = WLVideoShowViewController(type.value, back: config.backIcon)
                    
                    self.present(video, animated: true, completion: nil)
                default:
                    break
                }
                
            })
            .disposed(by: disposed)
        
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
    }
}

extension WLContentBaseViewController: UITableViewDelegate {
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return caculateHeight(indexPath, item: datasource[indexPath])
    }
}
