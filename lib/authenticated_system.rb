module AuthenticatedSystem

  protected

  def login_required
    redirect_to refinery.new_refinery_user_session_path unless current_refinery_user
  end

  def current_messaging_user
    current_refinery_user
  end

end
