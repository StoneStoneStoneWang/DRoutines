//
//  WLPublishBaseViewController.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseTableView
import RxDataSources
import WLToolsKit
import RxCocoa
import RxSwift
import SnapKit
import WLThirdUtil.WLHudUtil
import ObjectMapper
import DPrepare
import DProfile
import DUpload
import DNotification
extension WLPublishTableBaseViewController {
    
    public var complete: Observable<Mappable> {
        
        return self.completeItem.rx.tap.withLatestFrom(self.completed)
    }
}

@objc (WLPublishTableBaseViewController)
open class WLPublishTableBaseViewController: WLF1DisposeViewController ,UITableViewDelegate {
    
    fileprivate var pTag: String = ""
    
    var pTitle: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    @objc (completeItem)
    public var completeItem: UIButton = UIButton(type: .custom)
    
    var textItem: UIButton = UIButton(type: .custom)
    
    var imageItem: UIButton = UIButton(type: .custom)
    
    var videoItem: UIButton = UIButton(type: .custom)
    
    var style: WLPublishStyle = .mix
    
    var config: WLPublishConfig!
    
    var completed: PublishRelay<Mappable> = PublishRelay<Mappable>()
    
    var mDelegate: WLPublishDelegate!
    
    required public init(_ tag: String ,style: WLPublishStyle ,config: WLPublishConfig ,delegate: WLPublishDelegate?) {
        super.init(nibName: nil, bundle: nil)
        
        pTag = tag
        
        self.style = style
        
        self.config = config
        
        self.mDelegate = delegate
    }
    
    var isAdd: Bool = true
    
    var currentIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    typealias Section = MySection<WLPublishBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: WLPublishViewModel!
    
    public var tableView: WLPublishTableView = WLPublishTableView.baseTableView()
    
    public var headerView: WLPublishTableHeaderView = WLPublishTableHeaderView(frame: .zero)
    
    lazy var imagePicker = WLImagePickerImpl()
    
    lazy var videoPicker = WLVideoPickerImpl()
    
    open override func addOwnSubViews() {
        
        view.addSubview(tableView)
        
    }
    
    override open func configOwnSubViews() {
        
        tableView.snp.makeConstraints { (make) in
            
            make.right.left.bottom.equalToSuperview()
            
            make.top.equalTo(WL_TOP_LAYOUT_GUARD)
        }
        
        tableView.separatorStyle = .none
        
        tableView.register(WLPublishImageTableViewCell.self, forCellReuseIdentifier: "image")
        
        tableView.register(WLPublishVideoTableViewCell.self, forCellReuseIdentifier: "video")
        
        tableView.register(WLPublishTextTableViewCell.self, forCellReuseIdentifier: "text")
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 60)
        
        tableView.tableHeaderView = headerView
    }
    
    open func configCell(_ tv: UITableView,ip: IndexPath,item: WLPublishBean) -> UITableViewCell {
        
        if item.type == "image" {
            
            let cell = tv.dequeueReusableCell(withIdentifier: "image") as! WLPublishImageTableViewCell
            
            cell.img = item.img
            
            return cell
        } else if item.type == "video" {
            
            let cell = tv.dequeueReusableCell(withIdentifier: "video") as! WLPublishVideoTableViewCell
            
            cell.img = item.img
            
            return cell
        } else {
            
            let cell = tv.dequeueReusableCell(withIdentifier: "text") as! WLPublishTextTableViewCell
            
            cell.eText = item.value
            
            return cell
        }
        
    }
    
    override open func configNaviItem() {
        
        title = "发布"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: completeItem)
    }
}
extension WLPublishTableBaseViewController {
    
    open override func configViewModel() {
        
        let input = WLPublishViewModel.WLInput(tag: pTag,
                                               title: headerView.tf.rx.text.orEmpty.asDriver(),
                                               modelSelect: tableView.rx.modelSelected(WLPublishBean.self),
                                               itemSelect: tableView.rx.itemSelected,
                                               completeTaps: completeItem.rx.tap.asSignal(),
                                               textTaps: textItem.rx.tap.asSignal(),
                                               imageTaps: imageItem.rx.tap.asSignal(),
                                               videoTaps: videoItem.rx.tap.asSignal())
        
        viewModel = WLPublishViewModel(input, style: style)
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .top, reloadAnimation: .none, deleteAnimation: .left),
            
