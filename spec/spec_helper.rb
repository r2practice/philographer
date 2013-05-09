require 'bundler'
Bundler.setup

require 'minitest/spec'
require 'minitest/mock'
require 'minitest/hell'
require 'turn/autorun'
require 'vcr'

require_relative 'helpers/credentials_helper'

require 'philographer'

Turn.config do |config|
  config.format = :dot
end


VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.default_cassette_options = { erb: true }
end

class Minitest::Spec
  include CredentialsHelper

  before do
    load_credentials
    Philographer.configure do |config|
      config.environment = 'demo'
    end
  end
end

