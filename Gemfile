source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

gem 'ajaxful_rating', '>= 3.0.0.beta3'
gem "zurb-foundation", :group => :assets

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'
gem 'rmagick'
gem 'carrierwave'
gem 'fog'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false
end
# Add i18n support (optional, you can remove this if you really want to but it is advised to keep it).
gem 'i18n-js', :git => 'git://github.com/fnando/i18n-js.git'
gem 'refinerycms-i18n',   '~> 2.0.0', :git => 'git://github.com/parndt/refinerycms-i18n.git'
gem "refinerycms", :git => "git://github.com/resolve/refinerycms.git"
 
#  group :development, :test do
#    gem 'refinerycms-testing', '~> 2.0'
#  end

group :development do
  gem 'sqlite3'
  gem 'mysql2'
  gem 'rails-dev-tweaks', '~> 0.5.0'
  # see https://github.com/wavii/rails-dev-tweaks/issues/3
  gem 'routing-filter', :git => 'git://github.com/nevir/routing-filter.git'
end

# USER DEFINED

# Specify additional Refinery CMS Engines here (all optional):
#  gem 'refinerycms-blog', :git => 'git://github.com/resolve/refinerycms-blog.git', :branch => 'rails-3-1'
gem 'refinerycms-inquiries', :git => 'git://github.com/resolve/refinerycms-inquiries.git', :branch => 'rails-3-1'
gem 'refinerycms-news', :git => 'git://github.com/resolve/refinerycms-news.git', :branch => 'rails-3-1'
#  gem 'refinerycms-search', :git => 'git://github.com/resolve/refinerycms-search.git', :branch => 'rails-3-1'
#  gem 'refinerycms-page-images', :git => 'git://github.com/resolve/refinerycms-page-images.git', :branch => 'rails-3-1'

#gem "refinerycms-news", '~> 2.0.0'
#gem 'refinerycms-inquiries', '~> 2.0.0'

# END USER DEFINED
gem "carmen", "~> 0.2.12" 

gem "simple_form"
gem "zurb-foundation", :group => :assets
gem 'mailboxer', :git => 'git://github.com/dickeytk/mailboxer.git'
gem 'messaging', :git => 'git://github.com/frodefi/rails-messaging.git'
gem 'sunspot_solr'

gem 'thin'

gem "attr_encrypted", "~> 1.2.0"
group :production do
  gem "pg"
  gem 'therubyracer-heroku', '0.8.1.pre3'
end