# -*- encoding: utf-8 -*-
lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'aruba/cucumber'
require 'minitest/spec'
require 'pry'

require 'philographer'

World(Minitest::Assertions)
MiniTest::Spec.new(nil)
