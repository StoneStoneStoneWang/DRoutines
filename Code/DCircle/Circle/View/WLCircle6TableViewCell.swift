//
//  WLCircle6TableViewCell.swift
//  WLCircleKitDemo
//
//  Created by three stone 王 on 2019/5/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import SnapKit
import Kingfisher
import WLToolsKit

class WLCircleImagesView: UICollectionView {
    
    static func createCircleImages() -> WLCircleImagesView {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        let w = (WL_SCREEN_WIDTH - 30 - 10) / 3
        
        layout.itemSize = CGSize(width: w, height: w)
        
        layout.minimumLineSpacing = 1
        
        layout.minimumInteritemSpacing = 1
        
        return WLCircleImagesView(frame: .zero, collectionViewLayout: layout)
    }
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        dataSource = self
        
        delegate = self
        
        register(WLCircleImagesViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var datas: [(String,Bool,String)] = []
    
}
extension WLCircleImagesView: UICollectionViewDataSource ,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WLCircleImagesViewCell
        
        cell.icon = datas[indexPath.row]
        
        return cell
    }
}
class WLCircleImagesViewCell: UICollectionViewCell {
    
    var cover: UIImageView = UIImageView(frame: .zero).then {
        
        $0.backgroundColor = .black
        
        $0.alpha = 0.5
        
        $0.contentMode = .scaleAspectFit
    }
    
    @objc (iconImageView)
    open var iconImageView: UIImageView = UIImageView().then {
        
        $0.contentMode = .scaleAspectFill
        
        $0.tag = 2001
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(iconImageView)
        
        contentView.addSubview(cover)
    }
    
    var icon: (String,Bool,String)! {
        
        willSet {
            
            let processor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 0)
            
            self.iconImageView.kf.setImage(with: URL(string: newValue.0), placeholder: UIImage(named: newValue.2), options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.3)),
                .fromMemoryCacheOrRefresh
                ])
            
            if newValue.1 {
                
                cover.isHidden = false
                
                cover.image = UIImage(named: newValue.2)
                
            } else {
                
                cover.isHidden = true
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImageView.snp.makeConstraints { (make) in
            
            make.left.right.bottom.top.equalToSuperview()
        }
        cover.snp.makeConstraints { (make) in
            
            make.left.right.bottom.top.equalToSuperview()
        }
    }
}

public final class WLCircle6TableViewCell: WLCircleBaseTableViewCell {
    
    var funcView: WLCircleFuncView = WLCircleFuncView.circleFuncView()
    
    var imagesView: WLCircleImagesView = WLCircleImagesView.createCircleImages()
    
    var cover: UIImageView = UIImageView(frame: .zero).then {
        
        $0.backgroundColor = .black
        
        $0.alpha = 0.5
        
        $0.contentMode = .scaleAspectFit
    }
    var timeLabel: UILabel = UILabel(frame: .zero).then {
        
        $0.backgroundColor = .clear
        
        $0.font = UIFont.systemFont(ofSize: 10)
        
        $0.textAlignment = .right
        
        $0.textColor = .white
    }
    
