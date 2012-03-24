module AuthenticatedSystem

  protected
  def login_required
    redirect_to main_app.new_refinery_user_session_path unless current_refinery_user
  end

  def current_messaging_user
    current_refinery_user
  end

  def available_locals
    ['en','nb']
  end

  def current_url_with_locale(locale_key)
    if(request.fullpath.include?("/#{I18n::locale}"))
      request.fullpath.gsub /#{I18n::locale}/,"#{locale_key}"
    else
      "/#{locale_key}"+request.fullpath
    end
  end
end
