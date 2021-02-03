
Pod::Spec.new do |spec|

  spec.name         = "testFramworkXY"
  spec.version      = "1.0.1"
  spec.summary      = "A short description of testFramworkXY."
  spec.homepage     = "https://github.com/Mohamed9195/testXY"
  spec.license      = "MIT"
  spec.author       = { "Mohamed Hashem" => "mohamedabdalwahab588@gmail.com" }
  #spec.source       = { :git => "https://github.com/Mohamed9195/testXY.git", :tag => "#{spec.version}" }
  spec.platform     = :ios, "12.0"
  spec.ios.deployment_target = "12.0"
  spec.source_files  = 'testFramworkXY'
  spec.source_files =  'testFramworkXY/**/*.swift'
  spec.exclude_files = "Classes/Exclude"

spec.subspec 'App' do |app|
app.source_files = 'testFramworkXY/**/*.swift'
end

  spec.swift_version = "4.2"
  spec.dependency 'RxSwift', '~> 5.1'
  spec.dependency "RxCocoa", "~> 5.1"
  
end
