Pod::Spec.new do |spec|
  
  spec.name         = "DSetting"
  spec.version      = "0.0.9"
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
  
  spec.subspec 'Setting' do |setting|
    
    ## 'Bean'
    setting.subspec 'Bean' do |bean|
      bean.source_files = "Code/DSetting/Bean/*.{swift}"
      bean.dependency 'DPrepare/Cache'
    end
    
    ## 'VM'
    setting.subspec 'VM' do |vm|
      vm.source_files = "Code/DSetting/VM/*.{swift}"
      vm.dependency 'DSetting/Setting/Bean'
      vm.dependency 'RxSwift'
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
    end
    
    ## 'View'
    setting.subspec 'View' do |view|
      view.source_files = "Code/DSetting/View/*.{swift}"
      view.dependency 'DSetting/Setting/Bean'
      view.dependency 'SnapKit'
      view.dependency 'WLBaseTableView/BTVC'
      view.dependency 'WLBaseTableView/BTV'
    end
    
    ## 'Bean'
    setting.subspec 'VC' do |vc|
      vc.source_files = "Code/DSetting/VC/*.{swift}"
      vc.dependency 'DSetting/Setting/View'
      vc.dependency 'DLogin/Login/CheckLogin'
      vc.dependency 'DPerson/Black/Create'
      vc.dependency 'DSetting/Setting/VM'
      vc.dependency 'WLBaseTableView/SM'
    end
    
    ## 'Bean'
    setting.subspec 'Create' do |create|
      create.source_files = "Code/DSetting/Create/*.{swift}"
      create.dependency 'DSetting/Setting/VC'
    end
  end
end


