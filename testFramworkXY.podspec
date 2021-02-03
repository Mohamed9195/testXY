
Pod::Spec.new do |spec|

  spec.name         = "testFramworkXY"
  spec.version      = "1.0.6"
  spec.summary      = "A short description of testFramworkXY."
  spec.description  = "using push protocol to get any update in permissions when calling framework object one time, and can use Push RXPermission View to show all permission."
  spec.homepage     = "https://github.com/Mohamed9195/testXY"
  spec.license      = "MIT"
  spec.author       = { "Mohamed Hashem" => "mohamedabdalwahab588@gmail.com" }
  spec.source      = { :git => "https://github.com/Mohamed9195/testXY.git", :tag => "#{spec.version}" }
  spec.platform     = :ios, "12.0"
  spec.ios.deployment_target = "12.0"
  spec.source_files  = 'testFramworkXY'
  spec.source_files =  'testFramworkXY/**/*.swift'
  spec.exclude_files = "Classes/Exclude"
  spec.resources = 'Resources/Info.plist'
  spec.resources = "CTYCrashReporter/Assets/*"

spec.subspec 'App' do |app|
app.source_files = 'testFramworkXY/**/*.swift'
end

  spec.swift_version = "4.2"
  spec.dependency 'RxSwift'
  spec.dependency 'RxCocoa'
  
end
