source 'https://github.com/CocoaPods/Specs'

platform :ios, '10.0'
use_frameworks!
inhibit_all_warnings!

def shared_pods
  pod 'Sourcery', '~> 0.10'
end

target 'Pokedex' do
  shared_pods
  pod 'Kingfisher', '~> 4.0'
  pod 'R.swift', '~> 4.0'

  target 'Tests' do
    inherit! :search_paths
    pod 'Fakery', '~> 3.3'
  end
end

target 'Domain' do
  shared_pods
end

target 'GraphQlPlatform' do
  shared_pods
  target 'GraphQlPlatformTests' do
    inherit! :search_paths
    pod 'Fakery', '~> 3.3'
  end
end

post_install do |installer|  
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      swiftVersion = ['Fakery'].any? { |s| target.name.include? s } ? '4.1' : '3.2'
      config.build_settings['SWIFT_VERSION'] = swiftVersion
      config.build_settings['ALWAYS_SEARCH_USER_PATHS'] = 'NO'
      if config.name == 'Debug'
          config.build_settings['OTHER_SWIFT_FLAGS'] = ['$(inherited)', '-Onone']
          config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
      end
    end
  end
end

