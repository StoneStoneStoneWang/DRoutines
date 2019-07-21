//
//  WLVideoConvert.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/6.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

public final class WLVideoConvert: NSObject {
    public static func movFileTransformToMp4WithSourceUrl(sourceUrl: URL) -> URL? {
        //以当前时间来为文件命名
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        let fileName = formatter.string(from: date) + ".mp4"
        
        //保存址沙盒路径
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
        let videoSandBoxPath = (docPath as String) + "/ablumVideo" + fileName
        
        print(videoSandBoxPath)
        
        //转码配置
        let avAsset = AVURLAsset(url: sourceUrl, options: nil)
        
        //取视频的时间并处理，用于上传
        let time = avAsset.duration
        let number = Float(CMTimeGetSeconds(time)) - Float(Int(CMTimeGetSeconds(time)))
        let totalSecond = number > 0.5 ? Int(CMTimeGetSeconds(time)) + 1 : Int(CMTimeGetSeconds(time))
        let photoId = String(totalSecond)
        
        let exportSession = AVAssetExportSession(asset: avAsset, presetName: AVAssetExportPresetMediumQuality)
        exportSession?.shouldOptimizeForNetworkUse = true
        exportSession?.outputURL = URL(fileURLWithPath: videoSandBoxPath)
        exportSession?.outputFileType = AVFileType.mp4 //控制转码的格式
        
        let wait = DispatchSemaphore(value: 0)
        
        exportSession?.exportAsynchronously(completionHandler: {
            if exportSession?.status == AVAssetExportSession.Status.failed {
                print("转码失败")
            }
            if exportSession?.status == AVAssetExportSession.Status.completed {
                print("转码成功")
            }
            
            wait.signal()
        })
        
        let timeout = wait.wait(timeout: DispatchTime.distantFuture)
        
        if timeout == .timedOut  {
            
            debugPrint("超时")
        }
        
        wait.suspend()
        
        return URL(fileURLWithPath: videoSandBoxPath)
    }

    public static func getVideoCropPicture(videoUrl: URL) -> UIImage {
        let avAsset = AVAsset(url: videoUrl)
        let generator = AVAssetImageGenerator(asset: avAsset)
        generator.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(0.0, preferredTimescale: 600)
        var actualTime: CMTime = CMTimeMake(value: 0, timescale: 0)
        let imageP = try? generator.copyCGImage(at: time, actualTime: &actualTime)
        let image = UIImage.init(cgImage: imageP!)
        return image
    }
}
