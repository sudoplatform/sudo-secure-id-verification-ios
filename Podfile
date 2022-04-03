# Uncomment this line to define a global platform for your project
platform :ios, "14.0"
use_frameworks!

# Ignore all warnings from pods.
inhibit_all_warnings!

source 'https://github.com/CocoaPods/Specs.git'

target "SudoIdentityVerification" do
  podspec :name => 'SudoIdentityVerification'

  target "SudoIdentityVerificationTests" do
    podspec :name => 'SudoIdentityVerification'
  end

  target "SudoIdentityVerificationIntegrationTests" do
    podspec :name => 'SudoIdentityVerification'
    pod 'SudoKeyManager', '~> 1.0'
    pod 'SudoEntitlements', '~> 6.0'
    pod 'SudoEntitlementsAdmin', '~> 2.0'
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
   target.build_configurations.each do |config|
    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
   end
  end
 end