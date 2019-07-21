//
//  WLPublish1ViewController.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit
import SnapKit

@objc (WLPublish1ViewController)
public final class WLPublish1ViewController: WLPublishTableBaseViewController {
    
    var footerView: WLPublishTableFooterView = WLPublishTableFooterView(frame: .zero)
    
    public override func configOwnSubViews() {
        super.configOwnSubViews()
        
        let h: CGFloat = 40
        
        footerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 70)
        
        tableView.tableFooterView = footerView
        
        textItem.setTitle("发布文案", for: .normal)
        
        textItem.setTitle("发布文案", for: .highlighted)
        
        //            textItem.setImage(UIImage(named: config.textIcon), for: .normal)
        //
        //            textItem.setImage(UIImage(named: config.textIcon), for: .highlighted)
        
        textItem.setTitleColor(WLHEXCOLOR(hexColor: "#333333"), for: .normal)
        
        textItem.setTitleColor(WLHEXCOLOR_ALPHA(hexColor: "#333333" + "60"), for: .highlighted)
        
        imageItem.setTitle("发布图片", for: .normal)
        
        imageItem.setTitle("发布图片", for: .highlighted)
        
        imageItem.setTitleColor(WLHEXCOLOR(hexColor: "#333333"), for: .normal)
        
        imageItem.setTitleColor(WLHEXCOLOR_ALPHA(hexColor: "#333333" + "60"), for: .highlighted)
        
        videoItem.setTitle("发布视频", for: .normal)
        
        videoItem.setTitle("发布视频", for: .highlighted)
        
        videoItem.setTitleColor(WLHEXCOLOR(hexColor: "#333333"), for: .normal)
        
        videoItem.setTitleColor(WLHEXCOLOR_ALPHA(hexColor: "#333333" + "60"), for: .highlighted)
        
        textItem.layer.cornerRadius = h / 2
        
        textItem.layer.borderColor = WLHEXCOLOR(hexColor: "#333333").cgColor
        
        textItem.layer.borderWidth = 1
        
        textItem.layer.masksToBounds = true
        
        textItem.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        imageItem.layer.cornerRadius = h / 2
        
        imageItem.layer.borderColor = WLHEXCOLOR(hexColor: "#333333").cgColor
        
        imageItem.layer.borderWidth = 1
        
        imageItem.layer.masksToBounds = true
        
        imageItem.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        videoItem.layer.cornerRadius = h / 2
        
        videoItem.layer.borderColor = WLHEXCOLOR(hexColor: "#333333").cgColor
        
        videoItem.layer.borderWidth = 1
        
        videoItem.layer.masksToBounds = true
        
        videoItem.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        switch style {
        case .image:
            
            footerView.addSubview(textItem)
            
            footerView.addSubview(imageItem)
            
            let width = ( view.bounds.width - 30 - 10 ) / 2
            
            textItem.snp.makeConstraints { (make) in
                
                make.left.equalTo(15)
                
                make.width.equalTo(width)
                
                make.centerY.equalToSuperview()
                
                make.height.equalTo(h)
            }
            imageItem.snp.makeConstraints { (make) in
                
                make.right.equalTo(-15)
                
                make.width.equalTo(width)
                
                make.centerY.equalToSuperview()
                
                make.height.equalTo(h)
            }
            
        case .mix:
            
            footerView.addSubview(textItem)
            
            footerView.addSubview(imageItem)
            
            footerView.addSubview(videoItem)
            
            let width = ( view.bounds.width - 30 - 20 ) / 3
            
            textItem.snp.makeConstraints { (make) in
                
                make.left.equalTo(15)
                
                make.width.equalTo(width)
                
                make.centerY.equalToSuperview()
                
                make.height.equalTo(h)
            }
            imageItem.snp.makeConstraints { (make) in
                
                make.left.equalTo(textItem.snp.right).offset(10)
                
                make.width.equalTo(width)
                
                make.centerY.equalToSuperview()
                
                make.height.equalTo(h)
            }
            
            videoItem.snp.makeConstraints { (make) in
                
                make.right.equalTo(-15)
                
                make.width.equalTo(width)
                
                make.centerY.equalToSuperview()
                
                make.height.equalTo(h)
            }
        case .video:
            
            footerView.addSubview(textItem)
            
            footerView.addSubview(videoItem)
            
            let width = ( view.bounds.width - 30 - 10 ) / 2
            
            textItem.snp.makeConstraints { (make) in
                
                make.left.equalTo(15)
                
                make.width.equalTo(width)
                
                make.centerY.equalToSuperview()
                
                make.height.equalTo(h)
            }
            videoItem.snp.makeConstraints { (make) in
                
                make.right.equalTo(-15)
                
                make.width.equalTo(width)
                
                make.centerY.equalToSuperview()
                
                make.height.equalTo(h)
            }
        }
        
