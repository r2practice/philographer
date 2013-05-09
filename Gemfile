source 'https://rubygems.org'

# Specify your gem's dependencies in philographer.gemspec
gemspec

group :local_development do
  # We'll Travis-CI to not install these non-required gems
  gem "guard", "~> 1.8.0"
  gem "guard-minitest", "~> 0.5.0"

  gem 'rb-inotify', '~> 0.9.0', :require => false
  gem 'rb-fsevent', '~> 0.9.3', :require => false
  gem 'rb-fchange', '~> 0.0.6', :require => false

  gem 'pry-debugger', '~> 0.2.2'
end

group :test do
  gem 'rake', '~> 10.0'
end
