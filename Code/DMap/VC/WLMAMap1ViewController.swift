//
//  WLMAMap1ViewController.swift
//  WLMapkitDemo
//
//  Created by three stone 王 on 2019/5/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import SnapKit
import WLToolsKit
import WLBaseTableView
import RxDataSources
import RxSwift
import RxCocoa
import WLComponentView

final class WLMAMap1ViewController: WLMAMapBaseViewController {
    
    final let tableView: WLMapTableView = WLMapTableView.baseTableView()
    
    final let footerView: WLMapFooterView = WLMapFooterView(frame: .zero)
    
    override public func addOwnSubViews() {
        super.addOwnSubViews()
        
        view.addSubview(tableView)
    }
    
    public let result: BehaviorRelay<[String: String]> = BehaviorRelay<[String: String]>(value: [:])
    
    override public func configOwnSubViews() {
        super.configOwnSubViews()
        
        tableView.snp.makeConstraints { (make) in
            
            make.right.left.equalToSuperview()
            
            if let _ = tabBarController {
                
                make.bottom.equalTo(-WL_TABBAR_HEIGHT)
            } else {
                
                make.bottom.equalToSuperview()
            }
            
            make.height.equalTo(config.pubs.count * 44 + 60)
        }
        
        tableView.separatorStyle = .none
        
        tableView.register(WLMapTableViewCell.self, forCellReuseIdentifier: "cell")
        
        footerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 60)
        
        tableView.tableFooterView = footerView
        
        footerView.config = config
    }
    
    typealias Section = WLSectionModel<(), WLMapPublishBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: WLMAMapViewModel!
    
    var picker: WLDatePicker!
    
    override public func configViewModel() {
        
        let input = WLMAMapViewModel.WLInput(modelSelect: tableView.rx.modelSelected(WLMapPublishBean.self),
                                             itemSelect: tableView.rx.itemSelected,
                                             config: config,
                                             completeTaps: footerView.completeItem.rx.tap.asSignal(),
                                             tag: "顺风车")
        
        viewModel = WLMAMapViewModel(input)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in
                
                let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! WLMapTableViewCell
                
                cell.bean = item
                
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
                
                if type.type.contains("时间") {
                    
                    if self.picker == nil {
                        
                        self.picker = WLDatePicker(textColor: WLHEXCOLOR(hexColor: "#666666"), buttonColor: WLHEXCOLOR(hexColor: self.config.itemColor), font: UIFont.systemFont(ofSize: 15), locale: Locale(identifier: "zh-Hans"), showCancelButton: true)
                    }
                    
                    self.picker.show("", doneButtonTitle: "完成", cancelButtonTitle: "取消", defaultDate: Date(), minimumDate: nil, maximumDate: Date(), datePickerMode: UIDatePicker.Mode.dateAndTime, callback: { [weak self] (date) in
                        
                        if let date = date ,let `self` = self {
                            
                            let df = DateFormatter()
                            
                            df.dateFormat = "yyyy-MM-dd hh:mm:ss"
                            
                            var value = self.viewModel.output.tableData.value
                            
                            let current = value[ip.row]
                            
                            current.value = df.string(from: date)
                            
                            value.replaceSubrange(ip.row..<ip.row+1, with: [current])
                            
                            self.viewModel.output.tableData.accept(value)
                        }
                    })
                }
                
            })
            .disposed(by: disposed)
        
        viewModel
            .output
            .completed
            .drive(onNext: { (result) in
                
                printLog(message: result)
            })
            .disposed(by: disposed)
        
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
        
        addNotification()
    }
    
    override func addNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(noti: Notification) {
        
        let duration = noti.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        
        let frame = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        
        UIView.animate(withDuration: duration, animations: {
            
            self.tableView.frame = CGRect(x: 0, y: frame.minY - CGFloat(self.viewModel.output.tableData.value.count) * 44 - 60, width: frame.width, height: CGFloat(self.viewModel.output.tableData.value.count) * 44 + 60)
            
        }) { (isFinished) in
            
            
        }
    }
    deinit {
        
        removeNotification()
    }
    override func removeNotification() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillHide(noti: Notification) {
        
        let duration = noti.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        
        let frame = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        
        UIView.animate(withDuration: duration, animations: {
            
            if let _ = self.tabBarController {
                
                self.tableView.frame = CGRect(x: 0, y: frame.minY - CGFloat(self.viewModel.output.tableData.value.count) * 44 - WL_TABBAR_HEIGHT - 60, width: frame.width, height: CGFloat(self.viewModel.output.tableData.value.count) * 44 + 60)
            } else {
                
                self.tableView.frame = CGRect(x: 0, y: frame.minY - CGFloat(self.viewModel.output.tableData.value.count) * 44, width: frame.width, height: CGFloat(self.viewModel.output.tableData.value.count) * 44)
            }
            
        }) { (isFinished) in
            
            
        }
    }
    override func obtainData(_ string: String) {
        
        var value = self.viewModel.output.tableData.value
        
        let current = value[0]
        
        current.value = string
        
        value.replaceSubrange(0..<1, with: [current])
        
        self.viewModel.output.tableData.accept(value)
    }
}

extension WLMAMap1ViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
    }
}
