//
//  WLVideoShowViewController.swift
//  SPrepareDemo
//
//  Created by three stone 王 on 2019/6/6.
//  Copyright © 2019 three stone 王. All rights reserved.
//
import Foundation
import UIKit
import WLToolsKit
import MediaPlayer
import SnapKit

public final class WLVideoShowViewController: WLBaseDisposeViewController {

    var moviePlayer: MPMoviePlayerController!
    
    @objc public static func createVideoShow(_ url: String,back: String) -> Self {
        
        return self.init( url,back: back)
    }
    
    var url: String = ""
    
    @objc func show(_ from: UIViewController) {
        
        from.present(self, animated: false, completion: nil)
    }
    @objc public required init(_ url: String ,back: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.backIcon.setImage(UIImage(named: back), for: .normal)
        
        self.backIcon.setImage(UIImage(named: back), for: .highlighted)

        self.url = url
        
        moviePlayer = MPMoviePlayerController(contentURL: URL(string: url))
        
        moviePlayer.view.frame = view.bounds
        
        moviePlayer.view.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)
        
        view.addSubview(moviePlayer.view)
        
        moviePlayer.play()
    }
    
    public final let backIcon: UIButton = UIButton(type: .custom)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func addOwnSubViews() {
        
        view.addSubview(backIcon)
    }
    public override func configOwnSubViews() {
        
        backIcon.snp.makeConstraints { (make) in
            
            make.left.equalTo(15)
            
            make.centerY.equalTo(WL_TOP_LAYOUT_GUARD - 22)
        }
        
        backIcon.sizeToFit()
        
        backIcon.addTarget(self, action: #selector(dismissToSuper), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(mediaPlayerPlaybackFinished), name: NSNotification.Name.MPMoviePlayerPlaybackDidFinish, object: moviePlayer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(mediaPlayerPlaybackStateChange), name: NSNotification.Name.MPMoviePlayerPlaybackDidFinish, object: moviePlayer)
    }
    @objc func mediaPlayerPlaybackStateChange(_ noti: Notification) {
        
        
    }
    @objc func mediaPlayerPlaybackFinished(_ noti: Notification) {
        
        dismissToSuper()
    }
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    public override func configOwnProperties() {
        
    }
    @objc func dismissToSuper() {
        
        dismiss(animated: false, completion: nil)
    }
}
