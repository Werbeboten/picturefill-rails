# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'picturefill/version'

Gem::Specification.new do |gem|
  gem.name          = "picturefill"
  gem.version       = Picturefill::VERSION
  gem.authors       = ["Patrick Helm"]
  gem.email         = ["deradon87@gmail.com"]
  gem.description   = %q{Rails-Wrapper for picturefill.js}
  gem.summary       = %q{Wraps the javascript lib picturefill, to work with the rails asset-pipeline }
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec-rails"
  gem.add_development_dependency "rails"
  gem.add_development_dependency "sqlite3"
end
