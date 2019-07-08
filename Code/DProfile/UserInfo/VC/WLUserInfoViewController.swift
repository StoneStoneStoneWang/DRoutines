//
//  WLUserInfoViewController.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLReqKit
import RxDataSources
import RxSwift
import RxCocoa
import WLBaseTableView
import WLToolsKit
import WLComponentView
import WLThirdUtil.WLHudUtil
import SnapKit
import WLBaseViewController
import DPrepare

@objc (WLUserInfoViewController)
public final class WLUserInfoViewController: WLF1DisposeViewController {
    
    public var config: WLUserInfoConfig!
    
    public required init(_ config: WLUserInfoConfig) {
        super.init(nibName: nil, bundle: nil)
        
        self.config = config
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    final let tableView: WLUserInfoTableView = WLUserInfoTableView.baseTableView()
    
    lazy var imagePicker = WLImagePickerImpl()
    
    var picker: WLDatePicker!
    
    override public func addOwnSubViews() {
        
        view.addSubview(tableView)
    }
    
    override public func configOwnSubViews() {
        
        tableView.snp.makeConstraints { (make) in
            
            make.right.left.bottom.equalToSuperview()
            
            make.top.equalTo(WL_TOP_LAYOUT_GUARD)
        }
        
        tableView.separatorStyle = .none
        
        tableView.register(WLUserInfoTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    typealias Section = WLSectionModel<(), WLUserInfoBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: WLUserInfoViewModel!
    
    override public func configViewModel() {
        
        let input = WLUserInfoViewModel.WLInput(modelSelect: tableView.rx.modelSelected(WLUserInfoBean.self),
                                                itemSelect: tableView.rx.itemSelected)
        
        viewModel = WLUserInfoViewModel(input, disposed: disposed)
        
        let config = self.config
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in
                
                let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! WLUserInfoTableViewCell
                
                cell.type = (item,config!)
                
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
                
                switch type.type {
                case .sex:
                    
                    let action = UIAlertController(title: "选择性别", message: nil , preferredStyle: .actionSheet)
                    
                    let male = UIAlertAction(title: "男", style: .default, handler: { [weak self] (a) in
                        
                        guard let `self` = self else { return }
                        
                        self.onUpdateUserInfo(type: type.type, value: "1", ip: ip)
                    })
                    
                    let female = UIAlertAction(title: "女", style: .default, handler: { [weak self] (a) in
                        
                        guard let `self` = self else { return }
                        
                        self.onUpdateUserInfo(type: type.type, value: "2", ip: ip)
                    })
                    
                    let cancel = UIAlertAction(title: "取消", style: .cancel, handler: { (a) in
                        
                        
                    })
                    
                    action.addAction(male)
                    
                    action.addAction(female)
                    
                    action.addAction(cancel)
                    
                    self.present(action, animated: true, completion: nil)
                    
                case .header:
                    
                    self.imageActionShow()
                    
                case .birth:
                    
                    if self.picker == nil {
                        
                        self.picker = WLDatePicker(textColor: WLHEXCOLOR(hexColor: "#666666"), buttonColor: WLHEXCOLOR(hexColor: self.config.itemColor), font: UIFont.systemFont(ofSize: 15), locale: Locale(identifier: "zh-Hans"), showCancelButton: true)
                    }
                    
                    self.picker.show("", doneButtonTitle: "完成", cancelButtonTitle: "取消", defaultDate: Date(), minimumDate: nil, maximumDate: Date(), datePickerMode: UIDatePicker.Mode.date, callback: { [weak self] (date) in
                        
                        if let date = date ,let `self` = self {
                            
                            let df = DateFormatter()
                            
                            df.dateFormat = "yyyy-MM-dd hh:mm:ss"
                            
                            self.onUpdateUserInfo(type: type.type, value: "\(Int(date.timeIntervalSince1970))", ip: ip)
                        }
                    })
                case .name:
                    
                    WLNameUpdateViewController
                        .rx
                        .creatUpdateName(type.subtitle, config: self.config, self)
                        .flatMapLatest({ $0.rx.complete })
                        .subscribe(onNext: { [weak self] (user) in
                            
                            guard let `self` = self else { return }
                            
                            _ = WLUserInfoCache.default.saveUser(data: user)
                            
                            self.tableView.reloadRows(at: [ip], with: .none)
                        })
                        .disposed(by: self.disposed)
                case .signature:
                    
                    WLSignatureViewController
                        .rx
                        .creatSignature(type.subtitle, config: self.config, parent: self)
                        .flatMapLatest({ $0.rx.complete })
                        .subscribe(onNext: { [weak self] (user) in
                            
                            guard let `self` = self else { return }
                            
                            _ = WLUserInfoCache.default.saveUser(data: user)
                            
                            self.tableView.reloadRows(at: [ip], with: .none)
                        })
                        .disposed(by: self.disposed)
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
    
    override public func wl_imageCameraShow() {
        
        imagePicker.openImagePicker(self, isPhoto: false, imageHandler: { [weak self] (img) in
            
            guard let `self` = self ,let img = img else { return }
            
            let data = UIImage.compressImage(img, maxLength: 500 * 1024)
            
            self.onUploadImag(type: .header, ip: IndexPath(row: 1, section: 0), data: data)
        })
    }
    
    override public func wl_imagePhotoShow() {
        
        imagePicker.openImagePicker(self, isPhoto: true, imageHandler: { [weak self] (img) in
            
            guard let `self` = self ,let img = img else { return }
            
            let data = UIImage.compressImage(img, maxLength: 30 * 1024)
            
            self.onUploadImag(type: .header, ip: IndexPath(row: 1, section: 0), data: data)
        })
    }
    
    func onUploadImag(type: WLUserInfoType,ip: IndexPath,data: Data) {
        
        WLHudUtil.show(withStatus: "上传头像中...")
        
        WLUserInfoViewModel
            .fetchAliToken()
            .drive(onNext: { [weak self] (res) in
                
                guard let `self` = self else { return }
                
                switch res {
                case let .aliToken(token):
                    
                    DispatchQueue.global().async {
                        
                        onUploadImgResp(data, file: "headerImg", param: (token as! WLALJsonBean).credentials).subscribe(onNext: { [weak self] (value) in
                            
                            guard let `self` = self else { return }
                            
                            self.viewModel.output.tableData.value[1].img =  UIImage(data: data)
                            
                            DispatchQueue.main.async {
                                
                                self.onUpdateUserInfo(type: type, value: value, ip: ip)
                            }
                            
                            }, onError: { (error) in
                                
                                WLHudUtil.pop()
                                
                                WLHudUtil.showInfo("上传头像失败")
                                
                        })
                            .disposed(by: self.disposed)
                    }
                    
                case let .failed(msg):
                    
                    WLHudUtil.pop()
                    
                    WLHudUtil.showInfo(msg)
                    
                default: break
                    
                }
            })
            .disposed(by: disposed)
    }
    
    func onUpdateUserInfo(type: WLUserInfoType,value: String ,ip: IndexPath) {
        
        WLHudUtil.show(withStatus: "修改\(type.title)中...")
        
        WLUserInfoViewModel
            .updateUserInfo(type: type, value: value)
            .drive(onNext: { [weak self] (res) in
                
                guard let `self` = self else { return }
                
                WLHudUtil.pop()
                
                switch res {
                    
                case let .updateUserInfoSucc(user, msg: msg):
                    
                    _ = WLUserInfoCache.default.saveUser(data: user as! WLUserBean)
                    
                    WLHudUtil.showInfo(msg)
                    
                    self.tableView.reloadRows(at: [ip], with: .none)
                    
                case let .failed(msg):
                    
                    switch type {
                    case .header:
                        
                        self.viewModel.output.tableData.value[1].img = nil
                        
                    default:
                        break
                    }
                    
                    WLHudUtil.showInfo(msg)
                default: break
                    
                }
            })
            .disposed(by: disposed)
    }
}

extension WLUserInfoViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return datasource[indexPath].type.cellHeight
    }
    
    override public func configNaviItem() {
        
        title = "个人信息"
    }
}
