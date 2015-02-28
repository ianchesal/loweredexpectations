# Encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lowered/expectations'

Gem::Specification.new do |spec|
  spec.name          = "lowered-expectations"
  spec.version       = LoweredExpectations::VERSION
  # For deploying alpha versions via Travis CI
  spec.version       = "#{spec.version}-alpha-#{ENV['TRAVIS_BUILD_NUMBER']}" if ENV['TRAVIS']
  spec.authors       = ["Ian Chesal"]
  spec.email         = ["ian.chesal@gmail.com"]
  spec.summary       = 'A library for testing versions of command line tools.'
  spec.description   = <<-END
A Ruby gem that lets you test for the presence of command line tools and ensure
that you have a version of the tool that you know how to work with.

It uses the gem system's version matching semantics so you can do things like
enforce a major version but allow any minor version above a certain value for a
tool. If you use Gemfile's the syntax should look pretty familiary to you.
END
  spec.homepage      = "https://github.com/ianchesal/loweredexpectations"
  spec.license       = "Apache 2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.4"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-mocks", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 0.24"
  spec.add_development_dependency "rubygems-tasks", "~> 0.2"
end
