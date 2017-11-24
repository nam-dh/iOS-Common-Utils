Pod::Spec.new do |s|

  s.name         = "CommonUtils"
  s.version      = "0.0.3"
  s.summary      = "Common Utilities for iOS"
  s.description  = "Common Utilities for iOS App written in Swift"
  s.homepage     = "https://github.com/namperry/iOS_Common_Utilities"
  s.license      = "MIT"
  s.author       = { "Nam Doan" => "namdoanhoai89@gmail.com" }

  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/namperry/iOS_Common_Utilities.git", :tag => s.version }
  s.source_files = "CommonUtils/*.swift", "CommonUtils/**/*.swift"
  s.requires_arc = true

end
