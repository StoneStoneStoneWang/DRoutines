//
//  WLMAMapViewController.swift
//  WLMapkitDemo
//
//  Created by three stone 王 on 2019/5/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLProfileKit
import WLToolsKit
import MapKit
import AMapFoundationKit
import WLThirdUtil.WLLocationUtil
import WLThirdUtil.WLSearchUtil
import SnapKit

@objc (WLMAMapBaseViewController)
open class WLMAMapBaseViewController: WLBaseDisposeViewController {
    
    var config: WLMapConfig!
    
    required public init(_ config: WLMapConfig) {
        
        self.config = config
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public final let mapView: WLMAMapView = WLMAMapView(frame: .zero)
    
    open override func addOwnSubViews() {
        
        view.addSubview(mapView)
        
        view.addSubview(shareAnnotationView)
        
        view.addSubview(buddleView)
    }
    
    fileprivate final let locationManager: WLLocationUtil = WLLocationUtil()
    
    fileprivate final let searchManager: WLSearchUtil = WLSearchUtil()
    
    open var centerCoordinate: CLLocationCoordinate2D! {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            mapView.setCenter(newValue, animated: true)
        }
    }
    
    fileprivate final let buddleView: WLBubbleView = WLBubbleView(frame: .zero)
    
    fileprivate final let shareAnnotation = MAPointAnnotation()
    
    fileprivate final let shareAnnotationView: UIImageView = UIImageView(image: nil)
    
    open override func configOwnSubViews() {
        
        mapView.mapType = .standard
        
        mapView.isShowsUserLocation = true
        
        mapView.showsCompass = false
        
        mapView.showsScale = false
        
        mapView.isShowsUserLocation = true
        
        mapView.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        mapView.frame = view.bounds
        
        mapView.delegate = self
        
        shareAnnotationView.sizeToFit()
        
        shareAnnotationView.center = view.center
        
        if let config = config {
            
            shareAnnotationView.image = UIImage(named: config.annotationIcon)
        }
        
        mapView.addAnnotation(shareAnnotation)
        
        buddleView.frame = CGRect(x: 0, y: 0, width: view.bounds.width / 2, height: 50)
        
        var center = view.center
        
        center.y = view.bounds.height / 2 - 30
        
        buddleView.center = center
        
        buddleView.updateViewData(data: "加载中..." as AnyObject)
        
        locationManager.startLocation { [unowned self] (cl) in
            
            self.centerCoordinate = cl.coordinate
            
            self.mapView.setZoomLevel(16.5, animated: true)
            
            self.searchManager.onGeoSearchResp(AMapGeoPoint.location(withLatitude: CGFloat(cl.coordinate.latitude), longitude: CGFloat(cl.coordinate.longitude)), andResp: { [unowned self] (street, city) in
                
                self.buddleView.updateViewData(data: street as AnyObject)
            })
        }
    }
    
    open func obtainData(_ string: String) {
        
        
    }
}

extension WLMAMapBaseViewController: MAMapViewDelegate {
    
    public func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        
        if updatingLocation {
            
            //            printLog(message: userLocation)
            
            //                        centerLocation = userLocation
        }
    }
    
    public func mapView(_ mapView: MAMapView!, regionWillChangeAnimated animated: Bool) {
        
        view.endEditing(true)
        
        let c2d = mapView.convert(CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2 - 40), toCoordinateFrom: view)
        
        searchManager.onGeoSearchResp(AMapGeoPoint.location(withLatitude: CGFloat(c2d.latitude), longitude: CGFloat(c2d.longitude))) { [unowned self](street, city) in
            
            self.buddleView.updateViewData(data: street as AnyObject)
            
            self.obtainData(street)
            
        }
    }
    
    public func mapView(_ mapView: MAMapView!, didAddAnnotationViews views: [Any]!) {
        
        let userLocalView: MAAnnotationView = views[0] as! MAAnnotationView
        //
        if userLocalView.annotation is MAUserLocation {
            
            let pre = MAUserLocationRepresentation()
            
            if let config = config {
                
                pre.image = UIImage(named: config.locaitonIcon)
            }
            
            pre.showsAccuracyRing = true
            
            mapView.update(pre)
            
            userLocalView.canShowCallout = true
            
            printLog(message: userLocalView)
        } else {
            
            userLocalView.canShowCallout = true
            
            userLocalView.image = nil
            
            mapView.selectAnnotation(shareAnnotation, animated: true)
        }
    }
}
