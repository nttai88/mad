class ApplicationController < ActionController::Base
  USER_ID, PASSWORD = "admin", "admin123"
  before_filter :basic_authenticate
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
    if !request.ssl?
      redirect_to :protocol => 'https'
    end
  end
end
