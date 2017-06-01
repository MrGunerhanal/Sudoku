#
# Be sure to run `pod lib lint TweenKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TweenKit'
  s.version          = '0.2.0'
  s.summary          = 'Animation library for iOS'

  s.description      = <<-DESC
TweenKit makes it easy to animate anything!
                       DESC

  s.homepage         = 'https://github.com/SteveBarnegren/TweenKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'steve.barnegren@gmail.com' => 'steve.barnegren@gmail.com' }
  s.source           = { :git => 'https://github.com/SteveBarnegren/TweenKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/SteveBarnegren'

  s.ios.deployment_target = '8.0'

  s.source_files = 'TweenKit/TweenKit/*.swift'
  s.frameworks = 'UIKit'

end
