
Pod::Spec.new do |spec|
  
  spec.name         = "DMap"
  spec.version      = "0.0.17"
  spec.summary      = "A Lib For Report."
  spec.description  = <<-DESC
  Report    是个人中心模块
  About      是关于我们模块
  UserInfo   是用户模块
  NickName   是用户昵称模块
  Signature  是个性签名模块
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
  
  # Config
  spec.subspec 'Config' do |config|
    config.source_files = "Code/DMap/Config/*.{swift}"
  end
  
  ## Bean
  spec.subspec 'Bean' do |bean|
    bean.source_files = "Code/DMap/Bean/*.{swift}"
    bean.dependency 'ObjectMapper'
  end
  # Style
  #  spec.subspec 'Style' do |style|
  #    style.source_files = "Code/DMap/Style/*.{swift}"
  #  end
  # VM
  #  spec.subspec 'VM' do |vm|
  #    vm.source_files = "Code/DMap/VM/*.{swift}"
  #    vm.dependency 'DMap/Bean'
  #    vm.dependency 'DMap/Style'
  #    vm.dependency 'WLBaseViewModel'
  #    vm.dependency 'DPrepare/Req'
  #    vm.dependency 'RxSwift'
  #    vm.dependency 'RxCocoa'
  #    vm.dependency 'WLToolsKit/String'
  #    vm.dependency 'WLBaseResult'
  #  end
  
  ## View
  spec.subspec 'View' do |view|
    view.source_files = "Code/DMap/View/*.{swift}"
    view.dependency 'DMap/Bean'
    view.dependency 'WLBaseTableView/BTVC'
    view.dependency 'WLBaseTableView/BTV'
    view.dependency 'WLToolsKit/Then'
    view.dependency 'WLComponentView/TextFeild/Base'
    view.dependency 'SnapKit'
    view.dependency 'WLThirdUtil/Ali/AMap'
  end
  
  #  # Base
  #  spec.subspec 'Base' do |base|
  #    base.source_files = "Code/DMap/Base/*.{swift}"
  #    base.dependency 'DMap/VM'
  #    base.dependency 'DMap/View'
  #    base.dependency 'DMap/Style'
  #    base.dependency 'DMap/Config'
  #    base.dependency 'DPrepare/Base'
  #    base.dependency 'WLThirdUtil/Ali/Location'
  #    base.dependency 'WLThirdUtil/Ali/Search'
  #  end
  #
  #  # VC
  #  spec.subspec 'VC' do |vc|
  #    vc.source_files = "Code/DMap/VC/*.{swift}"
  #    vc.dependency 'DMap/Base'
  #  end
  #  # Create
  #  spec.subspec 'Create' do |create|
  #    create.source_files = "Code/DMap/Create/*.{swift}"
  #    create.dependency 'DMap/VC'
  #  end
  
end
