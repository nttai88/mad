module ApplicationHelper
  include CommonHelpers

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

  def visible_children(page)
    page = page.parent if page.parent
    page.children.live.in_menu
  end
end
