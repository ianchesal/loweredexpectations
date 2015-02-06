# Encoding: utf-8
# Copyright 2015 Ian Chesal
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

Gem::Specification.new do |spec|
  spec.name          = "lowered-expectations"
  spec.version       = "1.0.0"
  # For deploying alpha versions via Travis CI
  spec.version       = "#{spec.version}-alpha-#{ENV['TRAVIS_BUILD_NUMBER']}" if ENV['TRAVIS']
  spec.authors       = ["Ian Chesal"]
  spec.email         = ["ian.chesal@gmail.com"]
  spec.summary       = 'A library for testing versions of command line tools.'
  spec.description   = <<-END
Test your environment for expected versions of command line tools using
gem-like expectation syntax.
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
end
