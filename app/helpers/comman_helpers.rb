module CommanHelpers
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
