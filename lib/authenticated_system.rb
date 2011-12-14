module AuthenticatedSystem
  
  protected
  def login_required
    redirect_to main_app.new_refinery_user_session_path unless current_refinery_user
  end

end
