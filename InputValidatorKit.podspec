Pod::Spec.new do |s|
  s.name             = 'InputValidatorKit'
  s.version          = '1.0.0'
  s.summary          = 'Simple and powerful input validation for iOS.'

  s.description      = <<-DESC
    ValidatorKit provides clean, chainable validation for common inputs like
    email, phone, password, username, URL, and credit card numbers.
    Includes SwiftUI components for live validation feedback and password strength meter.
  DESC

  s.homepage         = 'https://github.com/ErsanQ/InputValidatorKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ErsanQ' => 'ersan5599@gmail.com' }
  s.source           = { :git => 'https://github.com/ErsanQ/InputValidatorKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.swift_version    = '5.0'

  s.source_files     = 'InputValidatorKit/Classes/**/*'
end
