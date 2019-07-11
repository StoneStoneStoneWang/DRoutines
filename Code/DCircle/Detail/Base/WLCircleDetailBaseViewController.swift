//
//  WLCircleDetailViewController.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import WLToolsKit
import RxCocoa
import RxSwift
import WLThirdUtil.WLHudUtil
import WLBaseViewController
import DPrepare
import DLogin

class WLCircleDetailTF: UITextField {
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        var rect = super.editingRect(forBounds: bounds)
        
        rect.origin.x = 15
        
        rect.size.width -= 15
        
        return rect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        var rect = super.textRect(forBounds: bounds)
        
        rect.origin.x = 15
        
        rect.size.width -= 15
        
        return rect
        
    }
}

open class WLCircleDetailBaseViewController: WLF1DisposeViewController ,WLCommentDelegate{
    
    final let topView: UIView = UIView()
    
    final let tf: WLCircleDetailTF = WLCircleDetailTF(frame: .zero)
    
    final let coverItem: UIButton = UIButton(type: .custom)
    
    var headerHeight: CGFloat = 0
    
    var viewModel: WLCircleDetailViewModel!
    
    var encode: String = ""
    
    var commentStyle: WLCommentStyle = .one
    
    var commentConfig: WLCommentConfig!
    
    var contentStyle: WLContentStyle = .one
    
    var contentConfig: WLContentConfig!
    
    var loginStyle: WLLoginStyle = .one
    
    var loginConfig: WLLoginConfig!
    
    var circleBean: WLCircleBean!
    
    var circleJson: [String : Any]!
    
    var delegate: WLCircleDetailDelegate!
    
    public required init(_ contentStyle: WLContentStyle ,contentConfig: WLContentConfig,commentStyle: WLCommentStyle ,commentConfig: WLCommentConfig ,loginStyle: WLLoginStyle,loginConfig: WLLoginConfig,uid: String,encoded: String,circleJson: [String : Any] ,delegate: WLCircleDetailDelegate) {
        
        //        printLog(message: "init1")
        
        self.encode = encoded
        
        self.contentStyle = contentStyle
        
        self.contentConfig = contentConfig
        
        self.commentStyle = commentStyle
        
        self.commentConfig = commentConfig
        
        self.loginStyle = loginStyle
        
        self.loginConfig = loginConfig
        
        let circleBean = WLCircleBean(JSON: circleJson)
        
        self.circleBean = circleBean
        
        self.circleJson = circleJson
        
        super.init(nibName: nil, bundle: nil)
        
        //        printLog(message: "init1")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var commentVC: WLCommentBaseViewController!
    
    var contentVC: WLContentBaseViewController!
    
    open override func addOwnSubViews() {
        
        printLog(message: "addOwnSubViews")
        
        headerHeight = 50
        
        commentVC = WLCommentBaseViewController.createComment(commentStyle, config: commentConfig, uid: circleBean!.users.encoded, encoded: circleBean!.encoded ,delegate: self)
        
        contentVC = WLContentBaseViewController.createContent(contentStyle, config: contentConfig, circleJson: circleJson)
        
        view.addSubview(topView)
        
        topView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 1)
        
        for item in self.circleBean!.contentMap {
            
            if item.type == "image" || item.type == "video" {
                
                headerHeight += (view.bounds.width - 30) * 3 / 4 + 5
            } else {
                
                headerHeight += item.value.caculateHeight(CGSize(width: view.bounds.width - 30, height: 999), fontSize: 15) + 30
            }
        }
        
        var frame = CGRect(x: 0, y: 1, width: view.bounds.width, height: view.bounds.height)
        
        //        frame.size.height -= 55
        
        commentVC.view.frame = frame
        
        view.addSubview(commentVC.view)
        
        contentVC.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: headerHeight)
        
        contentVC.tableView.frame = contentVC.view.bounds
        
        //        contentVC.tableView.frame.size.height = headerHeightc
        
        commentVC.tableView.tableHeaderView = contentVC.view
        
        addChild(contentVC)
        
        addChild(commentVC)
        
        //        printLog(message: view.bounds)
        
        view.addSubview(tf)
        
        tf.font = UIFont.systemFont(ofSize: 15)
        
        tf.returnKeyType = .send
        
