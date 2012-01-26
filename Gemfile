source 'http://rubygems.org'

gem 'rails'

gem 'jquery-rails'

#Use for admin
gem 'devise'
gem 'inherited_resources'

gem 'heroku'
# Gems used only for assets and not required
# in production environments by default.

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :production do
  gem 'pg'
end
group :development, :test do
  gem 'sqlite3'
end
group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

group :production do
   gem 'errorapp_notifier'
end
