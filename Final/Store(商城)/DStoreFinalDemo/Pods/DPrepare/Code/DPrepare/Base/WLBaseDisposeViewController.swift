//
//  WLBaseDisposeViewController.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import UIKit
import WLBaseViewController
import RxSwift
import WLToolsKit
@objc (WLBaseDisposeViewController)
open class WLBaseDisposeViewController: WLBaseViewController {
    
    public final let disposed: DisposeBag = DisposeBag()
}
@objc (WLOCLoadingDisposeViewController)
open class WLOCLoadingDisposeViewController: WLLoadingDisposeViewController {
    
    public typealias WLReloadAction = () -> ()
    
    @objc public var reloadAtion: WLReloadAction!
    
    open override func onReload() {
        
        loadingView.onLoadingStatusChanged(.reload)
        
        reloadAtion()
    }
}

@objc (WLLoadingDisposeViewController)
open class WLLoadingDisposeViewController: WLLoadingViewController {
    
    public final let disposed: DisposeBag = DisposeBag()
    
}

@objc (WLLoadingDisposeF1ViewController)
open class WLLoadingDisposeF1ViewController: WLLoadingDisposeViewController {
    
    open override func configOwnProperties() {
        super.configOwnProperties()
        
        view.backgroundColor = WLHEXCOLOR(hexColor: "#f1f1f1")
    }
}

@objc (WLInnerDisposeViewController)
open class WLInnerDisposeViewController: WLInnerViewController {
    
    public final let disposed: DisposeBag = DisposeBag()
}

@objc (WLF1DisposeViewController)
open class WLF1DisposeViewController: WLBaseDisposeViewController {
    
    open override func configOwnProperties() {
        super.configOwnProperties()
        
        view.backgroundColor = WLHEXCOLOR(hexColor: "#f1f1f1")
    }
}
