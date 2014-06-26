# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hpa/version'

Gem::Specification.new do |spec|
  spec.name          = "hpa-ruby"
  spec.version       = Hpa::VERSION
  spec.authors       = ["Zoran Žabčić"]
  spec.email         = ["zoran@effectiva.hr"]
  spec.summary       = %q{HTML PDF API wrapper}
  spec.description   = %q{HTML PDF API is a service that allows you to convert HTML to PDF using standard technologies (HTML, CSS and JavaScript).}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
