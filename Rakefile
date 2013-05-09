require "bundler"
Bundler.setup

require "bundler/gem_tasks"
require 'rake/testtask'
require 'cucumber'
require 'cucumber/rake/task'

task :default => [:test, :cucumber]

Rake::TestTask.new do |t|
  t.libs << 'spec'
  t.test_files = Dir.glob('spec/**/*_spec.rb')
end

Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = "features --format progress --strict --tags ~@wip"
end
