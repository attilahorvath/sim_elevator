# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sim_elevator/version'

Gem::Specification.new do |spec|
  spec.name          = 'SimElevator'
  spec.version       = SimElevator::VERSION
  spec.authors       = ['Attila Horváth']
  spec.email         = ['hun.ati500@gmail.com']

  spec.summary       = 'Simple simulation of a common elevator.'
  spec.description   = 'Simulates the behavior of a common elevator. Supports floors with unique codes and up/down buttons for calling the elevator from each floor.'
  spec.homepage      = 'https://github.com/attilahorvath/sim_elevator'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest'

  spec.add_dependency 'pry'
end
