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

require 'rubocop/rake_task'
require 'rspec/core/rake_task'
require 'rake/clean'

RuboCop::RakeTask.new(:lint)

task :default => [:lint, 'test:spec']

task :build => [:lint, 'test:spec', 'test:integration'] do
  sh "gem build --verbose lowered-expectations.gemspec"
end

namespace :test do
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = Dir['spec/**/*_spec.rb'].reject{ |f| f['/integration'] }
  end

  RSpec::Core::RakeTask.new(:integration) do |t|
    t.pattern = "spec/integration/**/*_spec.rb"
  end
end

CLEAN.add FileList['lowered-expectations-*.gem']
