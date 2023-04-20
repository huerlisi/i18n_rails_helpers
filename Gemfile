source 'https://rubygems.org'

# Declare your gem's dependencies in the gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

gem 'rails', '~> 6.0.0'

group :test, :development do
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'sqlite3'
end

group :tools, :test, :development do
  # Debugger
  gem 'pry-rails'

  # QA
  gem 'overcommit'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'
end
