//
//  WLAreaViewController.swift
//  DAddressDemo
//
//  Created by three stone 王 on 2019/7/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import UIKit
import WLToolsKit

class WLAreaViewController: WLAreaBaseViewController {
    
    var currentIdx: Int = 0
    
    final let moveLine: UIView = UIView()
    
    final let pageViewController: UIPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
    
    var viewControllers: [UIViewController] = []
    
    override func configOwnSubViews() {
        super.configOwnSubViews()
        
        pageViewController.dataSource = self
        
        pageViewController.delegate = self
        
        pageViewController.view.frame = CGRect(x: 0, y: debugTop + WL_Area_Height, width: view.bounds.width, height: view.bounds.height - WL_Area_Height)
        
        moveLine.backgroundColor = WLHEXCOLOR(hexColor: config.itemColor)
        
        view.addSubview(pageViewController.view)
        
        addChild(pageViewController)
        
        view.addSubview(moveLine)
        
        moveLine.frame = CGRect(x: 0, y: debugTop + 43, width: WL_Area_Width, height: 1)
    }
    
    let proHeader = WLAreaHeaderBean()
    
    let cityHeader = WLAreaHeaderBean()
    
    let regionHeader = WLAreaHeaderBean()
    
    var province: WLBaseAreaCatagoryViewController!
    
    var city: WLBaseAreaCatagoryViewController!
    
    var region: WLBaseAreaCatagoryViewController!
    
