# frozen_string_literal: true

require_relative 'lib/allymailer/version'

Gem::Specification.new do |spec|
  spec.name = 'allymailer-ruby-sdk'
  spec.version = AllyMailer::VERSION
  spec.summary = 'AllyMailer Web API client library for Ruby'
  spec.authors = ['AllyMailer']
  spec.license = 'MIT'
  spec.homepage = 'https://github.com/allymailer/allymailer-ruby-sdk'
  spec.metadata = { 'documentation_uri' => 'https://docs.allymailer.com.ua/ua/web-api-ref' }
  spec.required_ruby_version = '>= 2.7'
  spec.files = Dir['lib/**/*.rb', 'docs/*.md', 'README.md', 'AGENTS.md', 'LICENSE']
  spec.require_paths = ['lib']
end
