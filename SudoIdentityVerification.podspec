Pod::Spec.new do |spec|
  spec.name                  = 'SudoIdentityVerification'
  spec.version               = '15.4.1'
  spec.author                = { 'Sudo Platform Engineering' => 'sudoplatform-engineering@anonyome.com' }
  spec.homepage              = 'https://sudoplatform.com/'
  spec.summary               = 'Secure ID Verification SDK for the Sudo Platform by Anonyome Labs.'
  spec.license               = { :type => 'Apache License, Version 2.0',  :file => 'LICENSE' }
  spec.source                = { :git => 'https://github.com/sudoplatform/sudo-secure-id-verification-ios.git', :tag => "v#{spec.version}" }
  spec.source_files          = 'SudoIdentityVerification/**/*.swift'
  spec.ios.deployment_target = '15.0'
  spec.requires_arc          = true
  spec.swift_version         = '5.0'

  spec.dependency 'SudoLogging', '~> 1.0'
  spec.dependency 'SudoUser', '~> 15.0'
  spec.dependency 'SudoApiClient', '~> 10.0'
  spec.dependency 'SudoConfigManager', '~> 3.0'
  spec.dependency 'AWSAppSync', '~> 3.6.1'
  spec.dependency 'AWSCore', '~> 2.27.15'
end
