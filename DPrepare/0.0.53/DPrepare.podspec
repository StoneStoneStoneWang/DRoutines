Pod::Spec.new do |spec|
  
  spec.name         = "DPrepare"
  spec.version      = "0.0.53"
  spec.summary      = "A Lib For prepare."
  spec.description  = <<-DESC
  WLProfileKit一个对用户模块的封装
  DESC
  
  spec.homepage     = "https://github.com/StoneStoneStoneWang"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author             = { "StoneStoneStoneWang" => "yuanxingfu1314@163.com" }
  spec.platform     = :ios, "10.0"
  spec.ios.deployment_target = "10.0"
  
  spec.swift_version = '5.0'
  
  spec.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  
  spec.static_framework = true
  
  spec.frameworks = 'UIKit', 'Foundation' ,'CoreServices'
  
  spec.source = { :git => "https://github.com/StoneStoneStoneWang/DRoutines", :tag => "#{spec.version}" }
  
  ## Bean 在java里是模型 在ios 是用model
  spec.subspec 'Bean' do |bean|
    bean.source_files = "Code/DPrepare/Bean/*.{swift}"
    bean.dependency 'ObjectMapper'
  end
  ## Cache
  spec.subspec 'Cache' do |cache|
    cache.source_files = "Code/DPrepare/Cache/*.{swift}"
    cache.dependency 'DPrepare/Bean'
    cache.dependency 'WLThirdUtil/Cache'
  end
  
  ## Api
  spec.subspec 'Api' do |api|
    api.source_files = "Code/DPrepare/Api/*.{swift}"
    api.dependency 'DRoutinesKit'
    api.dependency 'Alamofire'
    api.dependency 'WLReqKit'
    api.dependency 'WLToolsKit/Common'
  end
  ## Req
  spec.subspec 'Req' do |req|
    req.source_files = "Code/DPrepare/Req/*.{swift}"
    req.dependency 'DPrepare/Api'
    req.dependency 'DPrepare/Cache'
    req.dependency 'DReq'
    req.dependency 'RxSwift'
  end
  ## Upload
  spec.subspec 'Upload' do |upload|
    
    upload.source_files = "Code/DPrepare/Upload/*.{swift}"
    upload.dependency 'DPrepare/Cache'
    upload.dependency 'RxSwift'
    upload.dependency 'WLReqKit'
    upload.dependency 'DUpload'
  end
  
  ## Base
  spec.subspec 'Base' do |base|
    base.source_files = "Code/DPrepare/Base/*.{swift}"
    base.dependency 'WLToolsKit/Color'
    base.dependency 'WLBaseViewController/Loading'
    base.dependency 'WLBaseViewController/Inner'
    base.dependency 'RxSwift'
  end
  
  ## TextCheck
  spec.subspec 'TextCheck' do |textCheck|
    textCheck.source_files = "Code/DPrepare/TextCheck/*.{swift}"
    textCheck.dependency 'WLToolsKit/String'
    textCheck.dependency 'WLBaseResult'
  end
  ## ActionShow
  spec.subspec 'ActionShow' do |ac|
    ac.source_files = "Code/DPrepare/ActionShow/*.{swift}"
    ac.frameworks = 'AVFoundation'
    ac.dependency 'WLToolsKit/OpenUrl'
  end
  ## Prepare/Base
  spec.subspec 'PickerImpl' do |pi|
    pi.source_files = "Code/DPrepare/PickerImpl/*.{swift}"
    pi.dependency 'WLToolsKit/Then'
  end
  
  ## ImageShow
  spec.subspec 'ImageShow' do |is|
    is.source_files = "Code/DPrepare/ImageShow/*.{swift}"
    is.dependency 'DPrepare/Base'
    is.dependency 'WLToolsKit/Common'
    is.dependency 'Kingfisher'
    is.dependency 'SnapKit'
    is.dependency 'WLToolsKit/Image'
  end
  ## ImageShow
  spec.subspec 'VideoShow' do |vs|
    vs.source_files = "Code/DPrepare/VideoShow/*.{swift}"
    vs.dependency 'DPrepare/Base'
    vs.dependency 'WLToolsKit/Common'
    vs.dependency 'SnapKit'
    vs.frameworks = 'MediaPlayer'
  end
  
  spec.subspec 'Button' do |button|
    button.source_files = "Code/DCocoa/Button/*.{swift}"
    button.dependency 'RxCocoa'
    button.dependency 'RxSwift'
  end
  spec.subspec 'TextField' do |tf|
    tf.source_files = "Code/DCocoa/TextField/*.{swift}"
    tf.dependency 'RxCocoa'
    tf.dependency 'RxSwift'
  end
end


