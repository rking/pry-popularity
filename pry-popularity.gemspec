# encoding: utf-8

terse_revision = `git rev-parse HEAD`[0..6]

Gem::Specification.new do |gem|
  gem.name = 'pry-popularity'
  gem.homepage = 'http://github.com/rking/pry-popularity'
  gem.summary = gem.description = 'Sort pry input history by frequency of use (git revision %s)' % terse_revision
  gem.version = '0.0.2'
  gem.license = 'CC0'
  gem.email = 'pry-popularity@sharpsaw.org'
  gem.authors = %w(rondale-sc ☈king)

  gem.files = ['lib/pry-popularity.rb']
end
