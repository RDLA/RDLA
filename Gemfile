source 'http://rubygems.org'

gem 'rails', '3.1.1'
gem 'rack', '1.3.3'
gem 'jquery-rails'
gem 'pg'

gem 'devise'

gem 'heroku'
# Gems used only for assets and not required
# in production environments by default.

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :developpement, :test do
	gem 'sqlite3'
end
group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

group :production do
   gem 'errorapp_notifier'
end
