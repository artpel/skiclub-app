platform :ios, '10.0'

target 'Ski Club' do

  use_frameworks!

  # Pods for Ski Club

    pod 'Firebase/Core'
    pod 'Firebase/Database'

    # OneSignal
    pod 'OneSignal', '>= 2.6.2', '< 3.0'

    # Divers
    
    pod 'DeckTransition'
    pod 'Alamofire'
    pod 'SwiftyJSON'
    pod 'NVActivityIndicatorView'
    pod 'Haptica'
    pod 'RevealingSplashView'
    pod 'ImageSlideshow', '~> 1.6'
    pod 'ImageSlideshow/Kingfisher'
    pod 'ChameleonFramework'
    pod 'LGButton'
    pod 'SwiftDate'
    pod 'Spring'
    pod 'CFAlertViewController'
    pod 'ReachabilitySwift'
    
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10'
            end
        end
    end
    
end

target 'OneSignalNotificationServiceExtension' do

    use_frameworks!
    pod 'OneSignal', '>= 2.6.2', '< 3.0'

end
