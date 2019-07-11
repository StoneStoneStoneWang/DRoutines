Pod::Spec.new do |spec|
  
  spec.name         = "DBanner"
  spec.version      = "0.0.16"
  spec.summary      = "A Lib For setting."
  spec.description  = <<-DESC
  Black 是黑名单模块
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
  
  spec.subspec 'Style' do |style|
    style.source_files = "Code/DBanner/Style/*.{swift}"
  end
  
  ## 'VM'
  spec.subspec 'VM' do |vm|
    vm.source_files = "Code/DBanner/VM/*.{swift}"
    vm.dependency 'RxSwift'
    vm.dependency 'RxCocoa'
    vm.dependency 'WLBaseViewModel'
  end
  
  ## 'View'
  spec.subspec 'View' do |view|
    view.source_files = "Code/DBanner/View/*.{swift}"
    view.dependency 'SnapKit'
    view.dependency 'WLToolsKit/Then'
  end
  
  ## 'Base'
  spec.subspec 'Base' do |base|
    base.source_files = "Code/DBanner/Base/*.{swift}"
    base.dependency 'DBanner/View'
    base.dependency 'DBanner/VM'
    base.dependency 'DBanner/Style'
    base.dependency 'WLToolsKit/Common'
    base.dependency 'DPrepare/Base'
    base.dependency 'RxDataSources'
    base.dependency 'WLBaseTableView/SM'
  end
  spec.subspec 'Create' do |create|
    create.source_files = "Code/DBanner/Create/*.{swift}"
    create.dependency 'DBanner/Base'
  end
end
