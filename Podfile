source 'https://github.com/CocoaPods/Specs.git'
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'CleverFuze' do

  use_frameworks!

  # Pods for CleverFuze
  pod 'IQKeyboardManagerSwift', '~> 6.5'
  pod 'PieCharts'
  pod 'Alamofire'
  pod 'Kingfisher'
  
end
post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
               end
          end
   end
end
