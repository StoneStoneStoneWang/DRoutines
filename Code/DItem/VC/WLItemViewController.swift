//
//  WLItemViewController.swift
//  HOwner-iOS
//
//  Created by three stone 王 on 2019/6/13.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import WLToolsKit
import RxDataSources
import WLBaseTableView

class WLItemViewController: WLF1DisposeViewController {
    
    var type: WLItemVCType = .home
    
    final let whiteView: UIView = UIView(frame: .zero).then {
        
        $0.backgroundColor = .white
    }
    
    public required init(_ type: WLItemVCType) {
        
        itemView = WLItemView.createItem(CGSize(width: 60, height: 80), col: type == .home ? 4 : 3, total:type == .home ? WLItemType.homes.count : WLItemType.services.count)
        
        self.type = type
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    typealias Section = WLSectionModel<(), WLItemType>
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<Section>!
    
    var viewModel: WLItemViewModel!
    
    final var itemView: WLItemView!
    
    override func configViewModel() {
        
        let input = WLItemViewModel.WLInput(vcType: self.type, modelSelect: itemView.rx.modelSelected(WLItemType.self), itemSelect: itemView.rx.itemSelected)
        
        viewModel = WLItemViewModel(input, disposed: disposed)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<Section>(
            configureCell: { ds, cv, ip, item in
                
                let cell = cv.dequeueReusableCell(withReuseIdentifier: "cell", for: ip) as! WLItemViewCell
                
                cell.type = item
                
                return cell
        })
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .tableData
            .asObservable()
            .map({ [Section(model: (), items: $0)] })
            .bind(to: itemView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { [weak self] (item,ip) in
                
                guard let `self` = self else { return }
                
                switch item {
                case .service:
                    
                    let service = WLServiceBaseViewController.createService()
                    
                    self.navigationController?.pushViewController(service, animated: true)
                case .pay:
                    
                    let pay = LifePayCostCtrl()
                    
                    self.navigationController?.pushViewController(pay, animated: true)
                    
                case .eDetail:fallthrough
                case .content:fallthrough
                case .ePublic:fallthrough
                case .low: fallthrough
                case .flow:
                    
                let inner = WLSomeInnerViewController.createSomeInner("http://api.hcysq.cn/webview/\(item.reqName)uid=\(WLAccountCache.default.uid)",title: item.rawValue)
                
                self.navigationController?.pushViewController(inner, animated: true)
                default: break
                    
                }
            })
            .disposed(by: disposed)
    }
    override func addOwnSubViews() {
        
        view.addSubview(whiteView)
        
        view.addSubview(itemView)
    }
    override func configOwnSubViews() {
        
        itemView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: self.type
            == .home ? 80 + 15 : view.bounds.width / 2)
        
        if self.type == .home {
            
            whiteView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 80 + 15 + 10)
        }
        
        itemView.register(WLItemViewCell.self, forCellWithReuseIdentifier: "cell")
    }
}
