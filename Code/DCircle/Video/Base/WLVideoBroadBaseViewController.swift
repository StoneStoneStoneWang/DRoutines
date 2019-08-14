//
//  WLVideoBroadBaseViewController.swift
//  DCircleDemo
//
//  Created by three stone 王 on 2019/8/12.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import UIKit
import DPrepare
import WLPlayerKit
import ObjectMapper
import DNotification
import DRoutinesKit
import DLogin
import WLThirdUtil.WLHudUtil
import Kingfisher
import WLToolsKit
import WLComponentView

class WLVideoTF: UITextField {
    
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

@objc (WLVideoBroadBaseViewController)
open class WLVideoBroadBaseViewController: WLF1DisposeViewController {
    
    var playerView: WLVideoPlayer!
    
    var circleBean: WLCircleBean!
    
    var loginStyle: WLLoginStyle = .one
    
    var loginConfig: WLLoginConfig!
    
    var commentVC: WLCommentBaseViewController!

    final let tf: WLVideoTF = WLVideoTF(frame: .zero)
    
    final let coverItem: UIButton = UIButton(type: .custom)
    
    public required init(_ config: WLCommentConfig ,loginStyle: WLLoginStyle ,loginConfig: WLLoginConfig,videoUrl: String,circleJson: [String: Any]) {
        
        super.init(nibName: nil, bundle: nil)
        
        self.loginStyle = loginStyle
        
        self.loginConfig = loginConfig
        
        circleBean = WLCircleBean(JSON: circleJson)
        
        let player = WLVideoPlayer(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width * 9 / 16), andDelegate: self)
        
        playerView = player
        
        view.addSubview(playerView)
        
        playerView.mediaURL = URL(string: videoUrl)!
        
        var thumbImageView: UIImageView!
        
        for item in player.subviews {
            
            if item is UIImageView {
                
                thumbImageView = item as? UIImageView
                
                break
            }
        }
        
        let processor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 0)
        
        let icon: String = videoUrl + "?x-oss-process=video/snapshot,t_7000,f_jpg,w_1600,h_700,m_fast"
        
        thumbImageView.kf.setImage(with: URL(string: icon), placeholder: nil, options: [
            .processor(processor),
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(0.3)),
            .fromMemoryCacheOrRefresh
            ])
        
        commentVC = WLCommentBaseViewController.createComment(.one, config: config, uid: circleBean.users.encoded, encoded: circleBean.encoded, delegate: self)
        
        addChild(commentVC)
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width * 9 / 16))
        
        playerView.show(in: view, andThumb: UIImage(named: "播放")!)
        
        commentVC.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - view.bounds.width * 9 / 16 )
        
        view.addSubview(commentVC.view)
        
        view.bringSubviewToFront(playerView)
        
        commentVC.tableView.frame = commentVC.view.bounds
        
        commentVC.tableView.tableHeaderView = headerView
        
        commentVC.tableView.mj_insetT = -WL_TOP_LAYOUT_GUARD
        
        view.addSubview(tf)
        
        tf.font = UIFont.systemFont(ofSize: 15)
        
        tf.returnKeyType = .send
        
        tf.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 55, width: UIScreen.main.bounds.width, height: 55)
        
        tf.backgroundColor = .white
        
        tf.placeholder = "请输入评论内容"
        
        tf.delegate = self
        
        coverItem.setTitle("请输入评论内容", for: .normal)
        
        coverItem.setTitleColor(WLHEXCOLOR(hexColor: "#666666"), for: .normal)
        
        coverItem.backgroundColor = .white
        
        coverItem.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        view.addSubview(coverItem)
        
        coverItem.frame = CGRect(x: 15, y: UIScreen.main.bounds.height - 55, width: UIScreen.main.bounds.width, height: 55)
        
        coverItem.sizeToFit()
        
        coverItem.center.y = tf.center.y
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override var shouldAutorotate: Bool { return playerView.canRotate }
    
    open override var prefersStatusBarHidden: Bool { return true }
    
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation { return .portrait}
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return playerView.canRotate ? .allButUpsideDown : .portrait }
    
    open override func addNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        
        removeNotification()
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
extension WLVideoBroadBaseViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let text = textField.text {
            
