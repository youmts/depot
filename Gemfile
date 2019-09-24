source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# .ruby-version に書いているのでGemfileに記述しなくてもよい？
# .ruby-versionはrbenv local 2.6.3 としたときに生成されるファイル（要確認）
# 2.6.3 の部分がずれるとbundle installでエラーになる。
ruby '2.6.3'

# 不要なコメントは削除してスッキリさせたい
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

gem 'bootstrap'

gem 'haml-rails'
gem 'simple_form'

gem 'carrierwave', '~> 1'

# minimagick のほうがメンテがされていてよさそう
gem 'rmagick'

gem 'font-awesome-sass' # for cool icons
gem 'enumerize' # for enumerated attributes

gem 'devise'
gem 'activeadmin'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# bootstrapと一緒にはいるかも？↓必要
gem 'jquery-rails' # for pay.jp client side code and bootstrap
gem 'payjp' # for credit-card payment

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'dotenv-rails' # for environment variables on development and test
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener'
end

group :test do
  gem 'capybara' # for system test
  gem 'selenium-webdriver' # for use selenium driver
  gem 'webdrivers' # for selenium_chrome_headless
  gem 'webmock' # for system test that use external web api
  gem 'vcr' # for cache web api request for webmock
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
