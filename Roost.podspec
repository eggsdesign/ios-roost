Pod::Spec.new do |spec|
  spec.name         = 'Roost'
  spec.version      = '0.0.1'
  spec.summary      = 'Swift utility library for Eggs design'
  spec.homepage     = 'https://github.com/eggsdesign/ios-roost'
  spec.author       = 'Eggs Design'
  spec.source       = { :git => 'git@github.com:eggsdesign/ios-roost.git', :tag => 'v0.0.1' }
  spec.source_files = 'Lib/Core/**/*.{swift}'
  spec.requires_arc = true

  spec.subspec 'GUI' do |gui|
    gui.source_files = 'Lib/GUI/**/*.{swift}'
  end
end