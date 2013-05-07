# -*- encoding: utf-8 -*-
lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Dir.glob(File.expand_path('../../spec/gem_configs', __FILE__) + "/**").each do |config|
  require config
end
