# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'philographer/version'

Gem::Specification.new do |gem|
  gem.name          = "philographer"
  gem.version       = Philographer::VERSION
  gem.authors       = ["Tyler Pickett"]
  gem.email         = ["t.pickett66@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency("httpclient", "~> 2.3.3")
  gem.add_dependency("activesupport", "~> 3.0")
  gem.add_development_dependency("json", "~> 1.7.7")

  gem.add_development_dependency("cucumber", "~> 1.3.1")
  gem.add_development_dependency("minitest", "~> 4.7.4")
  gem.add_development_dependency("turn", "~> 0.9.6")

  gem.add_development_dependency("vcr", "~> 2.4.0")
  gem.add_development_dependency("webmock", "~> 1.11.0")
end
