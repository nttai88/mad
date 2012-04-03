class ApplicationController < ActionController::Base
  SECURE_CONTROLLERS = ["sessions", "users", "confirmations", "passwords"]
  before_filter :force_ssl

  protect_from_forgery

  include AuthenticatedSystem
  include CommonHelpers

  helper_method :current_user, :available_locals, :current_url_with_locale

  private

  def current_user
    logger.debug "ApplicationController::current_user"
    return @current_user if defined?(@current_user)
    @current_user = current_refinery_user
  end

  def force_ssl
    if Rails.env.production?
      if SECURE_CONTROLLERS.include?(controller_name) && !request.ssl?
        redirect_to :protocol => "https://"
      end
      if !SECURE_CONTROLLERS.include?(controller_name) && request.ssl?
        redirect_to :protocol => "http://"
      end
    end
  end

end
