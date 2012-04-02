module ApplicationHelper
  include CommanHelpers
  def states_by_country
    state_options = {}
    Carmen::country_codes.each do |country|
      states = Carmen::states(country) rescue []
      state_options[country] = options_for_select(states)
    end
    javascript_tag("var states = #{state_options.to_json}")
  end

  def has_state?(country_code)
    begin
      Carmen::states(country_code)
      return true
    rescue
      return false
    end
  end

  def nice_time time
    time.strftime("%b %d, %Y at %l:%m %p")
  end

  def subpage_links_for(page)
    "ff"
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

  def visible_children(page)
    page = page.parent if page.parent
    page.children.live.in_menu
  end
end