        tf.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 55, width: frame.width, height: 55)
        
        tf.backgroundColor = .white
        
        tf.placeholder = "请输入评论内容"
        
        tf.delegate = self
        
        coverItem.setTitle("请输入评论内容", for: .normal)
        
        coverItem.setTitleColor(WLHEXCOLOR(hexColor: "#666666"), for: .normal)
        
        coverItem.backgroundColor = .white
        
        coverItem.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        view.addSubview(coverItem)
        
        coverItem.frame = CGRect(x: 15, y: UIScreen.main.bounds.height - 55, width: frame.width, height: 55)
        
        coverItem.sizeToFit()
        
        coverItem.center.y = tf.center.y
        
    }
    
    open override func configViewModel() {
        
        let input = WLCircleDetailViewModel.WLInput(content: tf.rx.text.orEmpty.asDriver(),
                                                    coverTaps: coverItem.rx.tap.asSignal(),
                                                    moreTaps: moreItem.rx.tap.asSignal())
        
        viewModel = WLCircleDetailViewModel(input)
        
        viewModel
            .output
            .covered
            .drive(onNext: { [unowned self] (_) in
                
                let login = self.checkLogin(self.loginStyle, config: self.loginConfig)
                
                if login {
                    
                    self.tf.becomeFirstResponder()
                }
                
            })
            .disposed(by: disposed)
        
        viewModel
            .output
            .mored
            .drive(onNext: { [unowned self] (_) in
                
                let login = self.checkLogin(self.loginStyle, config: self.loginConfig)
                
                if login {
                    
                    self.onMoreItemClick(self.circleBean)
                }
                
            })
            .disposed(by: disposed)
    }
    
    public func onMoreItemClick() {
        
        onMoreItemClick(self.circleBean)
    }
    open func onMoreItemClick(_ item: WLCircleBean) {
        
        let login = checkLoginAndIsGoLogin(loginStyle, config: loginConfig)
        
        if login {
            
            let delegate = self.delegate
            
            let action = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let cancel = UIAlertAction(title: "取消", style: .cancel) { (a) in
                
                
            }
            
            let report = UIAlertAction(title: "举报", style: .default) { [weak self] (a) in
                
                guard let `self` = self ,let de = delegate else { return }
                
                de.onReportClick(self, uid: item.users.encoded,encoded: item.encoded)
            }
            
            let black = UIAlertAction(title: "拉黑(谨慎使用)", style: .default) { [weak self] (a) in
                
                guard let `self` = self else { return }
                
                WLHudUtil.show(withStatus: "拉黑中...")
                
                WLCircleViewModel
                    .addBlack(item.users.encoded, targetEncoded: item.encoded, content: "")
                    .drive(onNext: { (res) in
                        
                        switch res {
                        case .ok(let msg):
                            
                            WLHudUtil.pop()
                            
                            WLHudUtil.showInfo(msg)
                            
                            self.navigationController?.popViewController(animated: true)
                            
                        case .failed(let msg):
                            
                            WLHudUtil.pop()
                            
                            WLHudUtil.showInfo(msg)
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
                        
                        switch res {
                        case .ok(let msg):
                            WLHudUtil.pop()
                            
                            WLHudUtil.showInfo(msg)
                        case .failed(let msg):
                            
                            WLHudUtil.pop()
                            
                            WLHudUtil.showInfo(msg)
                        default: break
                            
                        }
                    })
                    .disposed(by: self.disposed)
            }
            
            action.addAction(black)
            
            if item.users.encoded != WLAccountCache.default.uid {
                
                if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
                    
                    if version > "1.1.0" {
                        
                        action.addAction(focus)
                    }
                }
            }
            
            if let info = Bundle.main.infoDictionary  {
                
                let displayname = info["CFBundleDisplayName"] as? String ?? ""
                
                let share = UIAlertAction(title: "分享", style: .default) { [weak self] (a) in
                    
                    guard let `self` = self ,let delegate = self.delegate else { return }
                    
                    delegate.onShareClick(self, webUrl: "https://zhih.ecsoi.com/mob/circleFriends_wexCircleFriendsInfo?cfs.encoded=\(item.encoded)",title: displayname, desc: "\(displayname)欢迎您")
                }
                
                action.addAction(share)
            }

            action.addAction(report)
            
            action.addAction(cancel)
            
            present(action, animated: true, completion: nil)
        }
    }
    
    @objc (moreItem)
    public var moreItem = UIButton(type: .custom).then {
        
        $0.sizeToFit()
    }
    open override func configNaviItem() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moreItem)
        
        if let config = commentConfig {
            
            moreItem.setImage(UIImage(named: config.moreIcon), for: .normal)
            
            moreItem.setImage(UIImage(named: config.moreIcon), for: .highlighted)
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: moreItem)
        }
    }
    
    open override func addNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(noti: Notification) {
        
        let duration = noti.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        
        let frame = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        
        UIView.animate(withDuration: duration, animations: {
            
            self.tf.frame = CGRect(x: 0, y: frame.minY - 55, width: frame.width, height: 55)
            
            
        }) { (isFinished) in
            
            
        }
    }
    open override func removeNotification() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillHide(noti: Notification) {
        
        let duration = noti.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        
        let frame = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        
        UIView.animate(withDuration: duration, animations: {
            
            self.tf.frame = CGRect(x: 0, y: frame.minY - 55, width: frame.width, height: 55)
            
        }) { (isFinished) in
            
            
        }
    }
}
extension WLCircleDetailBaseViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let text = textField.text {
            
            textField.resignFirstResponder()
            
            WLCommentViewModel
                .addComment(encode, content: text)
                .drive(onNext: { [unowned self ](result) in
                    
                    switch result {
                    case .operation(let mapper):
                        
                        self.tf.text = ""
                        
                        self.commentVC.commentSucc(mapper)
                    case .failed(let msg):
                        
                        WLHudUtil.showInfo(msg)
                    default:
                        break
                    }
                })
                .disposed(by: disposed)
            
            return true
        } else {
            
            return false
        }
        
    }
}
