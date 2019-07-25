Pod::Spec.new do |spec|
  
  spec.name         = "DUpload"
  spec.version      = "0.0.31"
  spec.summary      = "A Lib For upload."
  spec.description  = <<-DESC
  DUpload一个对象存储的库
  DESC
  
  spec.homepage     = "https://github.com/StoneStoneStoneWang"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author             = { "StoneStoneStoneWang" => "yuanxingfu1314@163.com" }
  spec.platform     = :ios, "10.0"
  spec.ios.deployment_target = "10.0"
  
  spec.swift_version = '5.0'
  
  spec.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  
  spec.static_framework = true
  
  spec.frameworks = 'UIKit', 'Foundation'
  
  spec.source = { :git => "https://github.com/StoneStoneStoneWang/DRoutines", :tag => "#{spec.version}" }
  
  spec.vendored_frameworks = 'Upload/DUpload.framework'
  
  spec.dependency 'AFNetworking'
  
  spec.dependency 'DSign'
  
  spec.dependency 'DRoutinesKit'
  
  spec.dependency 'WLThirdUtil/Ali/ObjCache'
  
end


