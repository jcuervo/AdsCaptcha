# -*- encoding: utf-8 -*-
require File.expand_path('../lib/adscaptcha/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jimmy Cuervo"]
  gem.email         = ["richard.gonzales@gmail.com"]
  gem.description   = %q{Helpers for AdsCaptcha API}
  gem.summary       = %q{This plugin adds helpers for the AdsCaptcha API}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "adscaptcha"
  gem.require_paths = ["lib"]
  gem.version       = Adscaptcha::VERSION
end
