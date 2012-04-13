class ApplicationController < ActionController::Base
  SECURE_CONTROLLERS = ["sessions", "users", "confirmations", "passwords", "projects", "members", "sections"]
  before_filter :force_ssl

  protect_from_forgery

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
      # this is a temp fix (see https://github.com/rails/journey/pull/24)
      # TODO: remove when journey 1.0.4 gets released
      if SECURE_CONTROLLERS.include?(controller_name) && !request.ssl?
        redirect_to refinery.url_for(request.params.merge(:protocol => "https"))
      elsif !SECURE_CONTROLLERS.include?(controller_name) && request.ssl?
        redirect_to refinery.url_for(request.params.merge(:protocol => "http"))
      end
    end
  end

end