            textField.resignFirstResponder()
            
            WLVideoViewModel
                .addComment(circleBean.encoded, content: text)
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

extension WLVideoBroadBaseViewController: WLCommentDelegate {
    public func onMoreItemClick() {
     
        let login = checkLoginAndIsGoLogin(loginStyle, config: loginConfig)
        
        if login {
            
            let action = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let cancel = UIAlertAction(title: "取消", style: .cancel) { (a) in
                
                
            }
            
            let report = UIAlertAction(title: "举报", style: .default) { [weak self] (a) in
                
                guard let `self` = self  else { return }
                
                DNotificationConfigration.postNotification(withName: NSNotification.Name(rawValue: DNotificationCircleGotoReport), andValue: self.circleBean.toJSON(), andFrom: self)
            }
            
            let black = UIAlertAction(title: "拉黑(谨慎使用)", style: .default) { [weak self] (a) in
                
                guard let `self` = self else { return }
                
                WLHudUtil.show(withStatus: "拉黑中...")
                
                WLVideoViewModel
                    .addBlack(self.circleBean.users.encoded, targetEncoded: self.circleBean.encoded, content: "")
                    .drive(onNext: { (res) in
                        
                        WLHudUtil.pop()
                        switch res {
                        case .ok(let msg):
                            
                            WLHudUtil.showInfo(msg)
                            
                            self.navigationController?.popViewController(animated: true)
                            
                            NotificationCenter.default.post(name: NSNotification.Name.DAddBlackOperation, object: nil)
                            
                        case .failed(let msg): WLHudUtil.showInfo(msg)
                        default: break
                            
                        }
                    })
                    .disposed(by: self.disposed)
            }
            
            let focus = UIAlertAction(title: "关注", style: .default) { [weak self] (a) in
                
                guard let `self` = self else { return }
                
                WLVideoViewModel
                    .focus(self.circleBean.users.encoded, encode: self.circleBean.encoded)
                    .drive(onNext: { (res) in
                        
                        WLHudUtil.pop()
                        
                        switch res {
                        case .ok(let msg): WLHudUtil.showInfo(msg)
                        case .failed(let msg): WLHudUtil.showInfo(msg)
                        default: break
                            
                        }
                    })
                    .disposed(by: self.disposed)
            }
            action.addAction(black)
            
            if self.circleBean.users.encoded != WLAccountCache.default.uid {
                
                if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
                    
                    if version > "1.1.0" {
                        
                        action.addAction(focus)
                    }
                }
            }
            
            if let info = Bundle.main.infoDictionary  {
                
                let displayname = info["CFBundleDisplayName"] as? String ?? ""
                
                let share = UIAlertAction(title: "分享", style: .default) { [weak self] (a) in
                    
                    guard let `self` = self else { return }
                    
                    DNotificationConfigration.postNotification(withName: NSNotification.Name(rawValue: DNotificationCircleShare), andValue: ["webUrl": "\(DConfigure.fetchAppKey())mob/circleFriends_wexCircleFriendsInfo?cfs.encoded=\(self.circleBean.encoded)","title": displayname,"desc":"\(displayname)欢迎您"], andFrom: self)
                }
                
                action.addAction(share)
            }
            
            action.addAction(report)
            
            action.addAction(cancel)
            
            present(action, animated: true, completion: nil)
        }
    }
}
extension WLVideoBroadBaseViewController: WLVideoPlayerDelegate {
    public func onVideoPlayer(_ player: WLVideoPlayer, andMoreBtn moreBtn: UIButton) {
        
        onMoreItemClick()
    }
    
    public func onVideoPlayer(_ player: WLVideoPlayer, andCloseBtn closeBtn: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
}
