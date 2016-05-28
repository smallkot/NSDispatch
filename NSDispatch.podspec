
Pod::Spec.new do |s|
  s.name             = 'NSDispatch'
  s.version          = '1.0.0'
  s.summary          = 'An Objective-C wrapper for libdispatch, named using Cocoa API convention.'

  s.homepage         = 'https://github.com/roonieone/NSDispatch'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'roonieone' => 'malstrommark@gmail.com' }
  s.source           = { :git => 'https://github.com/roonieone/NSDispatch.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/markmalstrom'

  s.ios.deployment_target = '7.0'

  s.source_files = 'NSDispatch/Classes/**/*'
end
