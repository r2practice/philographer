require 'minitest/spec'
require 'turn/autorun'

Dir.glob(File.expand_path('./gem_configs', __FILE__) + "/**").each do |config|
  require config
end

require 'philographer'

Turn.config do |config|
  config.format = :dot
end

