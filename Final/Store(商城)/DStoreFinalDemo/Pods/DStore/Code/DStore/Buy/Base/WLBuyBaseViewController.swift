//
//  WLBuyBaseViewController.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DPrepare
import WLToolsKit
import WLBaseTableView
import RxDataSources
import RxCocoa
import RxSwift

extension Reactive where Base: WLBuyBaseViewController {
    
    public var goBuy: Observable<Bool> {
        
        return self.base.goBuy.asObservable()
    }
    public var cart: Observable<Bool> {
        
        return self.base.cart.asObservable()
    }
}

open class WLBuyBaseViewController: WLF1DisposeViewController {
    
    final let presentAnimation: WLBuyPresentAnimation = WLBuyPresentAnimation()
    
    final let dismissAnimation: WLBuyDismisstAnimation = WLBuyDismisstAnimation()
    
    final let cancleItem: UIButton = UIButton(type: .custom)
    
    final let goBuyItem: UIButton = UIButton(type: .custom)
    
    final let cartItem: UIButton = UIButton(type: .custom)
    
    var goBuy: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    
    var cart: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    
    var config: WLStoreConfig!
    
    var commodity: WLCommodityBean!
    
    public required init(_ config: WLStoreConfig ,commodity: WLCommodityBean) {
        
        self.config = config
        
        self.commodity = commodity
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    final let tableView: WLBuyTableView = WLBuyTableView.baseTableView()
    
    override open func addOwnSubViews() {
        
        view.addSubview(tableView)
        
        view.addSubview(cancleItem)
        
        view.addSubview(goBuyItem)
        
        view.addSubview(cartItem)
    }
    
    override open func configOwnSubViews() {
        
        tableView.snp.makeConstraints { (make) in
            
            make.left.right.top.equalToSuperview()
            
            make.bottom.equalToSuperview()
        }
        
        cancleItem.snp.makeConstraints { (make) in
            
            make.top.right.equalToSuperview()
            
            make.height.equalTo(44)
            
            make.width.equalTo(80)
        }
        
        cancleItem.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        cancleItem.backgroundColor = WLHEXCOLOR(hexColor: config.itemColor)
        
        cancleItem.setTitle("取消", for: .normal)
        
        cancleItem.setTitle("取消", for: .highlighted)
        
        goBuyItem.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        goBuyItem.backgroundColor = .white
        
        goBuyItem.setTitle("去购买", for: .normal)
        
        goBuyItem.setTitle("去购买", for: .highlighted)
        
        goBuyItem.setTitleColor(WLHEXCOLOR(hexColor: config.itemColor), for: .normal)
        
        goBuyItem.setTitleColor(WLHEXCOLOR(hexColor: config.itemColor), for: .highlighted)
        
        cartItem.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        cartItem.backgroundColor = WLHEXCOLOR(hexColor: config.itemColor)
        
        cartItem.setTitle("购物车", for: .normal)
        
        cartItem.setTitle("购物车", for: .highlighted)
        
        goBuyItem.snp.makeConstraints { (make) in
            
            make.left.bottom.equalToSuperview()
            
            make.height.equalTo(44)
            
            make.width.equalTo(view.bounds.width / 2)
        }
        
        cartItem.snp.makeConstraints { (make) in
            
            make.right.bottom.equalToSuperview()
            
            make.height.equalTo(44)
            
            make.width.equalTo(view.bounds.width / 2)
        }
        cancleItem
            .rx
            .tap
            .subscribe(onNext: { [unowned self] (_) in
                
                self.dismiss(animated: true, completion: nil)
                
            })
            .disposed(by: disposed)
        
        goBuyItem
            .rx
            .tap
            .subscribe(onNext: { [unowned self] (_) in
                
                self.dismiss(animated: true, completion: {
                    
                    self.goBuy.accept(true)
                })
                
            })
            .disposed(by: disposed)
        
        cartItem
            .rx
            .tap
            .subscribe(onNext: { [unowned self] (_) in
                
                self.dismiss(animated: true, completion: {
                    
                    self.cart.accept(true)
                })
            })
            .disposed(by: disposed)
    }
    
    open override func configOwnProperties() {
        super.configOwnProperties()
        
        transitioningDelegate = self
    }
    
    open func configCell(_ tv: UITableView, ip: IndexPath, item: WLBuyBean) -> UITableViewCell {
        
        return UITableViewCell()
    }
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return datasource[indexPath].cellHeight
    }
    
    var viewModel: WLBuyViewModel!
    
    typealias Section = MySection<WLBuyBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    open override func configViewModel() {
        
        let input = WLBuyViewModel.WLInput(modelSelect: tableView.rx.modelSelected(WLBuyBean.self),
                                           itemSelect: tableView.rx.itemSelected,
                                           commodity: commodity)
        
        viewModel = WLBuyViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .top, reloadAnimation: .fade, deleteAnimation: .left),
            decideViewTransition: { _,_,_  in return .reload },
            configureCell: { [unowned self] ds, tv, ip, item in return self.configCell(tv, ip: ip, item: item) })
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .tableData
            .asDriver()
            .map({ $0.map({ Section(header: "\($0.identity)", items: [$0]) }) })
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { [unowned self] (header,ip) in
                
                self.onHeaderClick(header, ip: ip)
            })
            .disposed(by: disposed)
        
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
    }
    
    open func onHeaderClick(_ area: WLBuyBean ,ip: IndexPath) {
        
        
    }
}
extension WLBuyBaseViewController: UITableViewDelegate {}
extension WLBuyBaseViewController: UIViewControllerTransitioningDelegate {
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return dismissAnimation
    }
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return presentAnimation
    }
}
extension WLBuyBaseViewController {
    
    class WLBuyPresentAnimation: NSObject,UIViewControllerAnimatedTransitioning {
        func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            
            return 0.5
        }
        
        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            
            let tovc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
            
            let fromvc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
            
            let finalRect = CGRect(x: 0, y: WL_SCREEN_HEIGHT / 2, width: WL_SCREEN_WIDTH, height: WL_SCREEN_HEIGHT / 2)
            
            tovc.view.frame = finalRect.offsetBy(dx: 0, dy: WL_SCREEN_HEIGHT / 2)
            
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
    class WLBuyDismisstAnimation: NSObject, UIViewControllerAnimatedTransitioning {
        func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            
            return 0.3
        }
        
        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            
            let fromvc = transitionContext.viewController(forKey: .from)!
            
            let tovc = transitionContext.viewController(forKey: .to)!
            
            let initRect = transitionContext.initialFrame(for: fromvc)
            
            let finalRect = initRect.offsetBy(dx: 0, dy: WL_SCREEN_HEIGHT / 2)
            
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
