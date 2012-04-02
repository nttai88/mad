module AuthenticatedSystem

  protected
  def login_required
    redirect_to refinery.new_refinery_user_session_path unless current_refinery_user
  end

  def current_messaging_user
    current_refinery_user
  end

  def available_locals
    ['en','nb']
  end

  def current_url_with_locale(locale_key)
    # .sub("//", "/") is a temp fix (see https://github.com/rails/journey/pull/24)
    # TODO: remove when journey 1.0.4 gets released
    path = request.fullpath.sub("//", "/")
    if(path.include?("/#{I18n::locale}"))
      path.gsub /#{I18n::locale}/,"#{locale_key}"
    else
      "/#{locale_key}" << path
    end
  end
end
