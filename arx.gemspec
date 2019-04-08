lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'arx/version'

Gem::Specification.new do |spec|
  spec.name          = 'arx'
  spec.version       = Arx::VERSION
  spec.authors       = ['Edwin Onuonga']
  spec.email         = ['ed@mail.eonu.net']
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
  spec.add_development_dependency 'thor', '~> 0.19.4'
  spec.add_development_dependency 'rspec', '~> 3.7'
  spec.add_development_dependency 'coveralls', '0.8.22'

  spec.metadata = {
    'source_code_uri' => spec.homepage,
    'homepage_uri' => spec.homepage,
    'documentation_uri' => 'https://www.rubydoc.info/github/eonu/arx/master/toplevel',
    'bug_tracker_uri' => "#{spec.homepage}/issues",
    'changelog_uri' => "#{spec.homepage}/blob/master/CHANGELOG.md"
  }
end