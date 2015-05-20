# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-membersuite/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-membersuite"
  spec.version       = Omniauth::Membersuite::VERSION
  spec.authors       = ["Viktor Leonets", "Timm Liu"]
  spec.email         = ["4405511@gmail.com", "tliu@blueskybroadcast.com"]
  spec.summary       = %q{Membersuite SSO}
  spec.description   = %q{Membersuite SSO}
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