    public override var type: (WLCircleBean, WLCircleConfig)! {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            let title = newValue.0.contentMap.first!
            
            titleLabel.text = title.value
            
            var media: WLPublishBean!
            
            for item in newValue.0.contentMap {
                
                if item.type == "image" {
                    
                    media = item
                    
                    break
                } else if item.type == "video"{
                    
                    media = item
                    
                    break
                }
            }
            
            if let media = media {
                
                var processor: ImageProcessor!
                
                if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
                    
                    if version > "1.1.0" {
                        
                        processor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 0)
                    } else {
                        
                        processor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 5)
                    }
                } else {
                    
                    processor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 5)
                }
                
                iconImageView.kf.indicatorType = .activity
                
                cover.isHidden = true
                
                timeLabel.isHidden = true
                
                if media.type == "image" {
                    
                    let icon: String = media.value + "?x-oss-process=image/resize,w_1600,h_700"
                    
                    self.iconImageView.kf.setImage(with: URL(string: icon), placeholder: UIImage(named: newValue.1.defaultIcon), options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(0.3)),
                        .fromMemoryCacheOrRefresh
                        ])
                } else {
                    
                    let icon: String = media.value + "?x-oss-process=video/snapshot,t_7000,f_jpg,w_1600,h_700,m_fast"
                    
                    self.iconImageView.kf.setImage(with: URL(string: icon), placeholder: UIImage(named: newValue.1.defaultIcon), options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(0.3)),
                        .fromMemoryCacheOrRefresh
                        ])
                    
                    cover.isHidden = false
                    
                    timeLabel.isHidden = false
                    
                    cover.image = UIImage(named: newValue.1.broadIcon)
                    
                    DispatchQueue.global().async {
                        
                        let text = self.fetchVideoTime(media.value)
                        
                        DispatchQueue.main.async {
                            
                            self.timeLabel.text = text
                        }
                    }
                }
            }
            
            if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
                
                if version > "1.1.0" {
                    
                    funcView.isHidden = false
                    
                    funcView.type = newValue
                    
                    layer.masksToBounds = true
                    
                    subtitleLabel.isHidden = true
                    
                    return
                }
            } else {
                
                funcView.isHidden = true
                subtitleLabel.isHidden = false
                
            }
            
            subtitleLabel.text =  "评论:\(newValue.0.countComment)" + "    " + "观看:\(newValue.0.countLaud)"
        }
    }
    
    public final let subtitleLabel: UILabel = UILabel().then {
        
        $0.tag = 2003
        
        $0.font = UIFont.systemFont(ofSize: 12)
        
        $0.textAlignment = .left
        
        $0.textColor = WLHEXCOLOR(hexColor: "#666666")
        
        $0.numberOfLines = 2
    }
    
    public override func commitInit() {
        super.commitInit()
        
        iconImageView.layer.masksToBounds = true
        
        titleLabel.numberOfLines = 2
        
        contentView.addSubview(subtitleLabel)
        
        contentView.addSubview(funcView)
        
        contentView.addSubview(cover)
        
        contentView.addSubview(timeLabel)
        
        funcView.mDelegate = self
        
        contentView.addSubview(imagesView)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(15)
            
            make.top.equalTo(15)
            
            make.right.equalTo(-80)
        }
        
        let w = bounds.width - 30
        
        let h = w * 7 / 16
        
        iconImageView.snp.makeConstraints { (make) in
            
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            
            make.right.equalTo(-15)
            
            make.left.equalTo(15)
            
            make.height.equalTo(h)
        }
        cover.snp.makeConstraints { (make) in
            
            make.left.top.equalTo(15)
            
            make.height.equalTo(h)
            
            make.width.equalTo(w)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            
            make.right.equalTo(cover.snp.right).offset(-5)
            
            make.bottom.equalTo(cover.snp.bottom).offset(-15)
        }
        if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
            
            if version >= "1.1.0" {
                
                funcView.snp.makeConstraints { (make) in
                    
                    make.top.equalTo(iconImageView.snp.bottom).offset(5)
                    
                    make.left.equalTo(15)
                    
                    make.height.equalTo(40)
                    
                    make.width.equalTo(200)
                }
                
                moreItem.sizeToFit()
                
                moreItem.snp.makeConstraints { (make) in
                    
                    make.centerY.equalTo(funcView.snp.centerY)
                    
                    make.width.height.equalTo(30)
                    
                    make.right.equalTo(-15)
                }
                return
            }
        }
        
        subtitleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(15)
            
            make.height.equalTo(20)
            
            make.top.equalTo(iconImageView.snp.bottom).offset(8)
        }
        
        moreItem.sizeToFit()
        
        moreItem.snp.makeConstraints { (make) in
            
            make.centerY.equalTo(subtitleLabel.snp.centerY)
            
            make.width.height.equalTo(30)
            
            make.right.equalTo(-15)
        }
    }
}

extension WLCircle6TableViewCell: WLCircleFuncCellDelegate {
    func onWatchItemClick() {
        
        guard let delegate = mDelegate else { return }
        
        delegate.onWatchItemClick(type.0)
    }
    
    func onCommentItemClick() {
        
        guard let delegate = mDelegate else { return }
        
        delegate.onCommentItemClick(type.0)
    }
    
    func onFunItemClick() {
        
        guard let delegate = mDelegate else { return }
        
        delegate.onFunItemClick(type.0)
    }
}