        completeItem.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        completeItem.setTitle("发布", for: .normal)
        
        completeItem.setTitle("发布", for: .highlighted)
        
        if "#333333" != "#ffffff" {
            
            completeItem.setTitleColor(WLHEXCOLOR(hexColor: "#ffffff"), for: .normal)
            
            completeItem.setTitleColor(WLHEXCOLOR(hexColor: "#ffffff"), for: .highlighted)
            
            completeItem.setTitleColor(WLHEXCOLOR_ALPHA(hexColor: "#ffffff" + "60"), for: .disabled)
        } else {
            
            completeItem.setTitleColor(WLHEXCOLOR(hexColor: "#333333"), for: .normal)
            
            completeItem.setTitleColor(WLHEXCOLOR(hexColor: "#333333"), for: .highlighted)
            
            completeItem.setTitleColor(WLHEXCOLOR_ALPHA(hexColor: "#333333" + "60"), for: .disabled)
        }
    }
    
    //    public override func addOwnSubViews() {
    //
    //        flowLayout = UICollectionViewFlowLayout()
    //
    //        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    //
    //        flowLayout.minimumLineSpacing = 1
    //
    //        flowLayout.minimumInteritemSpacing = 1
    //
    //        flowLayout.headerReferenceSize = CGSize(width: view.bounds.width, height: 60)
    //
    //        collectionView = WLPublishCollectionView.createPublish(flowLayout)
    //
    //        view.addSubview(collectionView)
    //    }
    //
    //    public override func configOwnSubViews() {
    //
    //        collectionView.snp.makeConstraints { (make) in
    //
    //            make.left.right.bottom.equalToSuperview()
    //
    //            make.top.equalTo(WL_TOP_LAYOUT_GUARD)
    //        }
    //        collectionView.register(WLPublishCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    //
    //        collectionView.register(WLPublishHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    //
    //        collectionView
    //            .rx
    //            .setDelegate(self)
    //            .disposed(by: disposed)
    //    }
    //    public override func configSupplementaryHeaderView(_ cv: UICollectionView, ip: IndexPath) -> UICollectionReusableView {
    //
    //        let view = cv.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: ip)
    //
    //        return view
    //    }
}
extension WLPublish1ViewController: UICollectionViewDelegateFlowLayout {
    
    //    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //
    //        guard let datasource = dataSource else { return .zero }
    //
    //        let item = datasource[indexPath]
    //
    //        if item.type == "txt" {
    //
    //            return CGSize(width: view.bounds.width, height: item.value.caculateHeight(CGSize(width: view.bounds.width - 15 * 2, height: 999), fontSize: 15))
    //
    //        } else if item.type == "image" || item.type == "video" {
    //
    //            return CGSize(width: view.bounds.width, height: 120)
    //        }
    //
    //        return .zero
    //    }
    
    //    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    //
    //        return CGSize(width: view.bounds.width, height: 60)
    //    }
    
    
}

