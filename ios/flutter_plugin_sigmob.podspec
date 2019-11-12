#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_plugin_sigmob'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  s.frameworks = [
    'UIKit',
    'GLKit',
    'WebKit',
    'StoreKit',
    'Security',
    'CFNetwork',
    'CoreMedia',
    'MessageUI',
    'CoreVideo',
    'AdSupport',
    'CoreMotion',
    'QuartzCore',
    'Foundation',
    'MediaPlayer',
    'CoreGraphics',
    'AVFoundation',
    'CoreLocation',
    'AudioToolbox',
    'CoreTelephony',
    'SafariServices',
    'MobileCoreServices',
    'SystemConfiguration',
  ]
  s.libraries = [
    'z',
    'sqlite3',
    'resolv.9',
  ]

  s.vendored_frameworks = [
    'Classes/Frameworks/WindSDK.framework',
  ]
  s.resource = [
    'Classes/Frameworks/Sigmob.bundle',
  ]

  s.ios.deployment_target = '8.0'
end

