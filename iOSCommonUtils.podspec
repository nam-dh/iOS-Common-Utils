Pod::Spec.new do |s|

  s.name         = "iOSCommonUtils"
  s.version      = "0.6.0"
  s.summary      = "Common Utilities for iOS"
  s.description  = "Common Utilities for iOS App written in Swift"
  s.homepage     = "https://github.com/nam-dh/iOS-Common-Utils"
  s.license      = "MIT"
  s.author       = { "Nam Doan" => "namdoanhoai89@gmail.com" }

  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/nam-dh/iOS-Common-Utils.git", :tag => s.version }
  s.source_files = "iOSCommonUtils/*.swift", "iOSCommonUtils/**/*.swift"
  s.requires_arc = true

end
