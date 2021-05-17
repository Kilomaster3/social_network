# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.5'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

gem 'aws-sdk-s3', require: false
gem 'devise', github: 'heartcombo/devise', branch: 'ca-omniauth-2'
gem 'gravatar_image_tag'

gem 'carrierwave', '~> 2.0'
gem 'faker'
gem 'haml'
gem 'mini_magick'
gem 'simple_form'

gem 'cable_ready'
gem 'redis'

gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'

gem 'font_awesome5_rails'
gem 'gon'
gem 'haml-rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'public_activity'

gem 'bootstrap-typeahead-rails'
gem 'bootstrap-will_paginate'
gem 'elasticsearch-model'
gem 'elasticsearch-rails'
gem 'searchkick'
gem 'whenever'
gem 'will_paginate'

gem 'sidekiq'
gem 'sidekiq-cron'

gem 'devise_masquerade'
gem 'pundit'

gem 'rails-i18n'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'pry'
  gem 'rubocop-rails'
  gem 'rubocop-rspec', require: false
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '~> 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Fix N+1 problem
  gem 'bullet'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
