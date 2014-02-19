# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cinch/plugins/eventcountdown/version'

Gem::Specification.new do |gem|
  gem.name          = 'cinch-eventcountdown'
  gem.version       = Cinch::Plugins::EventCountdown::VERSION
  gem.authors       = ['Brian Haberer']
  gem.email         = ['bhaberer@gmail.com']
  gem.description   = %q{Cinch Plugin to allow configurable event timers}
  gem.summary       = %q{Cinch Plugin for event timers}
  gem.homepage      = 'https://github.com/bhaberer/cinch-eventcountdown'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
  gem.license       = 'MIT'

  gem.add_development_dependency  'rake'
  gem.add_development_dependency  'rspec'
  gem.add_development_dependency  'coveralls'
  gem.add_development_dependency  'cinch-test'

  gem.add_dependency              'cinch',           '~> 2.0.12'
  gem.add_dependency              'time-lord',       '~> 1.0.1'
end
