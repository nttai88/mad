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
      url = request.url.sub(/([^:])\/\//, '\1/')

      if SECURE_CONTROLLERS.include?(controller_name) && !request.ssl?
        redirect_to url.sub(/^http:/, 'https:')
      elsif !SECURE_CONTROLLERS.include?(controller_name) && request.ssl?
        puts params[:locale], url, url.sub(/^https:/, 'http:').inspect, "====================="
        redirect_to url.sub(/^https:/, 'http:')
      end
    end
  end

end
