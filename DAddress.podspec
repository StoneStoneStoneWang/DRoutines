Pod::Spec.new do |spec|
  
  spec.name         = "DAddress"
  spec.version      = "0.0.29"
  spec.summary      = "A Lib For Address."
  spec.description  = <<-DESC
  Address    地址
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
  
  spec.subspec 'Address' do |address|
    
    ## Bean
    address.subspec 'Bean' do |bean|
      bean.source_files = "Code/DAddress/Address/Bean/*.{swift}"
      bean.dependency 'RxDataSources'
      bean.dependency 'ObjectMapper'
    end
    ## Config
    address.subspec 'Config' do |config|
      config.source_files = "Code/DAddress/Address/Config/*.{swift}"
    end
    # Style
    address.subspec 'Style' do |style|
      style.source_files = "Code/DAddress/Address/Style/*.{swift}"
    end
    
    # VM
    address.subspec 'VM' do |vm|
      vm.source_files = "Code/DAddress/Address/VM/*.{swift}"
      vm.dependency 'DAddress/Address/Bean'
      vm.dependency 'DPrepare/Req'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLBaseResult'
      vm.dependency 'RxCocoa'
    end
    
    ## View
    address.subspec 'View' do |view|
      view.source_files = "Code/DAddress/Address/View/*.{swift}"
      view.dependency 'DAddress/Address/Bean'
      view.dependency 'WLBaseTableView/BTVC'
      view.dependency 'WLBaseTableView/RTV'
      view.dependency 'WLToolsKit/Then'
      view.dependency 'SnapKit'
    end
    
    ## Base
    address.subspec 'Base' do |base|
      base.source_files = "Code/DAddress/Address/Base/*.{swift}"
      base.dependency 'DAddress/Address/VM'
      base.dependency 'DAddress/Address/View'
      base.dependency 'DAddress/Address/Style'
      base.dependency 'WLBaseTableView/Empty'
      base.dependency 'DAddress/Edit/Create'
    end
    # VC
    address.subspec 'VC' do |vc|
      vc.source_files = "Code/DAddress/Address/VC/*.{swift}"
      vc.dependency 'DAddress/Address/Base'
    end
    # Create
    address.subspec 'Create' do |create|
      create.source_files = "Code/DAddress/Address/Create/*.{swift}"
      create.dependency 'DAddress/Address/VC'
    end
    
  end
  ## Edit
  spec.subspec 'Edit' do |edit|
    
    ## Bean
    edit.subspec 'Bean' do |bean|
      bean.source_files = "Code/DAddress/Edit/Bean/*.{swift}"
      bean.dependency 'RxDataSources'
      bean.dependency 'DAddress/Area/Bean'
    end
    
    ## VM
    edit.subspec 'VM' do |vm|
      vm.source_files = "Code/DAddress/Edit/VM/*.{swift}"
      vm.dependency 'DAddress/Address/Bean'
      vm.dependency 'DAddress/Edit/Bean'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'DPrepare/Req'
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseResult'
    end
    edit.subspec 'View' do |view|
      
      view.source_files = "Code/DAddress/Edit/View/*.{swift}"
      view.dependency 'DAddress/Edit/Bean'
      view.dependency 'WLComponentView/TextFeild/Base'
      view.dependency 'SnapKit'
      view.dependency 'WLBaseTableView/BTVC'
      view.dependency 'WLBaseTableView/BTV'
    end
    
    ## Base
    edit.subspec 'Base' do |base|
      base.source_files = "Code/DAddress/Edit/Base/*.{swift}"
      base.dependency 'DAddress/Area/Create'
      base.dependency 'DAddress/Edit/VM'
      base.dependency 'DAddress/Edit/View'
    end
    # VC
    edit.subspec 'VC' do |vc|
      vc.source_files = "Code/DAddress/Edit/VC/*.{swift}"
      vc.dependency 'DAddress/Edit/Base'
    end
    # Create
    edit.subspec 'Create' do |create|
      create.source_files = "Code/DAddress/Edit/Create/*.{swift}"
      create.dependency 'DAddress/Edit/VC'
    end
  end
  
  ## Area
  spec.subspec 'Area' do |area|
    
    ## Bean
    area.subspec 'Bean' do |bean|
      bean.source_files = "Code/DAddress/Area/Bean/*.{swift}"
      bean.dependency 'RxDataSources'
      bean.dependency 'ObjectMapper'
    end
    ## manager
    area.subspec 'Manager' do |manager|
      manager.source_files = "Code/DAddress/Area/Manager/*.{swift}"
      manager.dependency 'DPrepare/Req'
      manager.dependency 'WLBaseResult'
      manager.dependency 'RxCocoa'
      manager.dependency 'DAddress/Area/Bean'
    end
    ## VM
    area.subspec 'VM' do |vm|
      vm.source_files = "Code/DAddress/Area/VM/*.{swift}"
      vm.dependency 'DAddress/Area/Bean'
      vm.dependency 'WLBaseViewModel'
    end
    ## Base
    area.subspec 'View' do |view|
      view.source_files = "Code/DAddress/Area/View/*.{swift}"
      view.dependency 'DAddress/Area/Bean'
      view.dependency 'DAddress/Address/Config'
      view.dependency 'SnapKit'
      view.dependency 'WLBaseTableView/BTVC'
      view.dependency 'WLBaseTableView/BTV'
    end
    ## Base
    area.subspec 'Base' do |base|
      base.source_files = "Code/DAddress/Area/Base/*.{swift}"
      base.dependency 'DAddress/Area/Manager'
      base.dependency 'DAddress/Area/View'
      base.dependency 'DAddress/Area/VM'
      base.dependency 'DAddress/Edit/Bean'
      base.dependency 'DPrepare/Base'
      base.dependency 'WLBaseViewModel'
      base.dependency 'WLBaseTableView/SM'
      base.dependency 'WLBaseTableView/ASM'
      base.dependency 'WLToolsKit/Common'
      base.dependency 'WLThirdUtil/Hud'
    end
    
    # VC
    area.subspec 'VC' do |vc|
      vc.source_files = "Code/DAddress/Area/VC/*.{swift}"
      vc.dependency 'DAddress/Area/Base'
    end
    # Create
    area.subspec 'Create' do |create|
      create.source_files = "Code/DAddress/Area/Create/*.{swift}"
      create.dependency 'DAddress/Area/VC'
    end
  end
  
end
