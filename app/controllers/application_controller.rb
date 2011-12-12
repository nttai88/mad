class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def required_login
    redirect_to main_app.new_refinery_user_session_path unless current_refinery_user
  end

end
