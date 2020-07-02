# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'i18n_def_scanner/version'

Gem::Specification.new do |spec|
  spec.name          = 'i18n_def_scanner'
  spec.version       = I18nDefScanner::VERSION
  spec.authors       = ['GeorgeGorbanev']
  spec.email         = ['georgegorbanev@gmail.com']

  spec.summary       = 'CLI tool to find where i18n translations defined.'
  spec.description   = 'CLI tool accepts yaml key as argument and returns file path with' \
                       'line number where translation defined.'
  spec.homepage      = 'https://github.com/GeorgeGorbanev/i18n_def_scanner'
  spec.license       = 'MIT'

  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = ['i18n_def_scanner']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'pry-byebug', '~> 3.9.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.86.0'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.40.0'
end
