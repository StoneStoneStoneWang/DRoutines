//
//  String+MD5.swift
//  SPrepare
//
//  Created by three stone 王 on 2019/6/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import CommonCrypto
import WLToolsKit

extension String {
    
    var s_md5String: String {
        
        guard wl_isEmpty else { fatalError("不能为空") }
        
        guard let data = data(using: .utf8) else { fatalError("不能为空") }
        
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        #if swift(>=5.0)
        _ = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) in
            return CC_MD5(bytes.baseAddress, CC_LONG(data.count), &digest)
        }
        #else
        _ = data.withUnsafeBytes { bytes in
            return CC_MD5(bytes, CC_LONG(data.count), &digest)
        }
        #endif
        
        return digest.map { String(format: "%02x", $0) }.joined()
    }
}
