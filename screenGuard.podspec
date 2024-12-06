
Pod::Spec.new do |s|
  s.name             = 'ScreenGuard'
  s.version          = '1.0.0'
  s.summary          = 'A lightweight iOS package to detect screenshot events in your app.'
  s.description      = 'ScreenGuard helps developers detect screenshot events in their iOS applications. It provides easy-to-use methods to register screenshot notifications and prevent screenshots from being captured.' 
  s.homepage         = 'https://github.com/LoviceSunuwar/screenGuard'
  s.license     = { :type => 'Apache 2.0', :file => 'LICENSE' }

  s.author           = { 'Lovice Sunuwar' => 'your.email@example.com' }
  s.source           = { :git => 'https://github.com/LoviceSunuwar/screenGuard.git', :tag => s.version.to_s }
  
  s.platform         = :ios, '13.0'
  s.source_files     = 'Sources/**/*.{swift}'
 

  # Swift version
  s.swift_version = '5.7'
end