            configureCell: { [unowned self] ds, tv, ip, item in
                
                return self.configCell(tv, ip: ip, item: item)
            }
            ,canEditRowAtIndexPath: {_,_ in
                
                return true
        })
        
        self.dataSource = dataSource
        
        viewModel
            .input
            .tableData
            .asDriver()
            .map({ $0.map({ Section(header: $0.identity, items: [$0]) }) })
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        viewModel
            .output
            .textTaped
            .drive(onNext: { [unowned self](_) in
                
                self.currentIndexPath = IndexPath(row: 0, section: self.viewModel.input.tableData.value.count)
                
                self.isAdd = true
                
                var pub = WLPublishBean()
                
                pub.type = "txt"
                
                var res = self.viewModel.input.tableData.value
                
                res += [pub]
                
                WLTextEditBaseViewController
                    .rx
                    .creatTextEdit("", config: self.config, parent: self).flatMapLatest({
                        
                        $0.rx.complete
                    })
                    .subscribe(onNext: { [unowned self] (text) in
                        
                        var p = res[self.currentIndexPath.section]
                        
                        p.value = text
                        
                        res.replaceSubrange(self.currentIndexPath.section..<self.currentIndexPath.section+1, with: [p])
                        
                        self.viewModel.input.tableData.accept(res)
                        
                    }).disposed(by: self.disposed)
            })
            .disposed(by: disposed)
        
        viewModel
            .output
            .imageTaped
            .drive(onNext: { [weak self] (_) in
                
                guard let `self` = self else { return }
                
                self.isAdd = true
                
                self.currentIndexPath = IndexPath(row: 0, section: self.viewModel.input.tableData.value.count)
                
                self.imageActionShow()
            })
            .disposed(by: disposed)
        
        viewModel
            .output
            .videoTaped
            .drive(onNext: { [weak self] (_) in
                
                guard let `self` = self else { return }
                
                self.isAdd = true
                
                self.currentIndexPath = IndexPath(row: 0, section: self.viewModel.input.tableData.value.count)
                
                self.videoActionShow()
            })
            .disposed(by: disposed)
        
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
        
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { [weak self](item,ip) in
                
                guard let `self` = self else { return }
                
                self.currentIndexPath = ip
                
                self.isAdd = false
                
                switch item.type {
                case "image":
                    
                    self.imageActionShow()
                case "video":
                    
                    self.videoActionShow()
                    
                default:
                    
                    WLTextEditBaseViewController
                        .rx
                        .creatTextEdit(item.value, config: self.config, parent: self).flatMapLatest({
                            
                            $0.rx.complete
                        })
                        .subscribe(onNext: { [weak self] (text) in
                            
                            guard let `self` = self else { return }
                            
                            var res = self.viewModel.input.tableData.value
                            
                            var pub = res[ip.section]
                            
                            pub.value = text
                            
                            res.replaceSubrange(ip.section..<ip.section+1, with: [pub])
                            
                            self.viewModel.input.tableData.accept(res)
                            
                        }).disposed(by: self.disposed)
                    
                    break
                }
                
            })
            .disposed(by: disposed)
        
        viewModel
            .output
            .completing
            .drive(onNext: { [weak self] _ in
                
                guard let `self` = self else { return }
                
                self.view.endEditing(true)
                
                WLHudUtil.show(withStatus: "您发布的内容会在我们的系统1小时内审核，发布中...")
                
            })
            .disposed(by: disposed)
        
        // MARK: 登录事件返回序列
        viewModel
            .output
            .completed
            .drive(onNext: { [weak self] in
                guard let `self` = self else { return }
                
                WLHudUtil.pop()
                
                switch $0 {
                    
                case let .failed(msg): WLHudUtil.showInfo(msg)
                    
                case let .operation(obj):
                    
                    self.completed.accept(obj)
                    
                    WLHudUtil.showInfo("发布成功")
                    
                    DNotificationConfigration.postNotification(withName: NSNotification.Name(DNotificationCirclePublishSucc), andValue: ["tag":self.pTag,"circleJson":obj.toJSON()], andFrom: self)
                    
                default: break
                }
            })
            .disposed(by: disposed)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        let item = datasource[indexPath]
        
        if item.type == "image" || item.type == "video" {
            
            return 150
        }
        
        if item.value.isEmpty { return 0}
        
        return item.value.caculateHeight(CGSize(width: view.bounds.width - 30, height: 999), fontSize: 15) + 30
    }
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "删除") { [weak self] (a, ip) in
            
            guard let `self` = self else { return }
            
            let alert = UIAlertController(title: "发布信息", message: "是否删除此条信息？", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "取消", style: .cancel) { (a) in }
            
            let confirm = UIAlertAction(title: "确定", style: .default) { [weak self] (a) in
                
                guard let `self` = self else { return }
                
                var value = self.viewModel.input.tableData.value
                
                value.remove(at: indexPath.section)
                
                self.viewModel.input.tableData.accept(value)
            }
            
            alert.addAction(cancel)
            
            alert.addAction(confirm)
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
        return [delete]
    }
}
extension WLPublishTableBaseViewController {
    
