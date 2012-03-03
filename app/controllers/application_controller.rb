class ApplicationController < ActionController::Base
  SECURE_CONTROLLERS = ["sessions", "users", "confirmations", "passwords"]
  before_filter :force_ssl
  before_filter :set_locale

  protect_from_forgery

  include AuthenticatedSystem

  helper_method :current_user

  private

  def current_user
    logger.debug "ApplicationController::current_user"
    return @current_user if defined?(@current_user)
    @current_user = current_refinery_user
  end

  def force_ssl
    if Rails.env.production?
      if SECURE_CONTROLLERS.include?(controller_name) && !request.ssl?
        redirect_to request.url.gsub(/^http:/, "https:")
        return false;
      end
      if !SECURE_CONTROLLERS.include?(controller_name) && request.ssl?
        redirect_to request.url.gsub(/^https:/, "http:")
      end
    end
  end

  def set_locale
   # if params[:locale] is nil then I18n.default_locale will be used
    I18n.locale = :nb#params[:locale]
    debugger
    p "d"
  end
end
