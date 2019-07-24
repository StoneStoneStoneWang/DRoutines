//
//  ViewController.swift
//  DPrepareDemo
//
//  Created by three stone 王 on 2019/7/3.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import UIKit

class ViewController: WLF1DisposeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        onUserDictResp(WLUserApi.login("18612598269", password: "123457"))
            .subscribe(onNext: { (data) in
                
                debugPrint(data)
                
            }, onError: { (error) in
                
                debugPrint(error)
                
            }).disposed(by: disposed)
    }


}