    override open func wl_imageCameraShow() {
        
        imagePicker.openImagePicker(self, isPhoto: false, imageHandler: { [weak self] (img) in
            
            guard let `self` = self ,let img = img else { return }
            
            let data = UIImage.compressImage(img, maxLength: 500 * 1024)
            
            self.onUploadImag( ip: IndexPath(row: 0, section: 0), data: data)
        })
    }
    override open func wl_imagePhotoShow() {
        
        imagePicker.openImagePicker(self, isPhoto: true, imageHandler: { [weak self] (img) in
            
            guard let `self` = self ,let img = img else { return }
            
            let data = UIImage.compressImage(img, maxLength: 30 * 1024)
            
            self.onUploadImag( ip: IndexPath(row: 1, section: 0), data: data)
        })
    }
    
    func onUploadImag(ip: IndexPath,data: Data) {
        
        WLHudUtil.show(withStatus: "上传图片中...")
        
        WLUserInfoViewModel
            .fetchAliToken()
            .drive(onNext: { [weak self] (res) in
                
                guard let `self` = self else { return }
                
                switch res {
                    
                case .fetchSomeObject(let obj):
                    
                    DispatchQueue.global().async {
                        
                        onUploadPubImgResp(data, file: "pubImg\(self.currentIndexPath.section)", param: obj as! DALCredentialsBean)
                            .subscribe(onNext: { [weak self] (value) in
                                
                                guard let `self` = self else { return }
                                
                                var res = self.viewModel.input.tableData.value
                                
                                if self.isAdd {
                                    
                                    var img = WLPublishBean()
                                    
                                    img.img = UIImage(data: data)
                                    
                                    img.type = "image"
                                    
                                    img.value = value
                                    
                                    res += [img]
                                    
                                } else {
                                    
                                    var img = res[self.currentIndexPath.section]
                                    
                                    img.value = value
                                    
                                    img.img = UIImage(data: data)
                                    
                                    res.replaceSubrange(self.currentIndexPath.section..<self.currentIndexPath.section+1, with: [img])
                                    
                                }
                                WLHudUtil.pop()
                                
                                WLHudUtil.showInfo("上传图片成功")
                                
                                DispatchQueue.main.async {
                                    
                                    self.viewModel.input.tableData.accept(res)
                                }
                                
                                }, onError: { (error) in
                                    
                                    WLHudUtil.pop()
                                    
                                    WLHudUtil.showInfo("上传图片失败")
                                    
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
    
    open override func wl_videoPhotoShow() {
        
        videoPicker.openVideoPicker(self, isPhoto: true) { (url) in
            
            if let url = url {
                
                WLHudUtil.show(withStatus: "视频格式转换中...")
                
                let u = WLVideoConvert.movFileTransformToMp4WithSourceUrl(sourceUrl: url)
                
                if let u = u {
                    
                    do {
                        let data = try Data(contentsOf: u)
                        
                        WLHudUtil.show(withStatus: "视频格式转换成功")
                        
                        WLHudUtil.show(withStatus: "视频上传中...")
                        
                        WLUserInfoViewModel
                            .fetchAliToken()
                            .drive(onNext: { [weak self] (res) in
                                
                                guard let `self` = self else { return }
                                
                                switch res {
                                case .fetchSomeObject(let obj):
                                    
                                    DispatchQueue.global().async {
                                        onUploadVideoResp(data, file: "circle", param: obj as! DALCredentialsBean)
                                            .subscribe(onNext: { [weak self] (value) in
                                                
                                                guard let `self` = self else { return }
                                                
                                                var res = self.viewModel.input.tableData.value
                                                
                                                if self.isAdd {
                                                    
                                                    var img = WLPublishBean()
                                                    
                                                    img.img = UIImage(data: data)
                                                    
                                                    img.type = "video"
                                                    
                                                    img.value = value
                                                    
                                                    img.img = WLVideoConvert.getVideoCropPicture(videoUrl: u)
                                                    
                                                    res += [img]
                                                    
                                                } else {
                                                    
                                                    var img = res[self.currentIndexPath.section]
                                                    
                                                    img.value = value
                                                    
                                                    img.img = WLVideoConvert.getVideoCropPicture(videoUrl: u)
                                                    
                                                    res.replaceSubrange(self.currentIndexPath.section..<self.currentIndexPath.section+1, with: [img])
                                                    
                                                }
                                                WLHudUtil.pop()
                                                
                                                WLHudUtil.showInfo("上传视频成功")
                                                
                                                DispatchQueue.main.async {
                                                    
                                                    self.viewModel.input.tableData.accept(res)
                                                }
                                                
                                                }, onError: { (error) in
                                                    
                                                    WLHudUtil.pop()
                                                    
                                                    WLHudUtil.showInfo("上传视频失败")
                                                    
                                            })
                                            .disposed(by: self.disposed)
                                    }
                                    
                                case let .failed(msg):
                                    
                                    WLHudUtil.pop()
                                    
                                    WLHudUtil.showInfo(msg)
                                    
                                default: break
                                    
                                }
                            })
                            .disposed(by:self.disposed)
                        
                        
                    } catch  {
                        
                        WLHudUtil.pop()
                        
                        WLHudUtil.showInfo("视频格式转换失败!")
                    }
                    
                } else {
                    
                    WLHudUtil.pop()
                    
                    WLHudUtil.showInfo("视频格式转换失败!")
                }
            }
        }
    }
    open override func wl_videoCameraShow() {
        
        videoPicker.openVideoPicker(self, isPhoto: false ) { (url) in
            
            if let url = url {
                
                WLHudUtil.show(withStatus: "视频格式转换中...")
                
                let u = WLVideoConvert.movFileTransformToMp4WithSourceUrl(sourceUrl: url)
                
                if let u = u {
                    
                    do {
                        let data = try Data(contentsOf: u)
                        
                        WLHudUtil.show(withStatus: "视频格式转换成功")
                        
                        WLHudUtil.show(withStatus: "视频上传中...")
                        
                        WLUserInfoViewModel
                            .fetchAliToken()
                            .drive(onNext: { [weak self] (res) in
                                
                                guard let `self` = self else { return }
                                
                                switch res {
                                case .fetchSomeObject(let obj):
                                    
                                    DispatchQueue.global().async {
                                        onUploadVideoResp(data, file: "circle", param: obj as! DALCredentialsBean)
                                            .subscribe(onNext: { [weak self] (value) in
                                                
                                                guard let `self` = self else { return }
                                                
                                                var res = self.viewModel.input.tableData.value
                                                
                                                if self.isAdd {
                                                    
                                                    var img = WLPublishBean()
                                                    
                                                    img.img = UIImage(data: data)
                                                    
                                                    img.type = "video"
                                                    
                                                    img.value = value
                                                    
                                                    img.img = WLVideoConvert.getVideoCropPicture(videoUrl: u)
                                                    
                                                    res += [img]
                                                    
                                                } else {
                                                    
                                                    var img = res[self.currentIndexPath.section]
                                                    
                                                    img.value = value
                                                    
                                                    img.img = WLVideoConvert.getVideoCropPicture(videoUrl: u)
                                                    
                                                    res.replaceSubrange(self.currentIndexPath.section..<self.currentIndexPath.section+1, with: [img])
                                                    
                                                }
                                                WLHudUtil.pop()
                                                
                                                WLHudUtil.showInfo("上传视频成功")
                                                
                                                DispatchQueue.main.async {
                                                    
                                                    self.viewModel.input.tableData.accept(res)
                                                }
                                                
                                                }, onError: { (error) in
                                                    
                                                    WLHudUtil.pop()
                                                    
                                                    WLHudUtil.showInfo("上传视频失败")
                                                    
                                            })
                                            .disposed(by: self.disposed)
                                    }
                                    
                                case let .failed(msg):
                                    
                                    WLHudUtil.pop()
                                    
                                    WLHudUtil.showInfo(msg)
                                    
                                default: break
                                    
                                }
                            })
                            .disposed(by:self.disposed)
                        
                    } catch  {
                        
                        WLHudUtil.pop()
                        
                        WLHudUtil.showInfo("视频格式转换失败!")
                    }
                    
                } else {
                    
                    WLHudUtil.pop()
                    
                    WLHudUtil.showInfo("视频格式转换失败!")
                }
            }
        }
    }
}
