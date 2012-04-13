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
        puts main_app.url_for(request.params.merge(:protocol => "https", :locale => I18n.locale)), "==================1===="
        redirect_to main_app.url_for(request.params.merge(:protocol => "https", :locale => I18n.locale))
      elsif !SECURE_CONTROLLERS.include?(controller_name) && request.ssl?
        puts request.params.inspect
        puts main_app.url_for(request.params.merge(:protocol => "http", :locale => I18n.locale)), "==================2====="
        redirect_to main_app.url_for(request.params.merge(:protocol => "http", :locale => I18n.locale))
      end
    end
  end

end
