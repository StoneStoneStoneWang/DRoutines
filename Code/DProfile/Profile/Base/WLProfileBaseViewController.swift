//
//  WLProfileBaseViewController.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseTableView
import RxDataSources
import WLToolsKit
import WLThirdUtil.WLHudUtil
import DPrepare
import DLogin
import DReq
import DNotification

@objc (WLProfileBaseViewController)
open class WLProfileBaseViewController: WLF1DisposeViewController {
    
    public var profileConfig: WLProfileConfig!
    
    public var profileStyle: WLProfileStyle = .one
    
    public var loginConfig: WLLoginConfig!
    
    public var loginStyle: WLLoginStyle = .one
    
    public required init(_ profileStyle: WLProfileStyle,profileConfig: WLProfileConfig,loginStyle: WLLoginStyle,loginConfig: WLLoginConfig) {
        super.init(nibName: nil, bundle: nil)
        
        self.profileStyle = profileStyle
        
        self.profileConfig = profileConfig
        
        WLProfileConfigManager.default.config = profileConfig
        
        self.loginStyle = loginStyle
        
        self.loginConfig = loginConfig
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public final let tableView: WLProfileTableView = WLProfileTableView.baseTableView()
    
    open lazy var profileHeader: WLProfileHeaderView = {
        
        return WLProfileHeaderView.createProfileHeader(self.profileStyle)
    }()
    
    typealias Section = WLSectionModel<(), WLProfileType>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: WLProfileViewModel!
    
    override open func addOwnSubViews() {
        
        view.addSubview(tableView)
    }
    
    override open func configOwnSubViews() {
        
        tableView.snp.makeConstraints { (make) in
            
            make.right.left.bottom.equalToSuperview()
            
            make.top.equalTo(WL_TOP_LAYOUT_GUARD)
        }
        
        tableView.separatorStyle = .none
        
        tableView.register(WLProfileTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override open func configViewModel() {
        
        let input = WLProfileViewModel.WLInput(modelSelect: tableView.rx.modelSelected(WLProfileType.self),
                                               itemSelect: tableView.rx.itemSelected)
        
        viewModel = WLProfileViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in
                
                let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! WLProfileTableViewCell
                
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
            .userInfo
            .bind(to: profileHeader.rx.user)
            .disposed(by: disposed)
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { [weak self] (type,ip) in
                
                guard let `self` = self else { return }
                
                self.tableView.deselectRow(at: ip, animated: true)
                
                switch type {
                case .setting: fallthrough
                case .pravicy: fallthrough
                case .about:
                    
                    DNotificationConfigration.postNotification(withName: type.notificationName, andValue: nil, andFrom: self)
                    
                case .userInfo:fallthrough
                case .address: fallthrough
                case .order: fallthrough
                case .focus: fallthrough
                case .myCircle:
                    
                    let isLogin = self.checkLogin(self.loginStyle, config: self.loginConfig)
                    
                    if isLogin {
                        
                        DNotificationConfigration.postNotification(withName: type.notificationName, andValue: nil, andFrom: self)
                    }
                case .contactUS:
                    
                    if !type.subTitle.isEmpty && WLDeviceInfo.wl_device_hasSIM()  {
                        
                        WLOpenUrl.openUrl(urlString: "telprompt://\(type.subTitle)")
                    } else {
                        
                        WLHudUtil.showInfo("请确认使用的是iPhone，切装有手机卡")
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
        
        let tapHeaderView = UITapGestureRecognizer(target: self, action: #selector(headerViewTaped))
        
        profileHeader.addGestureRecognizer(tapHeaderView)
    }
    @objc (headerViewTaped)
    func headerViewTaped() {
        
        let isLogin = checkLogin(loginStyle, config: loginConfig)
        
        if isLogin {
            
            DNotificationConfigration.postNotification(withName: WLProfileType.userInfo.notificationName, andValue: nil, andFrom: self)
        }
    }
    
    @objc (tokenInvalid)
    open func tokenInvalid() {
        
        if let tab = tabBarController {
            
            if let navi = tab.selectedViewController as? UINavigationController {
                
                navi.setViewControllers([navi.viewControllers.first!], animated: true)
            } else {
                
                if let navi = tab.viewControllers?.first as? UINavigationController{
                    
                    navi.setViewControllers([navi.viewControllers.first!], animated: true)
                }
            }
        } else {
            
            navigationController?.setViewControllers([self], animated: true)
        }
        
        tokenInvalidAlertShow(loginStyle, config: loginConfig)
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.DTokenInvalid, object: nil)
    }
    open override func configNaviItem() {
        
        title = "我的"
    }
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
    }
    
}

extension WLProfileBaseViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return datasource[indexPath].cellHeight
    }
}
