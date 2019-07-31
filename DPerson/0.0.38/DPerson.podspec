Pod::Spec.new do |spec|
  
  spec.name         = "DPerson"
  spec.version      = "0.0.38"
  spec.summary      = "A Lib For Person."
  spec.description  = <<-DESC
  Black 是黑名单
  Focus 是关注
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
  
  # 黑名单
  spec.subspec 'Black' do |black|
    
    ## 'Style'
    black.subspec 'Style' do |style|
      style.source_files = "Code/DPerson/Black/Style/*.{swift}"
    end
    ## 'Config'
    black.subspec 'Config' do |config|
      config.source_files = "Code/DPerson/Black/Config/*.{swift}"
    end
    ## 'Bean'
    black.subspec 'Bean' do |bean|
      bean.source_files = "Code/DPerson/Black/Bean/*.{swift}"
      bean.dependency 'DPrepare/Bean'
      bean.dependency 'RxDataSources'
    end
    
    ## 'VM'
    black.subspec 'VM' do |vm|
      vm.source_files = "Code/DPerson/Black/VM/*.{swift}"
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLToolsKit/Common'
      vm.dependency 'RxSwift'
      vm.dependency 'RxCocoa'
      vm.dependency 'DPerson/Black/Bean'
      vm.dependency 'WLBaseResult'
      vm.dependency 'DPrepare/Req'
    end
    
    ## 'View'
    black.subspec 'View' do |view|
      view.source_files = "Code/DPerson/Black/View/**/*.{swift}"
      view.dependency 'SnapKit'
      view.dependency 'Kingfisher'
      view.dependency 'WLToolsKit/Then'
      view.dependency 'WLToolsKit/Color'
      view.dependency 'WLToolsKit/Common'
      view.dependency 'DPerson/Black/Bean'
      view.dependency 'WLBaseTableView/RTV'
      view.dependency 'WLBaseTableView/BTVC'
      view.dependency 'WLBaseTableView/Empty'
      view.dependency 'DPerson/Black/Config'
    end
    
    ## 'Base'
    black.subspec 'Base' do |base|
      base.source_files = "Code/DPerson/Black/Base/*.{swift}"
      base.dependency 'DPerson/Black/VM'
      base.dependency 'DPerson/Black/View'
      base.dependency 'DPerson/Black/Config'
      base.dependency 'DPerson/Black/Style'
      base.dependency 'WLBaseTableView/ASM'
      base.dependency 'WLToolsKit/Common'
      base.dependency 'RxDataSources'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'DPrepare/Base'
      base.dependency 'DNotification'
    end
    
    ## 'VC'
    black.subspec 'VC' do |vc|
      vc.source_files = "Code/DPerson/Black/VC/*.{swift}"
      vc.dependency 'DPerson/Black/Base'
    end
    
    ## Create
    black.subspec 'Create' do |create|
      create.source_files = "Code/DPerson/Black/Create/*.{swift}"
      create.dependency 'DPerson/Black/VC'
    end
  end
  
  spec.subspec 'Focus' do |focus|
    
    ## 'Style'
    focus.subspec 'Style' do |style|
      style.source_files = "Code/DPerson/Focus/Style/*.{swift}"
    end
    ## 'Config'
    focus.subspec 'Config' do |config|
      config.source_files = "Code/DPerson/Focus/Config/*.{swift}"
    end
    ## 'Bean'
    focus.subspec 'Bean' do |bean|
      bean.source_files = "Code/DPerson/Focus/Bean/*.{swift}"
      bean.dependency 'DPrepare/Bean'
      bean.dependency 'RxDataSources'
    end
    
    ## 'VM'
    focus.subspec 'VM' do |vm|
      vm.source_files = "Code/DPerson/Focus/VM/*.{swift}"
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLToolsKit/Common'
      vm.dependency 'RxSwift'
      vm.dependency 'RxCocoa'
      vm.dependency 'DPerson/Focus/Bean'
      vm.dependency 'WLBaseResult'
      vm.dependency 'DPrepare/Req'
    end
    
    ## 'View'
    focus.subspec 'View' do |view|
      view.source_files = "Code/DPerson/Focus/View/**/*.{swift}"
      view.dependency 'SnapKit'
      view.dependency 'Kingfisher'
      view.dependency 'WLToolsKit/Then'
      view.dependency 'WLToolsKit/Color'
      view.dependency 'WLToolsKit/Common'
      view.dependency 'DPerson/Focus/Bean'
      view.dependency 'WLBaseTableView/RTV'
      view.dependency 'WLBaseTableView/BTVC'
      view.dependency 'WLBaseTableView/Empty'
      view.dependency 'DPerson/Focus/Config'
    end
    
    ## 'Base'
    focus.subspec 'Base' do |base|
      base.source_files = "Code/DPerson/Focus/Base/*.{swift}"
      base.dependency 'DPerson/Focus/VM'
      base.dependency 'DPerson/Focus/View'
      base.dependency 'DPerson/Focus/Config'
      base.dependency 'DPerson/Focus/Style'
      base.dependency 'WLBaseTableView/ASM'
      base.dependency 'WLToolsKit/Common'
      base.dependency 'RxDataSources'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'DPrepare/Base'
      base.dependency 'DNotification'
    end
    
    ## 'VC'
    focus.subspec 'VC' do |vc|
      vc.source_files = "Code/DPerson/Focus/VC/*.{swift}"
      vc.dependency 'DPerson/Focus/Base'
    end
    
    ## Create
    focus.subspec 'Create' do |create|
      create.source_files = "Code/DPerson/Focus/Create/*.{swift}"
      create.dependency 'DPerson/Focus/VC'
    end
  end
  
end


