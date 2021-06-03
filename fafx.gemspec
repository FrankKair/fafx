lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fafx/version'

Gem::Specification.new do |spec|
  spec.name          = 'fafx'
  spec.version       = Fafx::VERSION
  spec.authors       = ['Frank Kair']
  spec.email         = ['frankkair@gmail.com']

  spec.summary       = 'Exchange Rates from the European Central Bank'
  spec.description   = 'Lib and CLI to get exchange rates from the European Central Bank'
  spec.homepage      = 'https://github.com/frankkair/fafx'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = ['fafx']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.2.19'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_runtime_dependency 'nokogiri', '~> 1.8', '>= 1.8.2'
end
