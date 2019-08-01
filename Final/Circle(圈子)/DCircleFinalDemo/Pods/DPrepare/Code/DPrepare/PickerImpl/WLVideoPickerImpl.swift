//
//  WLVideoPickerImpl.swift
//  HZTC
//
//  Created by three stone 王 on 2019/3/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import CoreServices
import WLToolsKit

public typealias WLVideoPickerHandler = (_ url: URL?) -> ()
@objc (WLVideoPickerImpl)
public final class WLVideoPickerImpl: NSObject {
    
    final let imagePicker: UIImagePickerController = UIImagePickerController().then {
        
        $0.allowsEditing = false
        
        $0.videoQuality = .typeMedium
        
        $0.videoMaximumDuration = 60
        
        $0.mediaTypes = ["public.movie"]
    }
    
    private var videoHandler: WLVideoPickerHandler?
    
    @objc public required override init() {
        super.init()
        imagePicker.delegate = self
    }
    
    @objc public func openVideoPicker(_ from: UIViewController,isPhoto: Bool ,videoHandler: @escaping WLVideoPickerHandler) {
        
        self.videoHandler = videoHandler
        
        if isPhoto {
            
            imagePicker.sourceType = .photoLibrary
            
        } else {
            
            imagePicker.sourceType = .camera
            
            imagePicker.cameraCaptureMode = .video
        }
        
        from.present(imagePicker, animated: true, completion: nil)
    }
}
extension WLVideoPickerImpl: UIImagePickerControllerDelegate ,UINavigationControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        videoHandler?(nil)
        
        picker.dismiss(animated: true, completion: nil)
    }
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL
        
        videoHandler?(videoUrl)
        
        picker.dismiss(animated: true, completion: nil)
    }
}
