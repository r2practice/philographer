begin
  require 'pry'
rescue LoadError
  puts "Couldn't load pry, running in CI?"
end
