require 'minitest/spec'
require 'turn/autorun'
require 'vcr'

require 'philographer'

Turn.config do |config|
  config.format = :dot
end


VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
end