    override func handleData(_ areas: [WLAreaBean],addressEditBean: WLAddressEditBean) {
        
        province = WLAreaCatagoryViewController(fetchProvices(areas), config: config, selectedAreaId: addressEditBean.pArea.id)
        
        let cities = fetchCitys(addressEditBean.pArea.id, areas: areas)
        
        city = WLAreaCatagoryViewController(cities, config: config, selectedAreaId: addressEditBean.cArea.id)

        let regions = fetchRegions(addressEditBean.cArea.id, areas: areas)
        
        region = WLAreaCatagoryViewController(regions, config: config, selectedAreaId: addressEditBean.rArea.id)
        
        viewControllers += [province]
        
        if addressEditBean.pArea.name.isEmpty {
            
            viewModel.output.tableData.accept([proHeader])
            
            self.currentIdx = 0
            
            onHeaderClick(cityHeader, ip: IndexPath(item: 0, section: 0))
            
        } else {
            
            proHeader.isSelected = true
            
            proHeader.areaBean = WLAreaManager.default.fetchSomeArea(addressEditBean.pArea.id, areas: fetchProvices(areas))
            
            if !addressEditBean.cArea.name.isEmpty {
                
                cityHeader.isSelected = true
                
                cityHeader.areaBean = WLAreaManager.default.fetchSomeArea(addressEditBean.cArea.id, areas: fetchCitys(addressEditBean.pArea.id, areas: areas))
                
                viewControllers += [city]
                
                if addressEditBean.rArea.name.isEmpty {
                    
                    self.currentIdx = 1
                    
                    viewModel.output.tableData.accept([proHeader,cityHeader])
                    
                    onHeaderClick(proHeader, ip: IndexPath(item: 1, section: 0))
                    
                } else {
                    
                    self.currentIdx = 2
                    
                    regionHeader.isSelected = true
                    
                    regionHeader.areaBean = WLAreaManager.default.fetchSomeArea(addressEditBean.rArea.id, areas: fetchRegions(addressEditBean.cArea.id, areas: areas))
                    
                    viewControllers += [region]
                    
                    viewModel.output.tableData.accept([proHeader,cityHeader,regionHeader])
                    
                    onHeaderClick(proHeader, ip: IndexPath(item: 2, section: 0))
                }
            }
        }
        
        province
            .rx
            .complete
            .subscribe(onNext: { [unowned self] (pro) in
                
                if !pro.name.isEmpty {
                    
                    self.proHeader.isSelected = true
                    
                    self.proHeader.areaBean = pro
                    
                    self.cityHeader.isSelected = false
                    
                    self.cityHeader.areaBean = nil
                    
                    let cities = self.fetchCitys(pro.id, areas: areas)
                    
                    self.viewModel.output.tableData.accept([self.proHeader,self.cityHeader])
                    
                    if self.viewControllers.count > 2 {
                        
                        self.viewControllers.removeLast()
                        
                    } else if self.viewControllers.count > 1 {
                        
                        
                    } else {
                        
                        self.viewControllers += [self.city]
                        
                    }
                    
                    self.onHeaderClick(self.cityHeader, ip: IndexPath(item: 1, section: 0))
                    
                    self.city.updateDatas(cities, selectedAreaId: pro.id)
                }
            })
            .disposed(by: disposed)
        
        city
            .rx
            .complete
            .subscribe(onNext: { [unowned self] (ci) in
                
                if !ci.name.isEmpty {
                    
                    let regions = self.fetchRegions(ci.id, areas: areas)
                    
                    self.cityHeader.isSelected = true
                    
                    self.cityHeader.areaBean = ci
                    
                    if regions.count > 0 {
                        
                        self.regionHeader.isSelected = false
                        
                        self.regionHeader.areaBean = nil
                        
                        self.viewModel.output.tableData.accept( [self.proHeader,self.cityHeader,self.regionHeader])
                        
                        if self.viewControllers.count > 2 {
                            
                            
                        } else {
                            
                            self.viewControllers += [self.region]
                        }
                        
                        self.onHeaderClick(self.cityHeader, ip: IndexPath(item: 2, section: 0))
                        
                        self.region.updateDatas(regions, selectedAreaId: ci.id)
                        
                    } else {
                        // MARK: TODO.... 这里是二级的点击处理 没有三级数据的时候
                        
                        if self.viewControllers.count > 2 {
                            
                            self.viewControllers.removeLast()
                        }
                        
                        self.viewModel.output.tableData.accept( [self.proHeader,self.cityHeader])
                        
                        addressEditBean.pArea = self.proHeader.areaBean
                        
                        addressEditBean.cArea = self.cityHeader.areaBean
                        
                        addressEditBean.rArea = WLAreaBean()
                        
                        self.formData.accept(addressEditBean)
                        
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            })
            .disposed(by: city.disposed)
        
        region
            .rx
            .complete
            .subscribe(onNext: { (reg) in
                
                if !reg.name.isEmpty {
                    
                    //  MARK: TODO.... 这里是三级的点击处理

                    self.regionHeader.isSelected = true
                    
                    self.regionHeader.areaBean = reg
                    
                    addressEditBean.pArea = self.proHeader.areaBean
                    
                    addressEditBean.cArea = self.cityHeader.areaBean
                    
                    addressEditBean.rArea = reg
                    
                    self.formData.accept(addressEditBean)
                    
                    self.viewModel.output.tableData.accept( [self.proHeader,self.cityHeader,self.regionHeader])
                    
                    self.dismiss(animated: true, completion: nil)
                }
            })
            .disposed(by: disposed)
    }
    
    public func fetchProvices(_ areas: [WLAreaBean]) -> [WLAreaBean] {
        
        var result: [WLAreaBean] = []
        
        for item in areas {
            
            if item.arealevel == 1 {
                
                result += [item]
            }
        }
        return result
    }
    
    public func fetchCitys(_ id: Int,areas: [WLAreaBean]) -> [WLAreaBean] {
        
        var result: [WLAreaBean] = []
        
        for item in areas {
            
            if item.arealevel == 2 {
                
                if item.pid == id {
                    
                    result += [item]
                }
            }
        }
        return result
    }
    
    public func fetchRegions(_ id: Int,areas: [WLAreaBean]) -> [WLAreaBean] {
        
        var result: [WLAreaBean] = []
        
        for item in areas {
            
            if item.arealevel == 3 {
                
                if item.pid == id {
                    
                    result += [item]
                }
            }
        }
        return result
    }
    
    override func onHeaderClick(_ area: WLAreaHeaderBean, ip: IndexPath) {
        
        if self.currentIdx < ip.row {
            
            self.pageViewController.setViewControllers([self.viewControllers[ip.row]], direction: .forward, animated: true, completion: nil)
        } else {
            
            self.pageViewController.setViewControllers([self.viewControllers[ip.row]], direction: .reverse, animated: true, completion: nil)
        }
        
        self.collectionView.selectItem(at: ip, animated: false, scrollPosition: .centeredHorizontally)
        
        UIView.animate(withDuration: 0.1) {
            
            if let cell = self.collectionView.cellForItem(at: ip) {
                
                self.moveLine.center = CGPoint(x: cell.center.x, y: WL_Area_Height)
            } else {
                
                self.moveLine.center = CGPoint(x: (CGFloat(ip.row) + 0.5) * WL_Area_Width , y: WL_Area_Height)
            }
        }
        
        self.currentIdx = ip.row
    }
    
    override func configCell(_ cv: UICollectionView, ip: IndexPath, item: WLAreaHeaderBean) -> UICollectionViewCell {
        
        let cell = cv.dequeueReusableCell(withReuseIdentifier: "cell", for: ip) as! WLAreaHeaderCollectionViewCell
        
        cell.type = (item,self.config)
        
        return cell
    }
}
extension WLAreaViewController: UIPageViewControllerDataSource {
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
extension WLAreaViewController: UIPageViewControllerDelegate {
    
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
                    
                    self.moveLine.center = CGPoint(x: cell.center.x, y: WL_Area_Height)
                }
            }
        }
    }
}
