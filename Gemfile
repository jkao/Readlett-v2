source "https://rubygems.org"

# Core stuff
gem "rails", "3.2.1"
gem "sqlite3"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem "sass-rails",   "~> 3.2.3"
  gem "coffee-rails", "~> 3.2.1"
  gem "haml", "~> 3.1.4"
  gem "uglifier", ">= 1.0.3"
  gem "twitter-bootstrap-rails"
  gem "font-awesome-rails"
end

group :development, :test do
  # Helps populate data
  gem "faker"
  gem "factory_girl_rails", "~> 2.0"

  # Make test output nicer
  gem "redgreen"
  gem "test-unit", "1.2.3"
end

group :development do
end

group :test do
  # Mocking Library
  gem "mocha"

  # Thoughtbot Shoulda
  gem "shoulda"
end

# Authentication
gem "omniauth"
gem "omniauth-facebook"
gem "omniauth-google-oauth2"
gem "omniauth-identity"

# API-Related Gems
gem "acts_as_api"
gem "will_paginate"

# Front-end
gem "jquery-rails"

# UUID Generation
gem "uuid", "~> 2.3.5"

# ActiveRecord models can be 'symbolized'
gem "symbolize", :require => "symbolize/active_record"

# Web-scraping help
gem "pismo"
