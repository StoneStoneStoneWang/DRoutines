Pod::Spec.new do |spec|
  
  spec.name         = "DWelcome"
  spec.version      = "0.0.37"
  spec.summary      = "A Lib For welcome."
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
  
  spec.frameworks = 'UIKit', 'Foundation'
  
  spec.source = { :git => "https://github.com/StoneStoneStoneWang/DRoutines", :tag => "#{spec.version}" }
  
  ## 'Style'
  spec.subspec 'Style' do |style|
    style.source_files = "Code/DWelcome/Style/*.{swift}"
  end
  ## 'Config'
  spec.subspec 'Config' do |config|
    config.source_files = "Code/DWelcome/Config/*.{swift}"
  end
  
  ## 'VM'
  spec.subspec 'VM' do |vm|
    vm.source_files = "Code/DWelcome/VM/*.{swift}"
    vm.dependency 'DWelcome/Style'
    vm.dependency 'WLBaseViewModel'
    vm.dependency 'WLToolsKit/Common'
    vm.dependency 'RxSwift'
    vm.dependency 'RxCocoa'
  end
  
  ## 'View'
  spec.subspec 'View' do |view|
    view.source_files = "Code/DWelcome/View/*.{swift}"
    view.dependency 'SnapKit'
    view.dependency 'WLToolsKit/Then'
  end
  
  ## 'Base'
  spec.subspec 'Base' do |base|
    base.source_files = "Code/DWelcome/Base/*.{swift}"
    base.dependency 'DPrepare/Base'
    base.dependency 'DPrepare/Button'
    base.dependency 'DWelcome/VM'
    base.dependency 'DWelcome/View'
    base.dependency 'DWelcome/Config'
    base.dependency 'WLToolsKit/Color'
    base.dependency 'WLBaseTableView/SM'
    base.dependency 'RxDataSources'
    base.dependency 'DNotification'
  end
  
  ## 'VC'
  spec.subspec 'VC' do |vc|
    vc.source_files = "Code/DWelcome/VC/*.{swift}"
    vc.dependency 'DWelcome/Base'
  end
  
  ## Create
  spec.subspec 'Create' do |create|
    create.source_files = "Code/DWelcome/Create/*.{swift}"
    create.dependency 'DWelcome/VC'
  end
  
end


