source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'
gem 'rails', '~> 5.1.0'

# Data stores
gem 'pg', '~> 0.18'
gem 'redis', '~> 3.0'

# App servers
gem 'puma', '~> 3.7'

# Core
gem 'bcrypt', '~> 3.1.7'

# View
gem 'bootstrap-sass', '3.3.6'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails', '4.1.1'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'annotate'
  gem 'brakeman'
  gem 'reek'
  gem 'rubocop'

  gem 'letter_opener'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'pry-byebug'
  gem 'pry-rails'

  gem 'fuubar'
  gem 'rspec-rails', '~> 3.5'

  gem 'factory_girl_rails'
  gem 'faker'
end

group :test do
  # Coverage
  gem 'coveralls', require: false

  # Testing frameworks
  gem 'capybara'
  gem 'shoulda-matchers', '~> 3.1'
end
