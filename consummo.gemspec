# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'consummo/version'

Gem::Specification.new do |spec|
  spec.name          = "consummo"
  spec.version       = Consummo::VERSION
  spec.authors       = ["Clayton Lengel-Zigich"]
  spec.email         = ["clayton@claytonlz.com"]

  spec.summary       = %q{An engine for producing, consuming and enriching items from RSS Feeds.}
  spec.description   = %q{Consummo is a small ruby library that provides item producers, consumers and enrichers to take items from RSS feeds and turn them into persistable feed items. Consummo was extracted from https://consummo.io where it was used to find and process items in a new curation workflow.}
  spec.homepage      = "https://github.com/clayton/consummo"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "feedjira", "~> 2.0"
  spec.add_runtime_dependency "activesupport", "5.0.0.rc2"
  spec.add_runtime_dependency "odyssey", "~> 0.2"
  spec.add_runtime_dependency "httparty", "~> 0.13"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "vcr", "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.9"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 0.5"
end
