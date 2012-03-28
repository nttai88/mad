Mad2::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true
  config.action_mailer.default_url_options = { :host => "localhost:3000" }
  
end


Refinery::Core.configure do |config|
  config.s3_backend = true
end

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['S3_KEY'] || "AKIAJTQFZ4U56OEW33WQ",
    :aws_secret_access_key  => ENV['S3_SECRET'] || "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"
  }
  config.fog_directory  = ENV['S3_BUCKET'] || "madlab.development"
  config.fog_host       = "http://#{ENV['S3_BUCKET']}.s3.amazonaws.com"
end

Excon.defaults[:ssl_verify_peer] = false