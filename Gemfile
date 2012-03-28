source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
  gem "zurb-foundation", '~> 2.1.5.1'
end

group :development do
  gem 'sqlite3', '~> 1.3.5'
  gem 'mysql2', '~> 0.3.11'
  gem 'rails-dev-tweaks', '~> 0.6.0'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.8.1'
  gem 'capybara-webkit', '~> 0.9.0'
  gem 'factory_girl_rails', '~> 1.6.0'
  gem 'launchy', '~> 2.0.5'
  gem 'database_cleaner', '~> 0.7.1'
  gem 'ruby-debug19',:require=> 'ruby-debug'
end

group :production do
  gem "pg", '~> 0.12.2'
  gem 'therubyracer-heroku', '0.8.1.pre3'
  gem 'newrelic_rpm'
end

gem 'jquery-rails', '~> 1.0.19'
gem 'ajaxful_rating', '>= 3.0.0.beta3'
gem 'rmagick', '~> 2.13.1'
gem 'carrierwave', '~> 0.5.8'
gem 'fog', '~> 1.1.2'
gem "carmen", "~> 0.2.12"
gem "simple_form", '~> 1.5.2'
gem 'mailboxer', :path => 'vendor/engines/mailboxer'
gem 'messaging', :git => 'git://github.com/frodefi/rails-messaging.git'
gem 'sunspot_solr', '~> 1.3.0'
gem 'thin', '~> 1.3.1'
gem "attr_encrypted", "~> 1.2.0"
gem 'state_machine', '~> 1.1.2'

# Add i18n support (optional, you can remove this if you really want to but it is advised to keep it).
gem 'i18n-js', :git => 'git://github.com/fnando/i18n-js.git'
gem 'refinerycms-i18n', :git => "git://github.com/parndt/refinerycms-i18n.git", :ref => "859388f33017591a176788f48975ce7fcb67eee1"
gem "refinerycms", :git => "git://github.com/resolve/refinerycms.git", :ref => "cd94008a5e3104dd2d650a5ef3ba70b1b4b89a3f"
gem 'refinerycms-inquiries', :git => 'git://github.com/resolve/refinerycms-inquiries.git', :ref => 'bb4827422d04bca56ad55bb38f7c0bd7bb45e280'
gem 'refinerycms-news', :git => 'git://github.com/resolve/refinerycms-news.git', :ref => '66db97c724a604e7565188a42cdde28d48ac89f2'
#  gem 'refinerycms-blog', :git => 'git://github.com/resolve/refinerycms-blog.git', :branch => 'rails-3-1'
#  gem 'refinerycms-search', :git => 'git://github.com/resolve/refinerycms-search.git', :branch => 'rails-3-1'
#  gem 'refinerycms-page-images', :git => 'git://github.com/resolve/refinerycms-page-images.git', :branch => 'rails-3-1'
