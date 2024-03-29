source 'https://rubygems.org'

gem 'rails', '3.2.15'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'

  gem 'jquery-ui-rails'
  gem 'jquery-fileupload-rails'
end

# Rich UI
gem 'jquery-rails'
gem 'bootstrap-sass', '~> 3.0.3.0'
gem 'twitter-bootstrap-markup-rails'
gem 'simple_form', '>= 2.1.0'
# gem 'client_side_validations',  :git => 'git://github.com/DavyJonesLocker/client_side_validations.git' # , '>= 3.2.1'
gem 'client_side_validations', '>= 3.2.1'
# gem 'client_side_validations-simple_form', :git => 'git://github.com/dockyard/client_side_validations-simple_form.git'
gem 'client_side_validations-simple_form', '>= 1.5.0'


# Authorisation and authentication
gem 'devise', '>= 2.1.2'
gem 'devise_invitable', '>= 1.0.3'
gem 'cancan', '>= 1.6.8'
gem 'rolify', '>= 3.2.0'

# History
gem 'paper_trail', '~> 2'
# RMagick image processing - depends on installed ImageMagick package http://cactuslab.com/imagemagick/
gem 'rmagick', :require => false
# CarrierWave file uploader
gem 'carrierwave'
# enumeration and default values
gem 'values_for', :path => 'vendor/values_for'
gem 'default_value_for'
# Menu helper
gem 'acts_as_list'
gem 'acts_as_ordered_tree'
# User friendly page URLs
gem 'friendly_id'
# Convert non Ascii characters
gem 'asciify', :git => 'git://github.com/levinalex/asciify.git'
gem 'iconv'  # asciify dependency
# Simple markdown
gem 'redcarpet'
# Integrate Google maps
#gem 'gmaps4rails', '~> 1.5.6'
gem 'gmaps4rails'
gem 'geocoder'

group :development do
  # To use debugger
  gem 'debugger'
end

group :development, :test do
  gem 'rspec-rails', '>= 2.11.0'
  gem 'factory_girl_rails', '>= 4.0.0'
end

group :test do
  gem 'capybara', '>= 1.1.2'
  gem 'email_spec', '>= 1.2.1'
  gem 'cucumber-rails', '>= 1.3.0', :require => false
  gem 'database_cleaner', '>= 0.8.0'
  gem 'launchy', '>= 2.1.2'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

