# -*- encoding: utf-8 -*-
lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'vcr'
require 'aruba/cucumber'
require 'minitest/spec'
require 'pry'

World(Minitest::Assertions)
MiniTest::Spec.new(nil)

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
end
