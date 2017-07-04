# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'currency_shushugah/version'

Gem::Specification.new do |spec|
  spec.name          = "currency_shushugah"
  spec.version       = CurrencyShushugah::VERSION
  spec.authors       = ["Yonatan Miller"]
  spec.email         = ["brombacher1@gmail.com"]

  spec.summary       = "Converts currencies and accepts conversion rates"
  spec.homepage      = "https://github.com/shushugah/currency_shushugah"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
