Pod::Spec.new do |spec|
  
  spec.name         = "DStore"
  spec.version      = "0.0.45"
  spec.summary      = "A Lib For store."
  spec.description  = <<-DESC
  store    是商城
  Content  是内容模块
  Detail   是详情模块
  Comment   是评论你模块
  Circle  是圈子模块
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
  
  ## Store
  spec.subspec 'Store' do |store|
    ## Bean
    store.subspec 'Bean' do |bean|
      bean.source_files = "Code/DStore/Store/Bean/*.{swift}"
      bean.dependency 'RxDataSources'
      bean.dependency 'ObjectMapper'
      bean.dependency 'DPrepare/Bean'
      bean.dependency 'WLToolsKit/JsonCast'
    end
    
    ## Config
    store.subspec 'Config' do |config|
      config.source_files = "Code/DStore/Store/Config/*.{swift}"
    end
    # Style
    store.subspec 'Style' do |style|
      style.source_files = "Code/DStore/Store/Style/*.{swift}"
    end
    ## VM
    store.subspec 'VM' do |vm|
      vm.source_files = "Code/DStore/Store/VM/*.{swift}"
      vm.dependency 'DStore/Store/Bean'
      vm.dependency 'DPrepare/Req'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLBaseResult'
      vm.dependency 'RxCocoa'
    end
    
    ## View
    store.subspec 'View' do |view|
      view.source_files = "Code/DStore/Store/View/*.{swift}"
      view.dependency 'DStore/Store/Bean'
      view.dependency 'DStore/Store/Config'
      view.dependency 'MJRefresh'
      view.dependency 'WLToolsKit/Then'
      view.dependency 'WLToolsKit/Common'
      view.dependency 'WLToolsKit/Color'
      view.dependency 'SnapKit'
      view.dependency 'Kingfisher'
      
    end
    
    ## Base
    store.subspec 'Base' do |base|
      base.source_files = "Code/DStore/Store/Base/*.{swift}"
      base.dependency 'DStore/Store/VM'
      base.dependency 'DStore/Store/View'
      base.dependency 'DStore/Store/Style'
      base.dependency 'WLBaseTableView/ASM'
      base.dependency 'WLBaseTableView/SM'
      base.dependency 'WLBaseTableView/RTV'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'WLToolsKit/Common'
      base.dependency 'DPrepare/Base'
      base.dependency 'DNotification'
    end
    # VC
    store.subspec 'VC' do |vc|
      vc.source_files = "Code/DStore/Store/VC/*.{swift}"
      vc.dependency 'DStore/Store/Base'
    end
    # Create
    store.subspec 'Create' do |create|
      create.source_files = "Code/DStore/Store/Create/*.{swift}"
      create.dependency 'DStore/Store/VC'
    end
  end
  
  
  ## Cart
  spec.subspec 'Cart' do |cart|
    ## VM
    cart.subspec 'VM' do |vm|
      vm.source_files = "Code/DStore/Cart/VM/*.{swift}"
      vm.dependency 'DStore/Store/Bean'
      vm.dependency 'DPrepare/Req'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLBaseResult'
      vm.dependency 'RxCocoa'
    end
    
    ## View
    cart.subspec 'View' do |view|
      view.source_files = "Code/DStore/Cart/View/*.{swift}"
      view.dependency 'DStore/Store/Bean'
      view.dependency 'WLToolsKit/Then'
      view.dependency 'WLToolsKit/Common'
      view.dependency 'WLToolsKit/Color'
      view.dependency 'SnapKit'
      view.dependency 'Kingfisher'
      view.dependency 'WLBaseTableView/BTV'
      view.dependency 'WLBaseTableView/BTVC'
    end
    
    ## Base
    cart.subspec 'Base' do |base|
      base.source_files = "Code/DStore/Cart/Base/*.{swift}"
      base.dependency 'DStore/Cart/VM'
      base.dependency 'DStore/Cart/View'
      base.dependency 'DAddress/Address/Config'
      base.dependency 'WLBaseTableView/ASM'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'WLToolsKit/Common'
      base.dependency 'DPrepare/Base'
    end
    # VC
    cart.subspec 'VC' do |vc|
      vc.source_files = "Code/DStore/Cart/VC/*.{swift}"
      vc.dependency 'DStore/Store/Base'
      vc.dependency 'DNotification'
    end
    # Create
    cart.subspec 'Create' do |create|
      create.source_files = "Code/DStore/Cart/Create/*.{swift}"
      create.dependency 'DStore/Store/VC'
    end
  end
  
end
