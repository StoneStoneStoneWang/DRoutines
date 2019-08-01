//
//  WLSettingViewController.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLReqKit
import RxDataSources
import RxSwift
import RxCocoa
import WLBaseTableView
import WLToolsKit
import SnapKit
import DLogin
import DPrepare
import DNotification

@objc (WLSettingViewController)
public final class WLSettingViewController: WLF1DisposeViewController {
    
    public var loginConfig: WLLoginConfig!
    
    public var loginStyle: WLLoginStyle = .one
    
    public required init(_ loginStyle: WLLoginStyle,loginConfig: WLLoginConfig) {
        super.init(nibName: nil, bundle: nil)
        
        self.loginConfig = loginConfig
        
        self.loginStyle = loginStyle
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    final let tableView: WLSettingTableView = WLSettingTableView.baseTableView()
    
    override public func addOwnSubViews() {
        
        view.addSubview(tableView)
    }
    
    override public func configOwnSubViews() {
        
        tableView.snp.makeConstraints { (make) in
            
            make.right.left.bottom.equalToSuperview()
            
            make.top.equalTo(WL_TOP_LAYOUT_GUARD)
        }
        
        tableView.separatorStyle = .none
        
        tableView.register(WLSettingTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    typealias Section = WLSectionModel<(), WLSettingType>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: WLSettingViewModel!
    
    @objc public func reloadData() {
        
        viewModel.output.tableData.accept(WLSettingType.types)
    }
    
    override public func configViewModel() {
        
        let input = WLSettingViewModel.WLInput(modelSelect: tableView.rx.modelSelected(WLSettingType.self),
                                               itemSelect: tableView.rx.itemSelected)
        
        viewModel = WLSettingViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in
                
                let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! WLSettingTableViewCell
                
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
                
                switch type {
                    
                case .pwd:
                    
                    DNotificationConfigration.postNotification(withName: NSNotification.Name(DNotificationGotoFindPwd), andValue: nil, andFrom: self)

                case .password:
                    
                    DNotificationConfigration.postNotification(withName: NSNotification.Name(DNotificationGotoModifyPwd), andValue: nil, andFrom: self)
                    
                case .logout:
                    
                    self.onLogout()
                    
                case .black:
                    
                    let isLogin = self.checkLoginAndIsGoLogin(self.loginStyle,config: self.loginConfig)

                    if isLogin {

                        DNotificationConfigration.postNotification(withName: NSNotification.Name(DNotificationGotoBlack), andValue: nil, andFrom: self)
                    }
                    
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
    
    private func onLogout() {
        
        let alert = UIAlertController(title: "是否退出登录?", message: "退出登录不清除缓存信息", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (a) in
            
            
        }
        
        let confirm = UIAlertAction(title: "确定", style: .default) { [weak self] (a) in
            
            guard let `self` = self else { return }
            
            self.exit()
        }
        
        alert.addAction(cancel)
        
        alert.addAction(confirm)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func exit() {
        
        navigationController?.popViewController(animated: true)
        
        WLAccountCache.default.clearAccount()
        
        WLUserInfoCache.default.userBean = WLUserBean()
    }
}
extension WLSettingViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return datasource[indexPath].cellHeight
    }
    
    override public func configNaviItem() {
        
        title = "设置"
    }
}
