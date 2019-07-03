//
//  WLImagePickerImpl.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import CoreServices

public typealias WLImagePickerHandler = (_ img: UIImage?) -> ()
@objc (WLImagePickerImpl)
public final class WLImagePickerImpl: NSObject {
    
    final let imagePicker: UIImagePickerController = UIImagePickerController().then {
        
        $0.allowsEditing = false
        
        $0.mediaTypes = [kUTTypeImage as String]
    }
    
    private var imageHandler: WLImagePickerHandler?
    
    @objc public required override init() {
        super.init()
        imagePicker.delegate = self
    }
    
    @objc public func openImagePicker(_ from: UIViewController,isPhoto: Bool ,imageHandler: @escaping WLImagePickerHandler) {
        
        self.imageHandler = imageHandler
        
        if isPhoto {
            
            imagePicker.sourceType = .photoLibrary
        } else {
            
            imagePicker.sourceType = .camera
        }
        
        from.present(imagePicker, animated: true, completion: nil)
    }
}
extension WLImagePickerImpl: UIImagePickerControllerDelegate ,UINavigationControllerDelegate {
    
    @objc public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        imageHandler?(nil)
        
        picker.dismiss(animated: true, completion: nil)
    }
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var imagePickerc = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        if picker.allowsEditing {
            
            imagePickerc = (info[UIImagePickerController.InfoKey.editedImage] as? UIImage)!
        }
        
        imageHandler?(imagePickerc)
        
        picker.dismiss(animated: true, completion: nil)
    }
}
