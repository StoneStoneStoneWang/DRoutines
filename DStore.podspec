Pod::Spec.new do |spec|
  
  spec.name         = "DStore"
  spec.version      = "0.0.51"
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
      view.dependency 'WLBaseTableView/RTV'
      view.dependency 'WLBaseTableView/BTVC'
    end
    
    ## Base
    cart.subspec 'Base' do |base|
      base.source_files = "Code/DStore/Cart/Base/*.{swift}"
      base.dependency 'DStore/Cart/VM'
      base.dependency 'DStore/Cart/View'
      base.dependency 'DStore/Store/Config'
      base.dependency 'DAddress/Address/Config'
      base.dependency 'WLBaseTableView/ASM'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'WLToolsKit/Common'
      base.dependency 'DPrepare/Base'
    end
    # VC
    cart.subspec 'VC' do |vc|
      vc.source_files = "Code/DStore/Cart/VC/*.{swift}"
      vc.dependency 'DStore/Cart/Base'
      vc.dependency 'DNotification'
    end
    # Create
    cart.subspec 'Create' do |create|
      create.source_files = "Code/DStore/Cart/Create/*.{swift}"
      create.dependency 'DStore/Cart/VC'
    end
  end
  ## Order
  spec.subspec 'Order' do |order|
    ## VM
    order.subspec 'VM' do |vm|
      vm.source_files = "Code/DStore/Order/VM/*.{swift}"
      vm.dependency 'DStore/Store/Bean'
      vm.dependency 'DPrepare/Req'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLBaseResult'
      vm.dependency 'RxCocoa'
    end
    
    ## View
    order.subspec 'View' do |view|
      view.source_files = "Code/DStore/Order/View/*.{swift}"
      view.dependency 'DStore/Store/Bean'
      view.dependency 'WLToolsKit/Then'
      view.dependency 'WLToolsKit/Common'
      view.dependency 'WLToolsKit/Color'
      view.dependency 'SnapKit'
      view.dependency 'Kingfisher'
      view.dependency 'WLBaseTableView/RTV'
      view.dependency 'WLBaseTableView/BTVC'
    end
    
    ## Base
    order.subspec 'Base' do |base|
      base.source_files = "Code/DStore/Order/Base/*.{swift}"
      base.dependency 'DStore/Order/VM'
      base.dependency 'DStore/Order/View'
      base.dependency 'DStore/Store/Config'
      base.dependency 'WLBaseTableView/ASM'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'WLToolsKit/Common'
      base.dependency 'DPrepare/Base'
    end
    # VC
    order.subspec 'VC' do |vc|
      vc.source_files = "Code/DStore/Order/VC/*.{swift}"
      vc.dependency 'DStore/Order/Base'
      vc.dependency 'DNotification'
    end
    # Create
    order.subspec 'Create' do |create|
      create.source_files = "Code/DStore/Order/Create/*.{swift}"
      create.dependency 'DStore/Order/VC'
    end
  end
  
  ## Order
  spec.subspec 'Buy' do |buy|
    ## Bean
    buy.subspec 'Bean' do |bean|
      bean.source_files = "Code/DStore/Buy/Bean/*.{swift}"
      bean.dependency 'DStore/Store/Bean'
    end
    ## VM
    buy.subspec 'VM' do |vm|
      vm.source_files = "Code/DStore/Buy/VM/*.{swift}"
      vm.dependency 'DStore/Buy/Bean'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxCocoa'
    end
    
    ## View
    buy.subspec 'View' do |view|
      view.source_files = "Code/DStore/Buy/View/*.{swift}"
      view.dependency 'DStore/Buy/Bean'
      view.dependency 'WLToolsKit/Then'
      view.dependency 'WLToolsKit/Common'
      view.dependency 'WLToolsKit/Color'
      view.dependency 'SnapKit'
      view.dependency 'Kingfisher'
      view.dependency 'WLBaseTableView/BTV'
      view.dependency 'WLBaseTableView/BTVC'
    end
    
    ## Base
    buy.subspec 'Base' do |base|
      base.source_files = "Code/DStore/Buy/Base/*.{swift}"
      base.dependency 'DStore/Buy/VM'
      base.dependency 'DStore/Buy/View'
      base.dependency 'WLBaseTableView/ASM'
      base.dependency 'WLToolsKit/Common'
      base.dependency 'DPrepare/Base'
      base.dependency 'DStore/Store/Config'
    end
    # VC
    buy.subspec 'VC' do |vc|
      vc.source_files = "Code/DStore/Buy/VC/*.{swift}"
      vc.dependency 'DStore/Buy/Base'
    end
    # Create
    buy.subspec 'Create' do |create|
      create.source_files = "Code/DStore/Buy/Create/*.{swift}"
      create.dependency 'DStore/Buy/VC'
    end
  end
  
  ## Order
  spec.subspec 'OrderConfirm' do |order|
    ## Bean
    order.subspec 'Bean' do |bean|
      bean.source_files = "Code/DStore/OrderConfirm/Bean/*.{swift}"
      bean.dependency 'DStore/Store/Bean'
      bean.dependency 'DAddress/Address/Bean'
      bean.dependency 'WLToolsKit/String'
      bean.dependency 'WLToolsKit/Common'
    end
    ## VM
    order.subspec 'VM' do |vm|
      vm.source_files = "Code/DStore/OrderConfirm/VM/*.{swift}"
      vm.dependency 'DStore/OrderConfirm/Bean'
      vm.dependency 'DPrepare/Req'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLBaseResult'
      vm.dependency 'RxCocoa'
    end
    
    ## View
    order.subspec 'View' do |view|
      view.source_files = "Code/DStore/OrderConfirm/View/*.{swift}"
      view.dependency 'DStore/OrderConfirm/Bean'
      view.dependency 'WLToolsKit/Then'
      view.dependency 'WLToolsKit/Common'
      view.dependency 'WLToolsKit/Color'
      view.dependency 'SnapKit'
      view.dependency 'Kingfisher'
      view.dependency 'WLBaseTableView/RTV'
      view.dependency 'WLBaseTableView/BTVC'
    end
    
    ## Base
    order.subspec 'Base' do |base|
      base.source_files = "Code/DStore/OrderConfirm/Base/*.{swift}"
      base.dependency 'DStore/OrderConfirm/VM'
      base.dependency 'DStore/OrderConfirm/View'
      base.dependency 'DStore/Store/Config'
      base.dependency 'WLBaseTableView/ASM'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'WLToolsKit/Common'
      base.dependency 'DPrepare/Base'
      base.dependency 'DStore/Store/Config'
      base.dependency 'DAddress/Address/Create'
    end
    # VC
    order.subspec 'VC' do |vc|
      vc.source_files = "Code/DStore/OrderConfirm/VC/*.{swift}"
      vc.dependency 'DStore/OrderConfirm/Base'
      vc.dependency 'DNotification'
      vc.dependency 'WLToolsKit/OpenUrl'
    end
    # Create
    order.subspec 'Create' do |create|
      create.source_files = "Code/DStore/OrderConfirm/Create/*.{swift}"
      create.dependency 'DStore/OrderConfirm/VC'
    end
  end
  
  ## detail
  spec.subspec 'StoreDetail' do |detail|
    # Style
    detail.subspec 'Style' do |style|
      style.source_files = "Code/DStore/Detail/Style/*.{swift}"
    end
    ## VM
    detail.subspec 'VM' do |vm|
      vm.source_files = "Code/DStore/Detail/VM/*.{swift}"
      vm.dependency 'DPrepare/Req'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLBaseResult'
      vm.dependency 'RxCocoa'
      vm.dependency 'DStore/Store/Bean'
    end
    
    ## View
    detail.subspec 'View' do |view|
      view.source_files = "Code/DStore/Detail/View/*.{swift}"
      view.dependency 'WLToolsKit/Then'
      view.dependency 'WLToolsKit/Common'
      view.dependency 'WLToolsKit/Color'
      view.dependency 'WLToolsKit/Image'
      view.dependency 'SnapKit'
      view.dependency 'Kingfisher'
      view.dependency 'WLBaseTableView/RTV'
      view.dependency 'WLBaseTableView/BTVC'
      view.dependency 'DStore/Store/Bean'
      
    end
    
    ## Base
    detail.subspec 'Base' do |base|
      base.source_files = "Code/DStore/Detail/Base/*.{swift}"
      base.dependency 'DStore/StoreDetail/VM'
      base.dependency 'DStore/StoreDetail/View'
      base.dependency 'DStore/StoreDetail/Style'
      base.dependency 'WLBaseTableView/ASM'
      base.dependency 'WLBaseTableView/SM'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'WLToolsKit/Common'
      base.dependency 'WLToolsKit/Image'
      base.dependency 'DPrepare/Base'
      base.dependency 'DNotification'
      base.dependency 'DPrepare/ImageShow'
      base.dependency 'DStore/Buy/Create'
      base.dependency 'DNotification'
    end
    # VC
    detail.subspec 'VC' do |vc|
      vc.source_files = "Code/DStore/Detail/VC/*.{swift}"
      vc.dependency 'DStore/StoreDetail/Base'
    end
    # Create
    detail.subspec 'Create' do |create|
      create.source_files = "Code/DStore/Detail/Create/*.{swift}"
      create.dependency 'DStore/StoreDetail/VC'
    end
  end
  
  
end
