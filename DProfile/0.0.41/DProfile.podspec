
Pod::Spec.new do |spec|
  
  spec.name         = "DProfile"
  spec.version      = "0.0.41"
  spec.summary      = "A Lib For Profile."
  spec.description  = <<-DESC
  Profile    是个人中心模块
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
  
  ## Profile
  spec.subspec 'Profile' do |profile|
    ## Bean
    profile.subspec 'Bean' do |bean|
      bean.source_files = "Code/DProfile/Profile/Bean/*.{swift}"
      bean.dependency 'DProfile/Profile/Manager'
      bean.dependency 'DRoutinesKit'
      bean.dependency 'DNotification'
    end
    ## Config
    profile.subspec 'Config' do |config|
      config.source_files = "Code/DProfile/Profile/Config/*.{swift}"
    end
    # Style
    profile.subspec 'Style' do |style|
      style.source_files = "Code/DProfile/Profile/Style/*.{swift}"
    end
    # Manager
    profile.subspec 'Manager' do |manager|
      manager.source_files = "Code/DProfile/Profile/Manager/*.{swift}"
      manager.dependency 'DProfile/Profile/Config'
    end
    ## View
    profile.subspec 'View' do |view|
      view.source_files = "Code/DProfile/Profile/View/*.{swift}"
      view.dependency 'DProfile/Profile/Style'
      view.dependency 'DProfile/Profile/Bean'
      view.dependency 'DProfile/Profile/Manager'
      view.dependency 'WLBaseTableView/BTVC'
      view.dependency 'WLBaseTableView/BTV'
      view.dependency 'WLToolsKit/Color'
      view.dependency 'WLToolsKit/Then'
      view.dependency 'WLToolsKit/String'
      view.dependency 'WLToolsKit/Image'
      view.dependency 'Kingfisher'
      view.dependency 'SnapKit'
      view.dependency 'RxCocoa'
      view.dependency 'DPrepare/Cache'
    end
    ## VM
    profile.subspec 'VM' do |vm|
      vm.source_files = "Code/DProfile/Profile/VM/*.{swift}"
      vm.dependency 'DProfile/Profile/Bean'
      vm.dependency 'DPrepare/Req'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLBaseResult'
      vm.dependency 'RxCocoa'
    end
    ## Base
    profile.subspec 'Base' do |base|
      base.source_files = "Code/DProfile/Profile/Base/*.{swift}"
      base.dependency 'DProfile/Profile/VM'
      base.dependency 'DProfile/Profile/View'
      base.dependency 'DProfile/Profile/Config'
      base.dependency 'DPrepare/Base'
      base.dependency 'RxDataSources'
      base.dependency 'WLBaseTableView/SM'
      base.dependency 'WLToolsKit/DeviceInfo'
      base.dependency 'WLToolsKit/OpenUrl'
      base.dependency 'DLogin/Login/TokenInvalid'
      base.dependency 'DLogin/Login/CheckLogin'
    end
    # VC
    profile.subspec 'VC' do |vc|
      vc.source_files = "Code/DProfile/Profile/VC/*.{swift}"
      vc.dependency 'DProfile/Profile/Base'
      vc.dependency 'WLToolsKit/Common'
    end
    # Create
    profile.subspec 'Create' do |create|
      create.source_files = "Code/DProfile/Profile/Create/*.{swift}"
      create.dependency 'DProfile/Profile/VC'
    end
  end
  
  # About
  spec.subspec 'About' do |about|
    # Config
    about.subspec 'Config' do |config|
      config.source_files = "Code/DProfile/About/Config/*.{swift}"
    end
    # Bean
    about.subspec 'Bean' do |bean|
      bean.source_files = "Code/DProfile/About/Bean/*.{swift}"
      bean.dependency 'WLToolsKit/String'
    end
    # View
    about.subspec 'View' do |view|
      view.source_files = "Code/DProfile/About/View/*.{swift}"
      view.dependency 'DProfile/About/Bean'
      view.dependency 'DProfile/About/Config'
      view.dependency 'WLBaseTableView/BTV'
      view.dependency 'WLBaseTableView/BTVC'
      view.dependency 'SnapKit'
    end
    # VM
    about.subspec 'VM' do |vm|
      vm.source_files = "Code/DProfile/About/VM/*.{swift}"
      vm.dependency 'DProfile/About/Bean'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxCocoa'
      vm.dependency 'RxSwift'
    end
    # VC
    about.subspec 'VC' do |vc|
      vc.source_files = "Code/DProfile/About/VC/*.{swift}"
      vc.dependency 'DProfile/About/VM'
      vc.dependency 'DProfile/About/View'
      vc.dependency 'DProfile/About/Config'
      vc.dependency 'WLBaseTableView/SM'
      vc.dependency 'DPrepare/Base'
      vc.dependency 'RxDataSources'
      vc.dependency 'WLToolsKit/Common'
    end
    # Create
    about.subspec 'Create' do |create|
      create.source_files = "Code/DProfile/About/Create/*.{swift}"
      create.dependency 'DProfile/About/VC'
    end
  end
  
  ## UserInfo
  spec.subspec 'UserInfo' do |userInfo|
    ## Bean
    userInfo.subspec 'Bean' do |bean|
      bean.source_files = "Code/DProfile/UserInfo/Bean/*.{swift}"
    end
    ## Config
    userInfo.subspec 'Config' do |config|
      config.source_files = "Code/DProfile/UserInfo/Config/*.{swift}"
    end
    ## View
    userInfo.subspec 'View' do |view|
      view.source_files = "Code/DProfile/UserInfo/View/*.{swift}"
      view.dependency 'DProfile/UserInfo/Bean'
      view.dependency 'DProfile/UserInfo/Config'
      view.dependency 'WLBaseTableView/BTVC'
      view.dependency 'WLBaseTableView/BTV'
      view.dependency 'WLToolsKit/Color'
      view.dependency 'WLToolsKit/Then'
      view.dependency 'WLToolsKit/String'
      view.dependency 'Kingfisher'
      view.dependency 'SnapKit'
    end
    ## VM
    userInfo.subspec 'VM' do |vm|
      vm.source_files = "Code/DProfile/UserInfo/VM/*.{swift}"
      vm.dependency 'DProfile/UserInfo/Bean'
      vm.dependency 'DPrepare/Req'
      vm.dependency 'DPrepare/Upload'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLBaseResult'
      vm.dependency 'RxCocoa'
      vm.dependency 'WLReqKit'
    end
    # VC
    userInfo.subspec 'VC' do |vc|
      vc.source_files = "Code/DProfile/UserInfo/VC/*.{swift}"
      vc.dependency 'DProfile/Signature/Create'
      vc.dependency 'DProfile/NickName/Create'
      vc.dependency 'DProfile/UserInfo/VM'
      vc.dependency 'DProfile/UserInfo/View'
      vc.dependency 'WLBaseTableView/SM'
      vc.dependency 'DPrepare/Base'
      vc.dependency 'DPrepare/ActionShow'
      vc.dependency 'DPrepare/PickerImpl'
      vc.dependency 'RxDataSources'
      vc.dependency 'WLComponentView/Picker/DatePicker'
    end
    # Create
    userInfo.subspec 'Create' do |create|
      create.source_files = "Code/DProfile/UserInfo/Create/*.{swift}"
      create.dependency 'DProfile/UserInfo/VC'
    end
  end
  #
  ## NickName
  spec.subspec 'NickName' do |nickName|
    # VM
    nickName.subspec 'VM' do |vm|
      vm.source_files = "Code/DProfile/NickName/VM/*.{swift}"
      vm.dependency 'DProfile/UserInfo/Bean'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxCocoa'
      vm.dependency 'DPrepare/Req'
      vm.dependency 'WLBaseResult'
    end
    ## Base
    nickName.subspec 'Base' do |base|
      base.source_files = "Code/DProfile/NickName/Base/*.{swift}"
      base.dependency 'DProfile/NickName/VM'
      base.dependency 'DProfile/UserInfo/Config'
      base.dependency 'DPrepare/Base'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'WLToolsKit/Then'
      base.dependency 'WLComponentView/TextFeild/NickName'
    end
    ## VC
    nickName.subspec 'VC' do |vc|
      vc.source_files = "Code/DProfile/NickName/VC/*.{swift}"
      vc.dependency 'DProfile/NickName/Base'
      vc.dependency 'WLToolsKit/Color'
      vc.dependency 'WLToolsKit/Common'
    end
    ## Create
    nickName.subspec 'Create' do |create|
      create.source_files = "Code/DProfile/NickName/Create/*.{swift}"
      create.dependency 'DProfile/NickName/VC'
    end
  end
  #
  ## Signature
  spec.subspec 'Signature' do |signature|
    # VM
    signature.subspec 'VM' do |vm|
      vm.source_files = "Code/DProfile/Signature/VM/*.{swift}"
      vm.dependency 'DProfile/UserInfo/Bean'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxCocoa'
      vm.dependency 'DPrepare/Req'
      vm.dependency 'WLBaseResult'
      vm.dependency 'WLToolsKit/String'
    end
    ## Base
    signature.subspec 'Base' do |base|
      base.source_files = "Code/DProfile/Signature/Base/*.{swift}"
      base.dependency 'DProfile/Signature/VM'
      base.dependency 'DProfile/UserInfo/Config'
      base.dependency 'DPrepare/Base'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'WLToolsKit/Then'
    end
    ## VC
    signature.subspec 'VC' do |vc|
      vc.source_files = "Code/DProfile/Signature/VC/*.{swift}"
      vc.dependency 'DProfile/Signature/Base'
      vc.dependency 'WLToolsKit/Color'
      vc.dependency 'WLToolsKit/Common'
    end
    ## Create
    signature.subspec 'Create' do |create|
      create.source_files = "Code/DProfile/Signature/Create/*.{swift}"
      create.dependency 'DProfile/Signature/VC'
    end
  end
  
end
