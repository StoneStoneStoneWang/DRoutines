//
//  WLAreaBaseViewController.swift
//  DAddressDemo
//
//  Created by three stone 王 on 2019/7/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DPrepare
import WLToolsKit
import WLThirdUtil.WLHudUtil
import WLBaseTableView
import RxDataSources
import WLReqKit
import RxCocoa
import RxSwift

let debugTop: CGFloat = 0

extension Reactive where Base: WLAreaBaseViewController {
    
    public var formData: Observable<WLAddressEditBean> {
        
        return self.base.formData.asObservable()
    }
}

open class WLAreaBaseViewController: WLLoadingDisposeViewController {
    
    final let presentAnimation: WLAreaPresentAnimation = WLAreaPresentAnimation()
    
    final let dismissAnimation: WLAreaDismisstAnimation = WLAreaDismisstAnimation()
    
    final let cancleItem: UIButton = UIButton(type: .custom)
    
    public let formData: BehaviorRelay<WLAddressEditBean> = BehaviorRelay<WLAddressEditBean>(value: WLAddressEditBean())
    
    var config: WLAddressConfig!
    
    public required init(_ config: WLAddressConfig ,addressEditBean: WLAddressEditBean) {
        
        self.config = config
        
        self.formData.accept(addressEditBean)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    final let collectionView = WLAreaHeaderCollectionView.createAreaHeader()
    
    override open func addOwnSubViews() {
        
        view.addSubview(collectionView)
        
        view.addSubview(cancleItem)
    }
    
    override open func configOwnSubViews() {
        
        collectionView.snp.makeConstraints { (make) in
            
            make.left.equalToSuperview()
            
            make.height.equalTo(44)
            
            make.top.equalTo(debugTop)
            
            make.right.equalTo(-60)
        }
        
        collectionView.register(WLAreaHeaderCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        cancleItem.snp.makeConstraints { (make) in
            
            make.left.equalTo(collectionView.snp.right)
            
            make.right.equalToSuperview()
            
            make.top.equalTo(collectionView.snp.top)
            
            make.bottom.equalTo(collectionView.snp.bottom)
        }
        
        cancleItem.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        cancleItem.backgroundColor = WLHEXCOLOR(hexColor: config.itemColor)
        
        cancleItem.setTitle("取消", for: .normal)
        
        cancleItem.setTitle("取消", for: .highlighted)
        
        cancleItem
            .rx
            .tap
            .subscribe(onNext: { [unowned self] (_) in
                
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposed)
    }
    
    open override func configOwnProperties() {
        super.configOwnProperties()
        
        transitioningDelegate = self
    }
    
    open func configCell(_ cv: UICollectionView,ip: IndexPath,item: WLAreaHeaderBean) -> UICollectionViewCell {
        
        return UICollectionViewCell()
    }
    
    var viewModel: WLAreaViewModel!
    
    typealias Section = WLSectionModel<(), WLAreaHeaderBean>
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<Section>!
    
    open override func configViewModel() {
        
        let input = WLAreaViewModel.WLInput(modelSelect: collectionView.rx.modelSelected(WLAreaHeaderBean.self),
                                            itemSelect: collectionView.rx.itemSelected)
        
        viewModel = WLAreaViewModel(input, disposed: disposed)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<Section>(
            configureCell: { [unowned self] ds, cv, ip, item in return self.configCell(cv, ip: ip, item: item) })
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .tableData
            .asObservable()
            .map({ [Section(model: (), items: $0)] })
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { [unowned self] (header,ip) in
                
                self.onHeaderClick(header, ip: ip)
            })
            .disposed(by: disposed)
        
        onReload()
        
    }
    
    open func onHeaderClick(_ area: WLAreaHeaderBean ,ip: IndexPath) {
        
        
    }
    
    open override func onReload() {
        
        loadingView.onLoadingStatusChanged(.loading)
        
        WLAreaManager.default
            .fetchAreas()
            .drive(onNext: { [weak self] (result) in
                
                guard let `self` = self else { return }
                
                switch result {
                case let .fetchList(list):
                    
                    self.loadingView.onLoadingStatusChanged(.succ)
                    
                    self.handleData(list as! [WLAreaBean] ,addressEditBean: self.formData.value)
                    
                case let .failed(msg):
                    
                    WLHudUtil.showInfo(msg)
                    
                    self.loadingView.onLoadingStatusChanged(.fail)
                    
                default: break
                    
                }
            })
            .disposed(by: disposed)
    }
    
    open func handleData(_ areas: [WLAreaBean],addressEditBean: WLAddressEditBean) {
        
        
    }
}
extension WLAreaBaseViewController: UIViewControllerTransitioningDelegate {
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return dismissAnimation
    }
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return presentAnimation
    }
}
extension WLAreaBaseViewController {
    
    class WLAreaPresentAnimation: NSObject,UIViewControllerAnimatedTransitioning {
        func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            
            return 0.5
        }
        
        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            
            let tovc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
            
            let fromvc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
            
            let finalRect = CGRect(x: 0, y: WL_SCREEN_HEIGHT / 4, width: WL_SCREEN_WIDTH, height: WL_SCREEN_HEIGHT * 3 / 4)
            
            tovc.view.frame = finalRect.offsetBy(dx: 0, dy: WL_SCREEN_HEIGHT * 3 / 4)
            
            let snapView = fromvc.view.snapshotView(afterScreenUpdates: false)!
            
            snapView.frame = transitionContext.containerView.bounds
            
            snapView.tag = 888888
            
            let cover = UIView(frame: .zero)
            
            cover.frame = transitionContext.containerView.bounds
            
            cover.tag = 9999999
            
            cover.alpha = 0.0
            
            cover.backgroundColor = WLHEXCOLOR(hexColor: "#333333")
            
            transitionContext.containerView.addSubview(snapView)
            
            transitionContext.containerView.addSubview(cover)
            
            transitionContext.containerView.addSubview(tovc.view)
            
            fromvc.view.isHidden = true
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveLinear, animations: {
                
                tovc.view.frame = finalRect
                
                snapView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                
                cover.alpha = 0.5
                
            }) { (isFinished) in
                
                fromvc.view.isHidden = false
                
                transitionContext.completeTransition(true)
            }
        }
    }
    
    class WLAreaDismisstAnimation: NSObject, UIViewControllerAnimatedTransitioning {
        func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            
            return 0.3
        }
        
        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            
            let fromvc = transitionContext.viewController(forKey: .from)!
            
            let tovc = transitionContext.viewController(forKey: .to)!
            
            let initRect = transitionContext.initialFrame(for: fromvc)
            
            let finalRect = initRect.offsetBy(dx: 0, dy: WL_SCREEN_HEIGHT * 3 / 4)
            
            transitionContext.containerView.addSubview(tovc.view)
            
            transitionContext.containerView.sendSubviewToBack(tovc.view)
            
            let snapViewFrom = transitionContext.containerView.viewWithTag(888888)
            
            snapViewFrom?.removeFromSuperview()
            
            tovc.view.frame = transitionContext.containerView.bounds
            
            tovc.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.99, initialSpringVelocity: 0, options: .curveLinear, animations: {
                
                fromvc.view.frame = finalRect
                
                tovc.view.transform = CGAffineTransform.identity
                
            }) { (isFinished) in
                
                transitionContext.completeTransition(true)
            }
        }
    }
}
