# Uncomment this line to define a global platform for your project
platform :ios, "13.0"
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
  end
end

