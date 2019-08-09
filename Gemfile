# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.3"

gem "rails", "~> 6.0.0.rc2"

gem "aws-sdk-sns", "~> 1"
gem "bootsnap", ">= 1.4.2", require: false
gem "fast_jsonapi", "~> 1.5"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.11"
gem "rest-client", "~> 2.0"

group :development, :test do
  gem "factory_bot_rails", "~> 5.0"
  gem "pry-byebug"
  gem "rspec-rails", "~> 3.8"
  gem "rspec_api_documentation", "~> 6.0"
end

group :development do
  gem "brakeman"
  gem "bundler-audit"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "rubycritic", require: false
  gem "spring"
  gem "spring-commands-rspec"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "webmock", "~> 3.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
