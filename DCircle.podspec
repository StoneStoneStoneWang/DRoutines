Pod::Spec.new do |spec|
  
  spec.name         = "DCircle"
  spec.version      = "0.0.16"
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
  
  ## Report
  spec.subspec 'Report' do |report|
    ## Bean
    report.subspec 'Bean' do |bean|
      bean.source_files = "Code/DCircle/Report/Bean/*.{swift}"
      bean.dependency 'RxDataSources'
      bean.dependency 'ObjectMapper'
    end
    ## Config
    report.subspec 'Config' do |config|
      config.source_files = "Code/DCircle/Report/Config/*.{swift}"
    end
    # Style
    report.subspec 'Style' do |style|
      style.source_files = "Code/DCircle/Report/Style/*.{swift}"
    end
    ## VM
    report.subspec 'VM' do |vm|
      vm.source_files = "Code/DCircle/Report/VM/*.{swift}"
      vm.dependency 'DCircle/Report/Bean'
      vm.dependency 'DPrepare/Req'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLBaseResult'
      vm.dependency 'RxCocoa'
    end
    
    ## View
    report.subspec 'View' do |view|
      view.source_files = "Code/DCircle/Report/View/*.{swift}"
      view.dependency 'DCircle/Report/Bean'
      view.dependency 'DCircle/Report/Config'
      view.dependency 'WLBaseTableView/BTVC'
      view.dependency 'WLBaseTableView/BTV'
      view.dependency 'WLToolsKit/Then'
      view.dependency 'SnapKit'
    end
    
    ## Base
    report.subspec 'Base' do |base|
      base.source_files = "Code/DCircle/Report/Base/*.{swift}"
      base.dependency 'DCircle/Report/VM'
      base.dependency 'DCircle/Report/View'
      base.dependency 'DCircle/Report/Style'
      base.dependency 'WLBaseTableView/ASM'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'WLToolsKit/Common'
      base.dependency 'DPrepare/Base'
    end
    # VC
    report.subspec 'VC' do |vc|
      vc.source_files = "Code/DCircle/Report/VC/*.{swift}"
      vc.dependency 'DCircle/Report/Base'
    end
    # Create
    report.subspec 'Create' do |create|
      create.source_files = "Code/DCircle/Report/Create/*.{swift}"
      create.dependency 'DCircle/Report/VC'
    end
  end
  
  ## Publish
  spec.subspec 'Publish' do |publish|
    ## Bean
    publish.subspec 'Bean' do |bean|
      bean.source_files = "Code/DCircle/Publish/Bean/*.{swift}"
      bean.dependency 'RxDataSources'
      bean.dependency 'ObjectMapper'
      bean.dependency 'WLToolsKit/JsonCast'
      bean.dependency 'DPrepare/Bean'
      bean.dependency 'DPrepare/PickerImpl'
      bean.dependency 'DPrepare/ActionShow'
    end
    # Config
    publish.subspec 'Config' do |config|
      config.source_files = "Code/DCircle/Publish/Config/*.{swift}"
    end
    
    # Config
    publish.subspec 'Style' do |style|
      style.source_files = "Code/DCircle/Publish/Style/*.{swift}"
    end
    # Config
    publish.subspec 'Delegate' do |delegate|
      delegate.source_files = "Code/DCircle/Publish/Delegate/*.{swift}"
    end
    
    # VM
    publish.subspec 'VM' do |vm|
      vm.source_files = "Code/DCircle/Publish/VM/*.{swift}"
      vm.dependency 'DCircle/Publish/Bean'
      vm.dependency 'DCircle/Publish/Style'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'DPrepare/Req'
      vm.dependency 'RxSwift'
      vm.dependency 'RxCocoa'
      vm.dependency 'WLToolsKit/String'
      vm.dependency 'WLBaseResult'
    end
    
    ## View
    publish.subspec 'View' do |view|
      view.source_files = "Code/DCircle/Publish/View/*.{swift}"
      view.dependency 'DCircle/Publish/Bean'
      view.dependency 'WLBaseTableView/BTVC'
      view.dependency 'WLBaseTableView/BTV'
      view.dependency 'WLToolsKit/Then'
      view.dependency 'WLComponentView/TextFeild/NickName'
      view.dependency 'SnapKit'
    end
    
    publish.subspec 'VideoConvert' do |videoConvert|
      videoConvert.source_files = "Code/DCircle/Publish/VideoConvert/*.{swift}"
    end
    # Base
    publish.subspec 'Base' do |base|
      base.source_files = "Code/DCircle/Publish/Base/*.{swift}"
      base.dependency 'DCircle/Publish/VM'
      base.dependency 'DCircle/Publish/View'
      base.dependency 'DCircle/Publish/Style'
      base.dependency 'DCircle/Publish/Config'
      base.dependency 'DCircle/Publish/Delegate'
      base.dependency 'DCircle/Publish/VideoConvert'
      base.dependency 'WLBaseTableView/ASM'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'DCircle/TextEdit/Create'
      base.dependency 'DPrepare/Base'
      base.dependency 'DProfile/UserInfo/VM'
    end
    
    # Base
    publish.subspec 'VC' do |vc|
      vc.source_files = "Code/DCircle/Publish/VC/*.{swift}"
      vc.dependency 'DCircle/Publish/Base'
    end
    # Base
    publish.subspec 'Create' do |create|
      create.source_files = "Code/DCircle/Publish/Create/*.{swift}"
      create.dependency 'DCircle/Publish/VC'
    end
    
  end
  ## TextEdit
  spec.subspec 'TextEdit' do |texdtEdit|
    ## Base
    texdtEdit.subspec 'Base' do |base|
      base.source_files = "Code/DCircle/TextEdit/Base/*.{swift}"
      base.dependency 'RxCocoa'
      base.dependency 'DPrepare/Base'
      base.dependency 'WLToolsKit/Then'
      base.dependency 'DCircle/Publish/Config'
    end
    ## VC
    texdtEdit.subspec 'VC' do |vc|
      vc.source_files = "Code/DCircle/TextEdit/VC/*.{swift}"
      vc.dependency 'DCircle/TextEdit/Base'
      vc.dependency 'WLBaseViewController/Navi'
      vc.dependency 'WLToolsKit/Common'
      vc.dependency 'WLToolsKit/Color'
    end
    
    texdtEdit.subspec 'Create' do |create|
      create.source_files = "Code/DCircle/TextEdit/Create/*.{swift}"
      create.dependency 'DCircle/TextEdit/VC'
    end
    
  end
  
  spec.subspec 'Circle' do |circle|
    
    circle.subspec 'Config' do |config|
      config.source_files = "Code/DCircle/Circle/Config/*.{swift}"
    end
    circle.subspec 'Style' do |style|
      style.source_files = "Code/DCircle/Circle/Style/*.{swift}"
    end
    
    circle.subspec 'Delegate' do |delegate|
      delegate.source_files = "Code/DCircle/Circle/Delegate/*.{swift}"
    end
    circle.subspec 'VM' do |vm|
      vm.source_files = "Code/DCircle/Circle/VM/*.{swift}"
      vm.dependency 'DCircle/Publish/Bean'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxSwift'
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseResult'
      vm.dependency 'DPrepare/Req'
    end
    circle.subspec 'View' do |view|
      view.source_files = "Code/DCircle/Circle/View/*.{swift}"
      view.dependency 'DCircle/Publish/Bean'
      view.dependency 'DCircle/Circle/Config'
      view.dependency 'WLBaseTableView/BTVC'
      view.dependency 'WLBaseTableView/RTV'
      view.dependency 'WLBaseTableView/Empty'
      view.dependency 'WLToolsKit/Then'
      view.dependency 'SnapKit'
      view.dependency 'Kingfisher'
    end
    circle.subspec 'Base' do |base|
      base.source_files = "Code/DCircle/Circle/Base/*.{swift}"
      base.dependency 'DCircle/Circle/VM'
      base.dependency 'DCircle/Circle/View'
      base.dependency 'DCircle/Circle/Style'
      base.dependency 'DCircle/Circle/Delegate'
      base.dependency 'WLBaseTableView/ASM'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'DPrepare/Base'
      base.dependency 'DLogin/Login/CheckLogin'
    end
    # VC
    circle.subspec 'VC' do |vc|
      vc.source_files = "Code/DCircle/Circle/VC/*.{swift}"
      vc.dependency 'DCircle/Circle/Base'
    end
    # Create
    circle.subspec 'Create' do |create|
      create.source_files = "Code/DCircle/Circle/Create/*.{swift}"
      create.dependency 'DCircle/Circle/VC'
    end
  end
  # Content
  spec.subspec 'Content' do |content|
    
    ## Config
    content.subspec 'Config' do |config|
      config.source_files = "Code/DCircle/Content/Config/*.{swift}"
    end
    # Style
    content.subspec 'Style' do |style|
      style.source_files = "Code/DCircle/Content/Style/*.{swift}"
    end
    # Delegate
    content.subspec 'Delegate' do |delegate|
      delegate.source_files = "Code/DCircle/Content/Delegate/*.{swift}"
    end
    ## VM
    content.subspec 'VM' do |vm|
      vm.source_files = "Code/DCircle/Content/VM/*.{swift}"
      vm.dependency 'DCircle/Publish/Bean'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxSwift'
      vm.dependency 'RxCocoa'
    end
    
    ## View
    content.subspec 'View' do |view|
      view.source_files = "Code/DCircle/Content/View/*.{swift}"
      view.dependency 'DCircle/Publish/Bean'
      view.dependency 'WLBaseTableView/BTVC'
      view.dependency 'WLBaseTableView/RTV'
      view.dependency 'WLToolsKit/Then'
      view.dependency 'WLToolsKit/Image'
      view.dependency 'SnapKit'
      view.dependency 'Kingfisher'
    end
    
    ## Base
    content.subspec 'Base' do |base|
      base.source_files = "Code/DCircle/Content/Base/*.{swift}"
      base.dependency 'DCircle/Content/VM'
      base.dependency 'DCircle/Content/View'
      base.dependency 'DCircle/Content/Style'
      base.dependency 'DCircle/Content/Config'
      base.dependency 'DCircle/Content/Delegate'
      base.dependency 'WLBaseTableView/ASM'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'DPrepare/Base'
      base.dependency 'DPrepare/ImageShow'
      base.dependency 'DPrepare/VideoShow'
      
    end
    # VC
    content.subspec 'VC' do |vc|
      vc.source_files = "Code/DCircle/Content/VC/*.{swift}"
      vc.dependency 'DCircle/Content/Base'
    end
    # Create
    content.subspec 'Create' do |create|
      create.source_files = "Code/DCircle/Content/Create/*.{swift}"
      create.dependency 'DCircle/Content/VC'
    end
  end
  
  # Comment
  spec.subspec 'Comment' do |comment|
    
    ## Config
    comment.subspec 'Config' do |config|
      config.source_files = "Code/DCircle/Comment/Config/*.{swift}"
    end
    # Style
    comment.subspec 'Style' do |style|
      style.source_files = "Code/DCircle/Comment/Style/*.{swift}"
    end
    # Delegate
    comment.subspec 'Delegate' do |delegate|
      delegate.source_files = "Code/DCircle/Comment/Delegate/*.{swift}"
    end
    comment.subspec 'Bean' do |bean|
      bean.source_files = "Code/DCircle/Comment/Bean/*.{swift}"
      bean.dependency 'RxDataSources'
      bean.dependency 'ObjectMapper'
      bean.dependency 'WLToolsKit/JsonCast'
      bean.dependency 'DPrepare/Bean'
    end
    ## VM
    comment.subspec 'VM' do |vm|
      vm.source_files = "Code/DCircle/Comment/VM/*.{swift}"
      vm.dependency 'DCircle/Comment/Bean'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'DPrepare/Req'
      vm.dependency 'RxSwift'
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseResult'
    end
    
    ## View
    comment.subspec 'View' do |view|
      view.source_files = "Code/DCircle/Comment/View/*.{swift}"
      view.dependency 'DCircle/Comment/Bean'
      view.dependency 'DCircle/Comment/Config'
      view.dependency 'WLBaseTableView/BTVC'
      view.dependency 'WLBaseTableView/RTV'
      view.dependency 'WLToolsKit/Then'
      view.dependency 'WLToolsKit/Image'
      view.dependency 'SnapKit'
      view.dependency 'Kingfisher'
    end
    
    ## Base
    comment.subspec 'Base' do |base|
      base.source_files = "Code/DCircle/Comment/Base/*.{swift}"
      base.dependency 'DCircle/Comment/VM'
      base.dependency 'DCircle/Comment/View'
      base.dependency 'DCircle/Comment/Style'
      base.dependency 'DCircle/Comment/Delegate'
      base.dependency 'WLBaseTableView/ASM'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'DPrepare/Base'
    end
    # VC
    comment.subspec 'VC' do |vc|
      vc.source_files = "Code/DCircle/Comment/VC/*.{swift}"
      vc.dependency 'DCircle/Comment/Base'
    end
    # Create
    comment.subspec 'Create' do |create|
      create.source_files = "Code/DCircle/Comment/Create/*.{swift}"
      create.dependency 'DCircle/Comment/VC'
    end
  end
  
  # Detail
  spec.subspec 'Detail' do |detail|
    
    # Style
    detail.subspec 'Style' do |style|
      style.source_files = "Code/DCircle/Detail/Style/*.{swift}"
    end
    # Delegate
    detail.subspec 'Delegate' do |delegate|
      delegate.source_files = "Code/DCircle/Detail/Delegate/*.{swift}"
    end
    ## VM
    detail.subspec 'VM' do |vm|
      vm.source_files = "Code/DCircle/Detail/VM/*.{swift}"
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxSwift'
      vm.dependency 'RxCocoa'
    end
    
    ## View
    detail.subspec 'View' do |view|
      view.source_files = "Code/DCircle/Detail/View/*.{swift}"
      view.dependency 'DCircle/Comment/Create'
      view.dependency 'DCircle/Content/Create'
    end
    
    ## Base
    detail.subspec 'Base' do |base|
      base.source_files = "Code/DCircle/Detail/Base/*.{swift}"
      base.dependency 'DCircle/Detail/VM'
      base.dependency 'DCircle/Detail/View'
      base.dependency 'DCircle/Detail/Style'
      base.dependency 'DCircle/Detail/Delegate'
      base.dependency 'DLogin/Login/CheckLogin'
      base.dependency 'DCircle/Circle/VM'
    end
    # VC
    detail.subspec 'VC' do |vc|
      vc.source_files = "Code/DCircle/Detail/VC/*.{swift}"
      vc.dependency 'DCircle/Detail/Base'
    end
    # Create
    detail.subspec 'Create' do |create|
      create.source_files = "Code/DCircle/Detail/Create/*.{swift}"
      create.dependency 'DCircle/Detail/VC'
    end
  end
  
end
