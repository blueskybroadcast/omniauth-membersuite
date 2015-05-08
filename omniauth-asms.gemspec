# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-asms/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-asms"
  spec.version       = Omniauth::Asms::VERSION
  spec.authors       = ["Viktor Leonets"]
  spec.email         = ["4405511@gmail.com"]
  spec.summary       = %q{ASMS SSO}
  spec.description   = %q{ASMS SSO}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'builder'
  spec.add_runtime_dependency 'nokogiri'
  spec.add_runtime_dependency 'omniauth', '~> 1.0'
  spec.add_runtime_dependency 'omniauth-oauth2', '~> 1.0'
  spec.add_runtime_dependency 'rest-client'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
