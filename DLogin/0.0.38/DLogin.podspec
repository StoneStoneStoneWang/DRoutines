Pod::Spec.new do |spec|
  
  spec.name         = "DLogin"
  spec.version      = "0.0.38"
  spec.summary      = "A Lib For login."
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
  
  ## Protocol
  spec.subspec 'Protocol' do |protocol|
    ## VM
    protocol.subspec 'VM' do |vm|
      vm.source_files = "Code/DLogin/Protocol/VM/*.{swift}"
      vm.dependency 'DRoutinesKit'
      vm.dependency 'RxSwift'
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
    end
    ## Base
    protocol.subspec 'Base' do |base|
      base.source_files = "Code/DLogin/Protocol/Base/*.{swift}"
      base.dependency 'DPrepare/Base'
      base.dependency 'DLogin/Protocol/VM'
    end
    ## VC
    protocol.subspec 'VC' do |vc|
      vc.source_files = "Code/DLogin/Protocol/VC/*.{swift}"
      vc.dependency 'DLogin/Protocol/Base'
    end
    
    ## Create
    protocol.subspec 'Create' do |create|
      create.source_files = "Code/DLogin/Protocol/Create/*.{swift}"
      create.dependency 'DLogin/Protocol/VC'
      create.dependency 'DLogin/Login/Style'
      create.dependency 'WLBaseViewController/Navi'
      create.dependency 'WLToolsKit/Color'
    end
  end
  
  ##  Login
  spec.subspec 'Login' do |login|
    ## Style
    login.subspec 'Style' do |style|
      style.source_files = "Code/DLogin/Login/Style/*.{swift}"
    end
    
    ## Config
    login.subspec 'Config' do |config|
      config.source_files = "Code/DLogin/Login/Config/*.{swift}"
    end
    
    # VM
    login.subspec 'VM' do |vm|
      vm.source_files = "Code/DLogin/Login/VM/*.{swift}"
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxCocoa'
      vm.dependency 'DPrepare/Req'
      vm.dependency 'DPrepare/TextCheck'
    end
    
    ## Base
    login.subspec 'Base' do |base|
      base.source_files = "Code/DLogin/Login/Base/*.{swift}"
      base.dependency 'DLogin/Login/VM'
      base.dependency 'WLThirdUtil/JPush'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'DLogin/Reg/VM'
      base.dependency 'DLogin/Login/Style'
      base.dependency 'DLogin/Login/Config'
      base.dependency 'DPrepare/Button'
      base.dependency 'DPrepare/TextField'
      base.dependency 'WLComponentView/TextFeild/LeftImage'
      base.dependency 'WLComponentView/TextFeild/Password'
      base.dependency 'WLToolsKit/Common'
      base.dependency 'DNotification'
      base.dependency 'DPrepare/Base'
      
    end
    
    ## VC
    login.subspec 'VC' do |vc|
      vc.source_files = "Code/DLogin/Login/VC/*.{swift}"
      vc.dependency 'DLogin/Login/Base'
      vc.dependency 'SnapKit'
      vc.dependency 'WLComponentView/Draw'
    end
    
    ## Create
    login.subspec 'Create' do |create|
      create.source_files = "Code/DLogin/Login/Create/*.{swift}"
      create.dependency 'DLogin/Login/VC'
    end
    
    ## CheckLogin
    login.subspec 'CheckLogin' do |checkLogin|
      checkLogin.source_files = "Code/DLogin/Login/CheckLogin/*.{swift}"
      checkLogin.dependency 'DLogin/Login/Create'
      checkLogin.dependency 'WLBaseViewController/Navi/NaviController'
    end
    
    ## TokenInvalid
    login.subspec 'TokenInvalid' do |tokenInvalid|
      tokenInvalid.source_files = "Code/DLogin/Login/TokenInvalid/*.{swift}"
      tokenInvalid.dependency 'DLogin/Login/Create'
      tokenInvalid.dependency 'WLBaseViewController/Navi/NaviController'
    end
    
  end
  
  #  Pwd
  spec.subspec 'Pwd' do |pwd|
    ## VM
    pwd.subspec 'VM' do |vm|
      vm.source_files = "Code/DLogin/Pwd/VM/*.{swift}"
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'DPrepare/Req'
      vm.dependency 'RxCocoa'
      vm.dependency 'DPrepare/TextCheck'
    end
    ## Base
    pwd.subspec 'Base' do |base|
      base.source_files = "Code/DLogin/Pwd/Base/*.{swift}"
      base.dependency 'DLogin/Pwd/VM'
      base.dependency 'DLogin/Login/Style'
      base.dependency 'DLogin/Login/Config'
      base.dependency 'DPrepare/Button'
      base.dependency 'DPrepare/TextField'
      base.dependency 'DPrepare/Base'
      base.dependency 'WLComponentView/TextFeild/LeftImage'
      base.dependency 'WLComponentView/TextFeild/Vcode'
      base.dependency 'WLComponentView/TextFeild/Password'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'WLToolsKit/Common'
      base.dependency 'DNotification'
    end
    
    ## VC
    pwd.subspec 'VC' do |vc|
      
      vc.source_files = "Code/DLogin/Pwd/VC/*.{swift}"
      vc.dependency 'DLogin/Pwd/Base'
      vc.dependency 'SnapKit'
      vc.dependency 'WLToolsKit/Color'
      vc.dependency 'WLComponentView/Draw'
      
    end
    
    ## Create
    pwd.subspec 'Create' do |create|
      create.source_files = "Code/DLogin/Pwd/Create/*.{swift}"
      create.dependency 'DLogin/Pwd/VC'
    end
  end
  
  ##  Reg
  spec.subspec 'Reg' do |reg|
    ## VM
    reg.subspec 'VM' do |vm|
      vm.source_files = "Code/DLogin/Reg/VM/*.{swift}"
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxCocoa'
      vm.dependency 'DPrepare/Req'
      vm.dependency 'DPrepare/TextCheck'
    end
    ## Base
    reg.subspec 'Base' do |base|
      
      base.source_files = "Code/DLogin/Reg/Base/*.{swift}"
      base.dependency 'WLThirdUtil/JPush'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'DLogin/Reg/VM'
      base.dependency 'DLogin/Login/Style'
      base.dependency 'DLogin/Login/Config'
      base.dependency 'DPrepare/Button'
      base.dependency 'DPrepare/TextField'
      base.dependency 'WLComponentView/TextFeild/LeftImage'
      base.dependency 'WLComponentView/TextFeild/Vcode'
      base.dependency 'WLToolsKit/Common'
      base.dependency 'DNotification'
      base.dependency 'DPrepare/Base'
    end
    ## VC
    reg.subspec 'VC' do |vc|
      
      vc.source_files = "Code/DLogin/Reg/VC/*.{swift}"
      vc.dependency 'DLogin/Reg/Base'
      vc.dependency 'SnapKit'
      vc.dependency 'WLComponentView/Draw'
    end
    ## Create
    reg.subspec 'Create' do |create|
      create.source_files = "Code/DLogin/Reg/Create/*.{swift}"
      create.dependency 'DLogin/Reg/VC'
    end
  end
  
end

