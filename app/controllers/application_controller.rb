class ApplicationController < ActionController::Base
  USER_ID, PASSWORD = "admin", "admin123"
  before_filter :basic_authenticate
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
end
