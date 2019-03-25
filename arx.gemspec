lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'arx/version'

Gem::Specification.new do |spec|
  spec.name          = 'arx'
  spec.version       = Arx::VERSION
  spec.authors       = ['Edwin Onuonga']
  spec.email         = ['edwinonuonga@gmail.com']
  spec.homepage      = 'https://github.com/eonu/arx'

  spec.summary       = %q{A Ruby interface for querying academic papers on the arXiv search API.}
  spec.license       = 'MIT'
  spec.require_paths = ['lib']
  spec.files         = Dir.glob('lib/**/*', File::FNM_DOTMATCH) + %w[
    Gemfile LICENSE CHANGELOG.md README.md Rakefile arx.gemspec
  ]

  spec.required_ruby_version = '~> 2.5'

  spec.add_runtime_dependency 'nokogiri', '~> 1.10'
  spec.add_runtime_dependency 'nokogiri-happymapper', '~> 0.8'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.7'

  spec.metadata = {
    'source_code_uri' => spec.homepage,
    'documentation_uri' => 'https://www.rubydoc.info/gems/arx/toplevel'
  }
end