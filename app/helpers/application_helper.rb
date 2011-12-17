module ApplicationHelper
  def load_states(carmen_states)
    state_options = {"Default" => options_for_select(["", ""])}
    for i in 0...carmen_states.size
      country = carmen_states[i][0]
      states = carmen_states[i][1]
      state_options[country] = options_for_select(states)
    end
    javascript_tag("var states = #{state_options.to_json}")
  end
end
