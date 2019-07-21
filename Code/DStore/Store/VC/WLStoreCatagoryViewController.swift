//
//  WLStoreCatagoryViewController.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit

class WLStoreCatagoryViewController: WLStoreCatagoryBaseViewController {
    
    final let moveLine: UIView = UIView()
    
    final let pageViewController: UIPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
    
    var viewControllers: [UIViewController] = []
    
    override func configOwnSubViews() {
        super.configOwnSubViews()
        
        collectionView.register(WLStoreHeaderCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        pageViewController.dataSource = self
        
        pageViewController.delegate = self
        
        pageViewController.view.frame = CGRect(x: 0, y: WL_Store_Height, width: view.bounds.width, height: view.bounds.height - WL_Store_Height)
        
        moveLine.backgroundColor = WLHEXCOLOR(hexColor: config.itemColor)
        
        view.addSubview(pageViewController.view)
        
        addChild(pageViewController)
        
        view.addSubview(moveLine)
        
        moveLine.frame = CGRect(x: 0, y: WL_TOP_LAYOUT_GUARD + WL_Store_Height - 1, width: WL_Store_Width, height: 1)
        
        view.sendSubviewToBack(pageViewController.view)
    }
    
    override func configViewModel() {
        super.configViewModel()
        
        let value = viewModel.output.tableData.value
        
        for item in value {
            
            let vc = WLStoreBaseViewController.createStore(item.tag, style: .one, config: WLStoreConfigImpl(), loginStyle: .one, loginConfig: WLLoginConfigImpl(), delegate: delegate)
            
            viewControllers += [vc]
        }
        
        onHeaderClick(value[0], ip: IndexPath(item: 0, section: 0))
    }
    override func onHeaderClick(_ area: WLStoreHeaderBean, ip: IndexPath) {
        
        if self.currentIdx < ip.row {
            
            self.pageViewController.setViewControllers([self.viewControllers[ip.row]], direction: .forward, animated: true, completion: nil)
        } else {
            
            self.pageViewController.setViewControllers([self.viewControllers[ip.row]], direction: .reverse, animated: true, completion: nil)
        }
        
        self.collectionView.selectItem(at: ip, animated: false, scrollPosition: .centeredHorizontally)
        
        if let cell = self.collectionView.cellForItem(at: ip) {
            
            UIView.animate(withDuration: 0.2) {
                
                self.moveLine.center = CGPoint(x: cell.center.x, y: self.collectionView.frame.maxY)
            }
        }
        
        var value = viewModel.output.tableData.value
        
        for item in value {
            
            item.isSelected = false
        }
        
        value[ip.row].isSelected = true
        
        viewModel.output.tableData.accept(value)
        
        self.currentIdx = ip.row
    }
    
    override func configCell(_ cv: UICollectionView, ip: IndexPath, item: WLStoreHeaderBean) -> UICollectionViewCell {
        
        let cell = cv.dequeueReusableCell(withReuseIdentifier: "cell", for: ip) as! WLStoreHeaderCollectionViewCell
        
        cell.type = (item,self.config)
        
        return cell
    }
}

extension WLStoreCatagoryViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let index = self.viewControllers.firstIndex(of: viewController)
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        //守护，防止空值在解包时崩溃
        guard let index1 = index else {
            return nil
        }
        // 此处index必须减一
        return viewControllers[index1 - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        //获取当前控制器索引
        let index = self.viewControllers.firstIndex(of: viewController)
        
        if index == NSNotFound {
            return nil
        }
        
        if (index == self.viewControllers.count-1) {
            //防止越界,必须要设置
            return nil
        }
        //守护，防止空值在解包时崩溃
        guard let index1 = index else {
            return nil
        }
        
        return viewControllers[index1+1]
    }
    
}
extension WLStoreCatagoryViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        let controller = pendingViewControllers[0]
        self.currentIdx = self.viewControllers.firstIndex(of: controller)!
    }
    
    //还有一个非常有用的代理，它在动画执行完毕后被调用，在controller切换完成后，
    //    我们可以在这个代理中进行一些后续操作。例如用UIPageViewController实现轮播分页等功能。
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            
            //找到所有buton
            
            self.collectionView.selectItem(at: IndexPath(item: currentIdx, section: 0), animated: true, scrollPosition: .centeredHorizontally)
            
            UIView.animate(withDuration: 0.1) {
                
                if let cell = self.collectionView.cellForItem(at: IndexPath(item: self.currentIdx, section: 0)) {
                    
                    self.moveLine.center = CGPoint(x: cell.center.x, y: self.collectionView.frame.maxY)
                }
            }
            
            var value = viewModel.output.tableData.value
            
            for item in value {
                
                item.isSelected = false
            }
            
            value[currentIdx].isSelected = true
            
            viewModel.output.tableData.accept(value)
        }
    }
}
