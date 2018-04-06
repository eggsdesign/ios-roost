Pod::Spec.new do |spec|
  spec.name         = 'Roost'
  spec.platform = :ios
  spec.version      = '0.0.2'
  spec.summary      = 'Swift utility library for Eggs design'
  spec.homepage     = 'https://github.com/eggsdesign/ios-roost'
  spec.author       = 'Eggs Design'
  spec.source       = { :git => 'git@github.com:eggsdesign/ios-roost.git', :tag => 'v0.0.2' }
  spec.requires_arc = true
  spec.ios.deployment_target  = '9.0'

  spec.subspec 'Core' do |gui|
    gui.source_files = 'Lib/Core/**/*.{swift}'
  end

  spec.subspec 'GUI' do |gui|
    gui.dependency 'Roost/Core'
    gui.source_files = 'Lib/GUI/**/*.{swift}'
  end
end