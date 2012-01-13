class ApplicationController < ActionController::Base
  USER_ID, PASSWORD = "admin", "admin123"
  SECURE_CONTROLLERS = ["sessions", "users", "confirmations", "passwords"]
  before_filter :basic_authenticate
  before_filter :force_ssl
  protect_from_forgery

  include AuthenticatedSystem

  protected
  def basic_authenticate
    authenticate_or_request_with_http_basic('Please enter username and password') do |id, password|
      id == USER_ID && password == PASSWORD
    end
  end

  private

  def force_ssl
    if SECURE_CONTROLLERS.include?(controller_name) && !request.ssl?# && Rails.env == 'production'
      redirect_to request.url.gsub(/^http:/, "https:")
      return false;
    end

  end

  def default_url_options(options)
    defaults = {}
    # This will OVERRIDE only_path => true, not just set the default.
    options[:only_path] = false
    # Now set the default protocol appropriately:
    if SECURE_CONTROLLERS.include?(controller_name)
      defaults[:protocol] = 'https://'
    else
      defaults[:protocol] = 'http://'
    end
    return defaults
  end
end
