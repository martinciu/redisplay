# -*- encoding: utf-8 -*-
require File.expand_path('../lib/redisplay/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Marcin Ciunelis"]
  gem.email         = ["marcin.ciunelis@gmail.com"]
  gem.description   = %q{Simple Rack app for browsing Redis database}
  gem.summary       = %q{}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "redisplay"
  gem.require_paths = ["lib"]
  gem.version       = Redisplay::VERSION

  gem.add_dependency "sinatra"#, "~> 1.3.4"
  gem.add_dependency 'redis', '~> 2.2.2'
  gem.add_dependency 'redis-namespace', '>= 1.0.3'
  gem.add_dependency "json", ">= 1.5.3"

  gem.add_development_dependency "rake", "~> 0.9.2"
  gem.add_development_dependency "minitest", "~> 2.7.0"
  gem.add_development_dependency "rack-test", "~> 0.6"
  gem.add_development_dependency "turn", "~> 0.8.3"
  gem.add_development_dependency "mocha", "~> 0.10.0"
  gem.add_development_dependency 'timecop', '~> 0.3.5'

end
