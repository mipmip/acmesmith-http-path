# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'acmesmith/http-path/version'

Gem::Specification.new do |spec|
  spec.name          = "acmesmith-http-path"
  spec.version       = AcmesmithHttpPath::VERSION
  spec.authors       = ["Pim Snel"]
  spec.email         = ["pim@lingewoud.nl"]

  spec.summary       = %q{AcmeSmith ChallengeResponders plugin for validating by http-01}
  spec.description   = %q{AcmeSmith ChallengeResponders plugin for validating with letsencrypt by http-01 on a local machine}
  spec.homepage      = "https://github.com/mipmip/acmesmith-http-path"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "acmesmith"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
