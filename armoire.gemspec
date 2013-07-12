# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'armoire/version'

Gem::Specification.new do |spec|
  spec.name          = "armoire"
  spec.version       = Armoire::VERSION
  spec.authors       = ["Michael Smith"]
  spec.email         = ["mike@spokefire.co.uk"]
  spec.description   = %q{A simple configuration tool}
  spec.summary       = %q{A simple configuration tool}
  spec.homepage      = "https://github.com/mikespokefire/armoire"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.13"
  spec.add_development_dependency "simplecov", "~> 0.7"
end
