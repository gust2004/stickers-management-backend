# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'active_model_serializers', '~> 0.8.3'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'data_migrate', '~> 6.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3'
gem 'rails', '~> 6.0.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rubocop'
  gem 'rubocop-checkstyle_formatter', require: false
end

group :test do
  gem 'factory_bot_rails', require: false
  gem 'faker', '~> 2.3'
  gem 'rspec-rails'
  gem 'rubycritic', require: false
  gem 'simplecov'
  gem 'simplecov-cobertura'
  gem 'simplecov-rcov'
  gem 'sqlite3'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
