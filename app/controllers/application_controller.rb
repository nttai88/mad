class ApplicationController < ActionController::Base
  USER_ID, PASSWORD = "admin", "admin123"
  SECURE_CONTROLLERS = ["sessions", "users", "confirmations", "passwords"]
  before_filter :basic_authenticate
  before_filter :force_ssl
  protect_from_forgery

  include AuthenticatedSystem
  
  helper_method :current_user
   
  private
  
  def current_user
    logger.debug "ApplicationController::current_user"
    return @current_user if defined?(@current_user)
    @current_user = current_refinery_user
  end

  protected
  def basic_authenticate
    authenticate_or_request_with_http_basic('Please enter username and password') do |id, password|
      id == USER_ID && password == PASSWORD
    end
  end

  private

  def force_ssl
    if Rails.env == 'production'
      if SECURE_CONTROLLERS.include?(controller_name) && !request.ssl?
        redirect_to request.url.gsub(/^http:/, "https:")
        return false;
      end
      if !SECURE_CONTROLLERS.include?(controller_name) && request.ssl?
        redirect_to request.url.gsub(/^https:/, "http:")
      end
    end
  end
end
