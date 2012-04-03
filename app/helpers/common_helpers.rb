module CommonHelpers
  def available_locals
    ['en','nb']
  end

  def current_url_with_locale(locale_key)
    # .sub("//", "/") is a temp fix (see https://github.com/rails/journey/pull/24)
    # TODO: remove when journey 1.0.4 gets released
    path = request.fullpath.sub("//", "/")
    if path.include?("/#{I18n::locale}")
      path.gsub /#{I18n::locale}/,"#{locale_key}"
    else
      "/#{locale_key}" << path
    end
  end

  def colored_title(menu_item)
    return unless menu_item.downcase == 'playground'

    colors = %w(1a58b5 000 df4016 000 53bc57 000 e9e721 df4016 1a58b5 000)
    letters = menu_item.split('')

    string = '<strong>'
    letters.each_with_index do |letter, i|
      string << "<font color='##{colors[i]}'>#{letter}</font>"
    end
    string << '</strong>'
    string.html_safe
  end
end
